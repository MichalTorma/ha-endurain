# Changelog

All notable changes to this add-on will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-12-XX

### Added

- Initial release of Endurian Fitness Tracker add-on
- Support for all major architectures (amd64, aarch64, armv7, armhf, i386)
- Self-hosted fitness tracking application based on Endurian v0.14.0
- External PostgreSQL database support for data persistence
- Configurable CORS settings for web interface access
- File upload support for workout data and media
- RESTful API for integration with Home Assistant
- Comprehensive logging with adjustable verbosity
- Modern Vue.js frontend with responsive design
- FastAPI backend with Python 3.13 Alpine base
- Multi-worker support for performance scaling
- Secure configuration with required secret key
- Home Assistant add-on best practices implementation
- Detailed documentation and configuration examples

### Security

- Secure default configuration with authentication required
- AppArmor profile for enhanced security
- Secret key requirement for application security
- CORS configuration for controlled web access
- Secure file upload handling with size limits

### Features

- **Fitness Tracking**: Comprehensive workout and activity monitoring
- **Data Privacy**: Self-hosted solution for complete data control
- **Database Integration**: PostgreSQL support for reliable data storage
- **Web Interface**: Modern, responsive user interface
- **API Access**: RESTful API for programmatic data access
- **File Management**: Upload and manage workout files and media
- **Multi-Architecture**: Runs on all Home Assistant supported platforms
