#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Endurian
# Configure Endurian application
# ==============================================================================

bashio::log.info "Configuring Endurian..."

# Get configuration values
POSTGRES_HOST=$(bashio::config 'postgres_host')
POSTGRES_PORT=$(bashio::config 'postgres_port')
POSTGRES_USER=$(bashio::config 'postgres_user')
POSTGRES_PASSWORD=$(bashio::config 'postgres_password')
POSTGRES_DB=$(bashio::config 'postgres_db')
POSTGRES_SCHEMA=$(bashio::config 'postgres_schema')
SECRET_KEY=$(bashio::config 'secret_key')
BEHIND_PROXY=$(bashio::config 'behind_proxy')
CORS_ORIGINS=$(bashio::config 'cors_origins')
CORS_METHODS=$(bashio::config 'cors_methods')
CORS_HEADERS=$(bashio::config 'cors_headers')
LOG_LEVEL=$(bashio::config 'log_level')
DEBUG=$(bashio::config 'debug')
WORKERS=$(bashio::config 'workers')
BIND_HOST=$(bashio::config 'bind_host')
BIND_PORT=$(bashio::config 'bind_port')
UPLOAD_FOLDER=$(bashio::config 'upload_folder')
MAX_CONTENT_LENGTH=$(bashio::config 'max_content_length')
APP_TITLE=$(bashio::config 'app_title')
APP_DESCRIPTION=$(bashio::config 'app_description')
APP_VERSION=$(bashio::config 'app_version')

# Create environment file for Endurian
bashio::log.info "Creating environment configuration..."
cat > /app/backend/.env << EOF
# Database configuration
POSTGRES_HOST=${POSTGRES_HOST}
POSTGRES_PORT=${POSTGRES_PORT}
POSTGRES_USER=${POSTGRES_USER}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_DB=${POSTGRES_DB}
POSTGRES_SCHEMA=${POSTGRES_SCHEMA}

# Application configuration
SECRET_KEY=${SECRET_KEY}
BEHIND_PROXY=${BEHIND_PROXY}
CORS_ORIGINS=${CORS_ORIGINS}
CORS_METHODS=${CORS_METHODS}
CORS_HEADERS=${CORS_HEADERS}

# Logging and debugging
LOG_LEVEL=${LOG_LEVEL}
DEBUG=${DEBUG}

# Server configuration
WORKERS=${WORKERS}
BIND_HOST=${BIND_HOST}
BIND_PORT=${BIND_PORT}

# File upload configuration
UPLOAD_FOLDER=${UPLOAD_FOLDER}
MAX_CONTENT_LENGTH=${MAX_CONTENT_LENGTH}

# App metadata
APP_TITLE=${APP_TITLE}
APP_DESCRIPTION=${APP_DESCRIPTION}
APP_VERSION=${APP_VERSION}

# Additional environment variables
UID=8080
GID=8080
EOF

# Set proper ownership and permissions
chown endurain:endurain /app/backend/.env
chmod 600 /app/backend/.env

# Create upload directory if it doesn't exist
mkdir -p "${UPLOAD_FOLDER}"
chown -R endurain:endurain "${UPLOAD_FOLDER}"

# Test PostgreSQL connection
bashio::log.info "Testing PostgreSQL connection..."
export PGPASSWORD="${POSTGRES_PASSWORD}"
if ! timeout 10 bash -c "echo > /dev/tcp/${POSTGRES_HOST}/${POSTGRES_PORT}"; then
    bashio::log.warning "Cannot connect to PostgreSQL at ${POSTGRES_HOST}:${POSTGRES_PORT}"
    bashio::log.warning "Please ensure PostgreSQL is running and accessible"
    bashio::log.warning "Endurian will attempt to connect on startup"
fi

bashio::log.info "Endurian configuration completed!"
