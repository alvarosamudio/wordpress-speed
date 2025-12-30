# 🚀 WordPress Speed - High-Performance Stack

[![Docker Hub](https://img.shields.io/badge/docker-hub-blue.svg)](https://hub.docker.com/r/alvarolsamudio/wordpress-speed)
[![Architecture](https://img.shields.io/badge/architecture-nginx--fpm--redis-green.svg)](#architecture)

A highly optimized WordPress stack designed for speed, scalability, and ease of use. This project moves away from traditional monolithic setups to a modern, containerized architecture using Nginx, PHP-FPM, MariaDB, and Redis.

## 🏗️ Architecture

- **Web Server**: [Nginx (Alpine)](https://nginx.org/) - Configured as a high-speed reverse proxy with static file caching.
- **PHP Processor**: [PHP 8.3-FPM (Alpine)](https://www.php.net/) - Ultra-lightweight and tuned with `Opcache` best practices.
- **Database**: [MariaDB](https://mariadb.org/) - Robust and reliable relational database.
- **Object Cache**: [Redis](https://redis.io/) - Pre-configured and enabled for dramatic reduction in database queries.
- **Automation**: [WP-CLI](https://wp-cli.org/) - Automated installation, localization (Spanish), and performance plugin management.

## ⚡ Key Features

- **Automated Setup**: Installs WordPress and essential performance plugins automatically.
- **Performance Tuned**: Optimized `php.ini` and `nginx.conf` settings for low Time to First Byte (TTFB).
- **Health Monitoring**: Integrated healthchecks for all services.
- **Redis Ready**: Native support for object caching out of the box.
- **Spanish Localized**: Automatically sets the site language to Spanish.

## 🚀 Getting Started

### Prerequisites
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 1. Configure Environment
Clone the repository and create your `.env` file:
```bash
cp .env.example .env
```
Edit `.env` to set your desired credentials and site title.

### 2. Launch Stack
Start all services in detached mode:
```bash
docker compose up -d
```

### 3. Automated Installation
Once the containers are up and healthy, run the initialization script via WP-CLI:
```bash
docker compose run --rm wp-cli sh /scripts/install-wp.sh
```

Your site is now available at [http://localhost:8080](http://localhost:8080)!

## 🐳 Docker Hub usage

This project is automatically published to Docker Hub. You can use the optimized WordPress image directly in your own `docker-compose.yml`:

```yaml
services:
  wordpress:
    image: alvarolsamudio/wordpress-speed:latest
    # ... other config
```

### CI/CD - Automated Publishing
Every push to the `master` branch or new version tag (`v*.*.*`) triggers a GitHub Action that:
1.  Builds the optimized `fpm-alpine` image.
2.  Performs security signing with `cosign`.
3.  Pushes the image to **docker.io/alvarolsamudio/wordpress-speed**.

> [!NOTE]
> If you fork this repo, ensure you set `DOCKER_HUB_USERNAME` and `DOCKER_HUB_TOKEN` in your GitHub Secrets.

## 🛠️ Customization

- **Plugins**: The setup automatically installs `redis-cache`, `autoptimize`, `wp-optimize`, and `query-monitor`.
- **PHP Settings**: Tweak server parameters in `php/conf.d/speed.ini`.
- **Docker Hub**: Configured for automated publishing via GitHub Actions.

## 👥 Maintenance
- **Maintainer**: Alvaro Samudio ([@alvarosamudio](https://github.com/alvarosamudio))
- **Email**: alvarosamudio@protonmail.com
