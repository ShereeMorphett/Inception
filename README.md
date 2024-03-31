# Inception Project

This project aims to dockerize a web service environment by configuring Docker containers for NGINX, WordPress with php-fpm, and MariaDB. The project strictly follows certain guidelines for performance and deployment, as outlined below:

## Project Requirements

- Each Docker image must have the same name as its corresponding service.
- Each service runs in a dedicated container.
- Containers must be built from either the penultimate stable version of Alpine or Debian.
- Dockerfiles must be written for each service and called in the docker-compose.yml by the Makefile.
- Ready-made Docker images and DockerHub services are forbidden (except for Alpine/Debian).
- Set up the following:
  - Docker container for NGINX with TLSv1.2 or TLSv1.3 only.
  - Docker container for WordPress + php-fpm (without nginx).
  - Docker container for MariaDB (without nginx).
  - Volume for WordPress database.
  - Second volume for WordPress website files.
  - Docker network to establish communication between containers.

## Getting Started

To get started with the project, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the root directory of the project.
3. Build the Docker images using the provided Dockerfiles and Makefile.
4. Run `docker-compose up` to start the containers.
5. Access the services through their respective endpoints.

## Project Structure

The project is organized as follows:

- **docker-compose.yml**: Defines the services, networks, and volumes for Docker containers.
- **Makefile**: Used to build Docker images and run common tasks.
- **nginx/**: Contains NGINX configuration files.
- **wordpress/**: Contains WordPress configuration files.
- **mariadb/**: Contains MariaDB configuration files.
- **data/**: Volume for WordPress database.
- **website/**: Volume for WordPress website files.
