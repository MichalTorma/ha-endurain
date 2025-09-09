# Home Assistant Add-on: Endurian Fitness Tracker

A Home Assistant add-on that provides Endurian, a self-hosted fitness tracking application with comprehensive workout and activity monitoring capabilities.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## About

Endurian is a modern, self-hosted fitness tracking application that allows you to monitor your workouts, activities, and fitness progress. This add-on provides an easy way to run Endurian within your Home Assistant environment with external PostgreSQL database support.

### Features

- **Comprehensive Fitness Tracking**: Monitor workouts, activities, and fitness metrics
- **Self-Hosted Solution**: Keep your fitness data private and under your control
- **PostgreSQL Database Support**: Use external PostgreSQL for data persistence
- **Modern Web Interface**: Clean and intuitive user interface
- **Multi-Architecture Support**: Runs on all major Home Assistant architectures
- **RESTful API**: Access your data programmatically
- **File Upload Support**: Store workout files and media

## Installation

1. Navigate in your Home Assistant frontend to **Settings** → **Add-ons** → **Add-on Store**.
2. Add this repository by clicking the menu in the top-right and selecting **Repositories**.
3. Add the URL: `https://github.com/MichalTorma/ha-repository`
4. Find the "Endurian Fitness Tracker" add-on and click it.
5. Click on the "INSTALL" button.

## How to use

1. **Set up PostgreSQL**: Ensure you have a PostgreSQL database available (can be external or another Home Assistant add-on).
2. **Configure the add-on**: Set the required PostgreSQL connection details and other settings.
3. **Start the add-on**: The application will be available on port 8080.
4. **Access the interface**: Open `http://your-home-assistant:8080` in your browser.

### Basic Configuration

The minimal configuration requires PostgreSQL connection details:

```yaml
postgres_host: "your-postgres-host"
postgres_port: 5432
postgres_user: "endurian"
postgres_password: "your-secure-password"
postgres_db: "endurian"
secret_key: "your-very-long-and-secure-secret-key"
```

### Advanced Configuration

For production use with custom settings:

```yaml
postgres_host: "your-postgres-host"
postgres_port: 5432
postgres_user: "endurian"
postgres_password: "your-secure-password"
postgres_db: "endurian"
postgres_schema: "public"
secret_key: "your-very-long-and-secure-secret-key"
behind_proxy: true
cors_origins: "https://your-domain.com"
log_level: "INFO"
debug: false
workers: 2
upload_folder: "/share/endurian/uploads"
max_content_length: 16777216
```

## Configuration

Add-on configuration:

```yaml
endurian_version: "v1.7.5"
postgres_host: "localhost"
postgres_port: 5432
postgres_user: "endurian"
postgres_password: ""
postgres_db: "endurian"
postgres_schema: "public"
secret_key: ""
behind_proxy: false
cors_origins: "*"
log_level: "INFO"
debug: false
workers: 1
upload_folder: "/share/endurian/uploads"
max_content_length: 16777216
```

### Configuration Options

#### Database Configuration

- **postgres_host**: PostgreSQL server hostname or IP address
- **postgres_port**: PostgreSQL server port (default: 5432)
- **postgres_user**: PostgreSQL username for Endurian
- **postgres_password**: PostgreSQL password (required)
- **postgres_db**: PostgreSQL database name for Endurian
- **postgres_schema**: PostgreSQL schema to use (default: "public")

#### Security

- **secret_key**: Secret key for application security (required, make it long and random)
- **behind_proxy**: Set to true if running behind a reverse proxy

#### CORS Configuration

- **cors_origins**: Allowed CORS origins (default: "*" for development)
- **cors_methods**: Allowed HTTP methods
- **cors_headers**: Allowed headers

#### Application Settings

- **log_level**: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
- **debug**: Enable debug mode (default: false)
- **workers**: Number of worker processes (default: 1)
- **upload_folder**: Directory for uploaded files
- **max_content_length**: Maximum file upload size in bytes

## Support

Got questions?

You could also [open an issue here][issue] on GitHub.

## Authors & contributors

The original setup of this repository is by [Michal Torma][michal].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2024 Michal Torma

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[contributors]: https://github.com/MichalTorma/ha-endurian/graphs/contributors
[issue]: https://github.com/MichalTorma/ha-endurian/issues
[michal]: https://github.com/MichalTorma