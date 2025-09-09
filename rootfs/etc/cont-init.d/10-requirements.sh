#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Endurian
# Check addon configuration and requirements
# ==============================================================================

bashio::log.info "Checking Endurian addon requirements..."

# Check if PostgreSQL configuration is provided
if ! bashio::config.has_value 'postgres_host'; then
    bashio::exit.nok "PostgreSQL host is required but not configured!"
fi

if ! bashio::config.has_value 'postgres_user'; then
    bashio::exit.nok "PostgreSQL user is required but not configured!"
fi

# Check if password is provided (allow empty for now, will be handled by app)
if ! bashio::config.has_value 'postgres_password'; then
    bashio::log.warning "PostgreSQL password not configured - this may cause connection issues"
fi

if ! bashio::config.has_value 'postgres_db'; then
    bashio::exit.nok "PostgreSQL database name is required but not configured!"
fi

# Check if secret key is provided (allow empty for now, will be handled by app)
if ! bashio::config.has_value 'secret_key'; then
    bashio::log.warning "Secret key not configured - this may cause security issues"
fi

# Create required directories
bashio::log.info "Creating required directories..."
mkdir -p /config/endurian
mkdir -p /share/endurian/uploads
mkdir -p /var/log/endurian

# Set proper permissions
chown -R endurian:endurian /config/endurian
chown -R endurian:endurian /share/endurian
chown -R endurian:endurian /var/log/endurian

bashio::log.info "Requirements check completed successfully!"
