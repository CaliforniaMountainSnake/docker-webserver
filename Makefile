#!make
include .env
export
.DEFAULT_GOAL := help

# Detecting OS type.
# https://stackoverflow.com/a/14777895/10452175
ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

# Select the docker binary depending on the OS.
ifeq ($(detected_OS),Windows)
    docker_command := winpty docker
    docker_compose_command := winpty docker-compose
else
    docker_command := docker
    docker_compose_command := docker-compose
endif


help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## Start all containers
	$(docker_compose_command) up -d --build

down: ## Stop all containers
	$(docker_compose_command) down

restart: down up ## Restart all started containers

reinstall-full: down clear-mysql up ## Delete MySQL database and restart containers

test: composer-dump ## Run unit-tests
	$(docker_command) exec ${CONTAINER_NAME_PHPFPM} bash -c "vendor/bin/phpunit"

it-nginx: ## Get into the Nginx container terminal
	$(docker_command) exec -it ${CONTAINER_NAME_NGINX} bash

it-php: ## Get into the php-fpm container terminal
	$(docker_command) exec -it ${CONTAINER_NAME_PHPFPM} bash

it-mysql: ## Get into the MySQL container terminal
	$(docker_command) exec -it ${CONTAINER_NAME_MYSQL} bash

it-phpmyadmin: ## Get into the Php-MyAdmin container terminal
	$(docker_command) exec -it ${CONTAINER_NAME_PHPMYADMIN} sh

it-cron: ## Get into the CRON container terminal
	$(docker_command) exec -it ${CONTAINER_NAME_CRON} bash

composer-install: ## composer install
	$(docker_command) exec ${CONTAINER_NAME_PHPFPM} bash -c "composer install"

composer-update: ## composer update
	$(docker_command) exec ${CONTAINER_NAME_PHPFPM} bash -c "composer update"

composer-dump: ## composer dump-autoload
	$(docker_command) exec ${CONTAINER_NAME_PHPFPM} bash -c "composer dump-autoload"

clear-mysql: down ## Clear all files inside the mysql directory
	rm -r mysql_files/*

backup: ## Zip the project and save a backup archive in the parent directory
	zip -r ../backup_$(notdir $(shell pwd))_`date +'%Y.%m.%d_%H:%M:%S'`.zip .

rsync-to-remote: ## Sync to Remote server home directory from current directory
	rsync -vhra ./ root@5.23.52.70:/home/$(notdir $(shell pwd)) --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after

docker-remove-all-containers: ## WARNING! Stop and remove ALL docker containers
	clear && $(docker_command) stop `$(docker_command) ps -a -q` && $(docker_command) rm `$(docker_command) ps -a -q` && $(docker_command) ps -a

docker-remove-all-images: ## WARNING! Remove ALL docker images
	clear && $(docker_command) rmi `$(docker_command) images -q`
