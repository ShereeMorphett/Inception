# Makefile

# Define the default target
.DEFAULT_GOAL := help

# Variables
ENV_FILE	=	./srcs/.env
DOCKER_COMPOSE := docker-compose --env-file $(ENV_FILE)      # Command for Docker Compose

DOCKER_COMPOSE_FILE := srcs/docker-compose.yml              # Path to Docker Compose file
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Targets
# Display available targets:
# - Set up the entire application using Docker
# - Clean up resources (stop and remove Docker containers)
# - Display this help message
.PHONY: help
help:
	@echo $(YELLOW) "Available targets:"               
	@echo "  setup      - Set up the entire application using Docker"
	@echo "  clean      - Clean up resources (stop and remove Docker containers)"
	@echo "  help       - Display this help message"
	@echo "  Debug      - Display the compose content and attempt to build containers"
	@echo "  Total clean      - Clean up resources (stop, remove Docker containers AND delete volumes)"


.PHONY: create_dirs
create_dirs:
	# @mkdir -p /Users/smorphet/data/temp_volumes/mariadb-data /Users/smorphet/data/temp_volumes/wordpress-data
	@mkdir -p /home/smorphet/data/temp_volumes/mariadb-data /home/smorphet/data/temp_volumes/wordpress-data

# Build Docker images and start Docker containers in the background
.PHONY: setup
setup: create_dirs
	@echo $(GREEN) "Building and starting containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p inception build
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p inception up #-d

.PHONY: restart
restart: clean setup
	@echo $(GREEN) "Containers restarted successfully" $(NC)

#Debugging compose file
.PHONY: debug
debug: 
	@echo $(RED) "Docker Compose file content:" $(NC)
	@cat $(DOCKER_COMPOSE_FILE)
	@echo $(GREEN) "Building and starting containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p inception build
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p inception up -d

.PHONY: clean
clean:
	@echo $(YELLOW) "Stopping and removing Docker containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p inception down

.PHONY: fclean
fclean: clean
	@echo $(YELLOW) "Removing temp_volumes directory..." $(NC)
	@rm -rf /Users/smorphet/data/temp_volumes
