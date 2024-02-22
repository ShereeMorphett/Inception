# Makefile

# Define the default target
.DEFAULT_GOAL := help

# Variables
ENV_FILE	=	./srcs/.env
DOCKER_COMPOSE := docker compose --env-file $(ENV_FILE)      # Command for Docker Compose
DATA_PATH = /home/smorphet/data
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
	@echo "  fclean      - Clean up resources (stop, remove Docker containers AND delete volumes)"

.PHONY: create_dirs
create_dirs:
	@mkdir -p /home/smorphet/data/mariadb-data /home/smorphet/data/wordpress-data

# Build Docker images and start Docker containers in the background
.PHONY: setup
setup: create_dirs
	@sudo pkill docker-pr || true
	@echo $(GREEN) "Building and starting containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d
	@echo $(GREEN) "Containers restarted successfully" $(NC)

.PHONY: restart
restart: down setup
	@echo $(GREEN) "Containers restarted successfully" $(NC)

#Debugging compose file
.PHONY: debug
debug: 
	@echo $(RED) "Docker Compose file content:" $(NC)
	@cat $(DOCKER_COMPOSE_FILE)
	@echo $(GREEN) "Building and starting containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

.PHONY: down
down:
	@echo $(YELLOW) "Stopping and removing Docker containers..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
	@sudo pkill docker-pr || true


.PHONY: fclean
fclean: down
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)/mariadb-data $(DATA_PATH)/wordpress-data

.PHONY: logs
logs:
	@echo $(YELLOW) "Watching logs..." $(NC)
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f
