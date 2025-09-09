# Home Assistant Add-on: Endurian Fitness Tracker

A self-hosted fitness tracking application for monitoring workouts, activities, and fitness progress.

## Installation

1. Navigate to **Settings** → **Add-ons** → **Add-on Store** in your Home Assistant frontend.
2. Add this repository if not already added.
3. Install the "Endurian Fitness Tracker" add-on.
4. Configure the add-on (see configuration options below).
5. Start the add-on.

## Configuration

Add-on configuration:

```yaml
endurian_version: "v0.14.0"
app_title: "Endurian Fitness Tracker"
app_description: "Self-hosted fitness tracking application"
app_version: "0.14.0"
postgres_host: "localhost"
postgres_port: 5432
postgres_user: "endurian"
postgres_password: "your-secure-password"
postgres_db: "endurian"
postgres_schema: "public"
secret_key: "your-very-long-and-secure-secret-key"
behind_proxy: false
cors_origins: "*"
cors_methods: "GET,POST,PUT,DELETE"
cors_headers: "*"
log_level: "INFO"
debug: false
workers: 1
bind_host: "0.0.0.0"
bind_port: 8080
upload_folder: "/share/endurian/uploads"
max_content_length: 16777216
```

### Configuration Options

#### Application Information

- **endurian_version**: Version of Endurian to install (default: "v1.7.5")
- **app_title**: Application title displayed in the interface
- **app_description**: Application description
- **app_version**: Application version string

#### Database Configuration

**PostgreSQL Connection (Required)**

You must configure an external PostgreSQL database. This can be:
- A PostgreSQL add-on running in Home Assistant
- An external PostgreSQL server
- A cloud-hosted PostgreSQL instance

```yaml
postgres_host: "your-postgres-host"
postgres_port: 5432
postgres_user: "endurian"
postgres_password: "your-secure-password"
postgres_db: "endurian"
postgres_schema: "public"
```

**Database Setup**

Before starting the add-on, ensure:
1. PostgreSQL server is running and accessible
2. Database and user exist with proper permissions
3. User can create/modify tables in the specified database

Example PostgreSQL setup:
```sql
CREATE DATABASE endurian;
CREATE USER endurian WITH ENCRYPTED PASSWORD 'your-secure-password';
GRANT ALL PRIVILEGES ON DATABASE endurian TO endurian;
```

#### Security Settings

**Secret Key (Required)**
```yaml
secret_key: "your-very-long-and-secure-secret-key"
```
Generate a strong secret key using:
```bash
openssl rand -hex 32
```

**Proxy Configuration**
```yaml
behind_proxy: true
```
Set to `true` when using Home Assistant ingress (recommended) or when running behind a reverse proxy (like NGINX Proxy Manager). This should be `true` for proper sidebar integration.

#### CORS Configuration

For web interface access through Home Assistant ingress:
```yaml
cors_origins: "*"  # Allow all origins for ingress compatibility
cors_methods: "GET,POST,PUT,DELETE"
cors_headers: "*"
```

**Ingress Support**: The addon automatically detects Home Assistant ingress and configures the FastAPI application with proper middleware to handle path rewriting and proxy headers.

#### Server Configuration

```yaml
bind_host: "0.0.0.0"  # Listen on all interfaces
bind_port: 8080       # Web interface port
workers: 1            # Number of worker processes
```

**Performance Tuning**
- **workers**: Increase for high-traffic setups (max: number of CPU cores)
- Keep at 1 for typical Home Assistant use

#### File Upload Settings

```yaml
upload_folder: "/share/endurian/uploads"  # Upload directory
max_content_length: 16777216              # Max file size (16MB)
```

The upload folder will be created automatically in Home Assistant's `/share` directory.

#### Logging Configuration

```yaml
log_level: "INFO"  # DEBUG, INFO, WARNING, ERROR, CRITICAL
debug: false       # Enable debug mode
```

**Debug Mode**
- Enables detailed logging
- Shows stack traces
- Useful for troubleshooting

## Network Configuration

The add-on exposes port 8080 for the web interface.

**Access Methods:**
- Direct: `http://homeassistant-ip:8080`
- Through Home Assistant: Configure ingress or proxy
- Reverse Proxy: Use NGINX Proxy Manager or similar

## Data Persistence

**Database**: All application data is stored in the configured PostgreSQL database.

**File Uploads**: Stored in `/share/endurian/uploads` (persists across add-on updates).

**Configuration**: Addon settings are preserved in Home Assistant.

## Troubleshooting

### Common Issues

**Cannot connect to PostgreSQL**
1. Verify PostgreSQL is running
2. Check host/port configuration
3. Ensure database and user exist
4. Verify firewall/network settings

**Web interface not accessible**
1. Check add-on logs for errors
2. Verify port 8080 is not blocked
3. Ensure add-on is fully started

**File upload issues**
1. Check upload folder permissions
2. Verify `max_content_length` setting
3. Ensure sufficient disk space

### Log Analysis

Enable debug mode for detailed logs:
```yaml
debug: true
log_level: "DEBUG"
```

**Log Locations:**
- Add-on logs: Home Assistant Add-on page
- Application logs: `/var/log/endurian/` (if configured)

### Database Migration

When upgrading Endurian versions, the application will automatically handle database schema migrations.

**Backup Recommendation:**
Always backup your PostgreSQL database before major updates.

## Support

For issues and questions:
1. Check the [GitHub repository][github]
2. Review [Endurian documentation][endurian-docs]
3. Open an issue if needed

## Security Considerations

1. **Use strong passwords** for PostgreSQL
2. **Set a secure secret key** (32+ character random string)
3. **Configure CORS properly** for production use
4. **Use HTTPS** when accessing from external networks
5. **Keep the add-on updated** for security patches

## Advanced Configuration

### Environment Variables

The add-on creates a `.env` file with all configuration. Advanced users can modify:

```yaml
# Custom environment variables can be set through the configuration
```

### Integration with Home Assistant

**Automations**: Use REST API to integrate fitness data with Home Assistant automations.

**Sensors**: Create template sensors based on Endurian API data.

**Notifications**: Set up notifications for workout milestones.

[github]: https://github.com/MichalTorma/ha-endurian
[endurian-docs]: https://github.com/joaovitoriasilva/endurain
