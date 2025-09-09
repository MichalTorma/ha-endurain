#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Endurain
# Displays a simple banner on startup
# ==============================================================================

# Only show banner when Hass.io API is available
if bashio::supervisor.ping; then
    # Only show when add-on log level is at trace or debug
    if bashio::config.has_value 'debug' && bashio::config.true 'debug'; then
        bashio::log.blue \
            '-----------------------------------------------------------'
        bashio::log.blue " Add-on: $(bashio::addon.name)"
        bashio::log.blue " $(bashio::addon.description)"
        bashio::log.blue \
            '-----------------------------------------------------------'
        bashio::log.blue " Add-on version: $(bashio::addon.version)"
        bashio::log.blue " Endurain version: $(bashio::config 'endurain_version')"
        bashio::log.blue \
            '-----------------------------------------------------------'
        bashio::log.blue " Please, share the above with the developers"
        bashio::log.blue " when reporting issues. Thank you!"
        bashio::log.blue \
            '-----------------------------------------------------------'
    fi
fi
