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

if ! bashio::config.has_value 'postgres_password' || bashio::config.is_empty 'postgres_password'; then
    bashio::exit.nok "PostgreSQL password is required but not configured!"
fi

if ! bashio::config.has_value 'postgres_db'; then
    bashio::exit.nok "PostgreSQL database name is required but not configured!"
fi

if ! bashio::config.has_value 'secret_key' || bashio::config.is_empty 'secret_key'; then
    bashio::exit.nok "Secret key is required but not configured! Please set a strong secret key."
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
