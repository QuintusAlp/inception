# Inception

A complete web infrastructure setup using Docker containers with NGINX, WordPress, and MariaDB, demonstrating containerization and system administration skills.

## About

Inception is a 42 School project focused on system administration and virtualization using Docker. The project requires building a complete web infrastructure from scratch using custom Docker images and Docker Compose orchestration. Each service runs in its own container, following best practices for containerization and security.

The infrastructure implements a classic web stack with reverse proxy, web application, and database layers, all containerized and orchestrated for production-like deployment.

## Architecture

### System Schema

<img width="607" alt="Capture d’écran 2025-06-12 à 22 51 26" src="https://github.com/user-attachments/assets/86a790b6-d10c-4f06-822c-f425385c1267" />


*Add your infrastructure diagram showing the connection between NGINX, WordPress, MariaDB containers and their network communication*

## Key Features

- **Custom Docker Images**: Hand-built Dockerfiles for each service (no pre-built images)
- **Multi-Container Architecture**: NGINX reverse proxy, WordPress application, MariaDB database
- **Docker Compose Orchestration**: Complete service orchestration and dependency management
- **Volume Management**: Persistent data storage for database and WordPress files
- **Network Security**: Isolated Docker networks and secure inter-container communication
- **SSL/TLS Configuration**: HTTPS implementation with SSL certificates
- **Environment Configuration**: Secure environment variable management
- **Service Health Checks**: Container health monitoring and restart policies

## Usage

### Prerequisites
- Docker
- Docker Compose
- Make

### Setup
```bash
# Clone the repository
git clone [your-repo-url]
cd inception

# Build and start all services
make

# Alternative: using docker-compose directly
docker-compose up --build
```

### Access Points
```bash
# WordPress site (HTTPS)
https://qalpesse.42.fr

# WordPress admin panel
https://qalpesse.42.fr/wp-admin
```

### Management Commands
```bash
# Start services
make

# Stop services
make clean

# Rebuild all containers
make re

# View logs
make logs

# Clean all containers and volumes
make fclean
```

### Services Overview

**NGINX Container:**
- Reverse proxy and web server
- SSL/TLS termination
- Static file serving
- Load balancing and caching

**WordPress Container:**
- PHP-FPM application server
- WordPress CMS installation
- Custom themes and plugins support
- Database connectivity

**MariaDB Container:**
- MySQL-compatible database server
- Persistent data storage
- User and database management
- Backup and recovery capabilities

## Technical Skills Demonstrated

- **Containerization**: Docker image creation and multi-container application design
- **System Administration**: Linux system configuration and service management
- **Web Server Configuration**: NGINX setup, SSL/TLS implementation, and reverse proxy configuration
- **Database Administration**: MariaDB setup, user management, and data persistence
- **DevOps Practices**: Infrastructure as code, service orchestration, and automated deployment
- **Network Security**: Container networking, firewall configuration, and secure communication
- **Configuration Management**: Environment variables, secrets management, and service configuration
- **Monitoring and Logging**: Service health checks and log management
- **Shell Scripting**: Automation scripts for deployment and maintenance
- **Documentation**: Infrastructure documentation and deployment procedures

