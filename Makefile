# Makefile

# Define the default target
.DEFAULT_GOAL := help

# Variables
DOCKER_COMPOSE := docker-compose               # Command for Docker Compose
DOCKER_COMPOSE_FILE := srcs/docker-compose.yml  # Path to Docker Compose file

# Targets
# 	Display available targets
# - Set up the entire application using Docker"
# - Clean up resources (stop and remove Docker containers)"
# - Display this help message"
.PHONY: help
help:
	@echo "Available targets:"               
	@echo "  setup      
	@echo "  clean      
	@echo "  help       

# Build Docker images
# Start Docker containers in the background
.PHONY: setup
setup:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build  
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d  

.PHONY: clean
clean:
	@$(DOCKER_COMPOSE) down
