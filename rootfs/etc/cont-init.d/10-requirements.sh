#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Endurain
# Check addon configuration and requirements
# ==============================================================================

bashio::log.info "Checking Endurain addon requirements..."

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
mkdir -p /config/endurain
mkdir -p /share/endurain/uploads
mkdir -p /var/log/endurain

# Set proper permissions
chown -R endurain:endurain /config/endurain
chown -R endurain:endurain /share/endurain
chown -R endurain:endurain /var/log/endurain

bashio::log.info "Requirements check completed successfully!"
