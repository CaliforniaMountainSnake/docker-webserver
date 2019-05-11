#!make
include .env
export
.DEFAULT_GOAL := help

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: chown-logs ## Start all containers
	docker-compose up -d --build

down: ## Stop all containers
	docker-compose down

restart: down up ## Restart all started containers

it-nginx: ## Get into the Nginx container terminal
	docker exec -it ${CONTAINER_NAME_NGINX} bash

it-php: ## Get into the php-fpm container terminal
	docker exec -it ${CONTAINER_NAME_PHPFPM} bash

it-mysql: ## Get into the MySQL container terminal
	docker exec -it ${CONTAINER_NAME_MYSQL} bash

it-phpmyadmin: ## Get into the Php-MyAdmin container terminal
	docker exec -it ${CONTAINER_NAME_PHPMYADMIN} sh

it-cron: ## Get into the CRON container terminal
	docker exec -it ${CONTAINER_NAME_CRON} bash

chown-logs: ## Set needed access rights to the logs directory
	chown -R 999:999 logs/

example-in-container: ## Example shows how you can run any command inside any contaier
	docker exec ${CONTAINER_NAME_PHPFPM} /bin/sh -c "cd /var/www/ && php --version"

clear-mysql: down ## Clear all files inside the mysql directory.
	rm -r mysql_files/*
