ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Build arguments
ARG BUILD_ARCH
ARG ENDURIAN_VERSION=v0.14.0

# Install base dependencies
RUN \
    apk add --no-cache \
        ca-certificates \
        tzdata \
        curl \
        wget \
        unzip \
        tar \
        jq \
        bash \
        python3 \
        py3-pip \
        nodejs \
        npm \
        git \
        build-base \
        python3-dev \
        libffi-dev \
        openssl-dev \
        gcc \
        musl-dev \
        postgresql-dev \
        postgresql-client \
        pkgconfig

# Create endurian user and directories
RUN \
    addgroup -g 8080 endurian \
    && adduser -D -s /bin/bash -u 8080 -G endurian endurian \
    && mkdir -p /app/frontend \
    && mkdir -p /app/backend \
    && mkdir -p /config/endurian \
    && mkdir -p /share/endurian/uploads \
    && mkdir -p /var/log/endurian

# Set working directory
WORKDIR /tmp

# Download and extract Endurian source
RUN \
    echo "Downloading Endurian ${ENDURIAN_VERSION}..." \
    && wget -O endurian.tar.gz "https://github.com/joaovitoriasilva/endurain/archive/refs/tags/${ENDURIAN_VERSION}.tar.gz" \
    && tar -xzf endurian.tar.gz --strip-components=1 \
    && rm endurian.tar.gz

# Build frontend
WORKDIR /tmp/frontend/app
RUN \
    echo "Building frontend..." \
    && npm ci --prefer-offline \
    && npm run build \
    && cp -r dist/* /app/frontend/

# Install Python dependencies in virtual environment
WORKDIR /tmp/backend
RUN \
    echo "Creating virtual environment and installing backend dependencies..." \
    && python3 -m venv /opt/venv \
    && . /opt/venv/bin/activate \
    && pip install --no-cache-dir --upgrade pip \
    && if [ -f pyproject.toml ]; then \
        pip install --no-cache-dir poetry \
        && poetry self add poetry-plugin-export \
        && poetry export -f requirements.txt --output requirements.txt --without-hashes; \
    fi \
    && if [ -f requirements.txt ]; then \
        echo "Filtering out MySQL dependencies and replacing with PostgreSQL..." \
        && sed -i '/^mysqlclient==/d' requirements.txt \
        && echo "psycopg2-binary>=2.9.0" >> requirements.txt \
        && pip install --no-cache-dir --upgrade -r requirements.txt; \
    fi

# Copy backend application
RUN \
    echo "Checking if backend app directory exists..." \
    && ls -la /tmp/backend/ \
    && if [ -d "app" ]; then \
        echo "Copying backend application files..." \
        && cp -r app/* /app/backend/ \
        && echo "Backend files copied successfully:" \
        && ls -la /app/backend/; \
    else \
        echo "No app directory found, copying all backend files..." \
        && cp -r . /app/backend/ \
        && echo "All backend files copied:" \
        && ls -la /app/backend/; \
    fi

# Set proper permissions
RUN \
    chown -R endurian:endurian /app \
    && chown -R endurian:endurian /config/endurian \
    && chown -R endurian:endurian /share/endurian \
    && chown -R endurian:endurian /var/log/endurian \
    && chown -R endurian:endurian /opt/venv \
    && chmod -R g+w /app \
    && chmod -R g+w /config/endurian \
    && chmod -R g+w /share/endurian \
    && chmod -R g+w /var/log/endurian

# Clean up build files
RUN \
    rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# Copy rootfs
COPY rootfs /

# Set working directory to backend
WORKDIR /app/backend

# Build arguments for labels
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Michal Torma <torma.michal@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Michal Torma <torma.michal@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/MichalTorma/ha-endurian" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s \
    CMD curl -f http://localhost:8080/api/v1/about || exit 1
