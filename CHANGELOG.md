# Changelog

All notable changes to this add-on will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-XX

### Changed
- **FINAL**: Switched to webui approach for reliable Home Assistant integration
- **BREAKING**: Disabled ingress due to incompatibility with Endurain's frontend architecture
- Removed nginx reverse proxy (not needed for webui)
- Simplified configuration for better stability and reliability

### Fixed
- Resolved all static asset loading issues by using webui instead of ingress
- Fixed sidebar integration - Endurain now opens in new tab/window via webui
- Eliminated NS_ERROR_CORRUPTED_CONTENT errors completely

### Technical Notes
- Endurain's frontend uses hardcoded absolute paths incompatible with ingress
- webui provides reliable access while maintaining Home Assistant integration
- Direct port access ensures all assets load correctly

### Removed
- Removed nginx reverse proxy configuration
- Removed complex ingress detection and root-path logic
- Simplified to direct uvicorn serving on port 8080

## [0.6.0] - 2024-12-XX

### Added
- **NEW**: nginx reverse proxy for robust ingress support
- Dedicated nginx service to handle Home Assistant ingress path rewriting
- Enhanced ingress debugging and logging

### Changed
- **ARCHITECTURE**: Endurain now runs on port 8081, nginx proxies on port 8080
- Replaced uvicorn --root-path approach with nginx-based solution
- Improved handling of static asset paths for SPA applications

### Fixed
- Fixed static asset loading issues with nginx path rewriting
- Resolved hardcoded absolute path problems in Endurain frontend
- Better ingress path detection and configuration

## [0.5.0] - 2024-12-XX

### Changed
- **BREAKING**: Replaced custom FastAPI middleware with native uvicorn `--root-path` support
- Simplified ingress implementation using uvicorn's built-in proxy support
- Removed complex middleware injection system in favor of standard uvicorn configuration

### Fixed
- Fixed static asset loading issues by using proper uvicorn root path configuration
- Resolved `NS_ERROR_CORRUPTED_CONTENT` errors with cleaner ingress implementation
- Improved reliability and performance of ingress integration

### Removed
- Removed custom ingress middleware (replaced with native uvicorn support)
- Removed dynamic main.py modification system
- Simplified codebase for better maintainability

## [0.4.1] - 2024-12-XX

### Fixed
- Fixed hardcoded CORS values in ingress middleware to use addon configuration
- Middleware now properly respects user's `cors_origins`, `cors_methods`, and `cors_headers` settings
- Improved configurability and customization of CORS settings for ingress

## [0.4.0] - 2024-12-XX

### Added
- **NEW**: Proper Home Assistant ingress support with FastAPI middleware
- Custom ingress middleware to handle X-Ingress-Path header rewriting
- Dynamic FastAPI app modification for ingress compatibility
- Automatic ingress detection and configuration

### Fixed
- Fixed ingress integration for proper Home Assistant sidebar embedding
- Resolved static asset loading issues with ingress proxy
- Added proper uvicorn proxy headers support (`--proxy-headers`, `--forwarded-allow-ips`)
- Configured `behind_proxy: true` for ingress environments

### Technical Improvements
- Implemented FastAPI middleware injection system
- Added automatic main.py modification for ingress support
- Enhanced uvicorn configuration for proxy environments
- Improved ingress path detection and environment variable handling

## [0.3.8] - 2024-12-XX

### Fixed
- Added webui directive to enable proper sidebar integration in Home Assistant
- Fixed issue where addon would work standalone but not appear in Home Assistant sidebar

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
