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

start: nginx-proxy-start nginx-proxy-letsencrypt-start up ## Start   all containers and proxies

stop: down nginx-proxy-letsencrypt-stop nginx-proxy-stop ## Stop    all containers and proxies

restart: stop start ## Restart all containers and proxies

reinstall-clean: stop clear-mysql start ## Delete MySQL database and restart all containers and proxies

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

clear-mysql: stop ## Clear all files inside the mysql directory
	rm -r mysql_files/*

backup: ## Zip the project and save a backup archive in the parent directory
	zip -r ../backup_$(notdir $(shell pwd))_`date +'%Y.%m.%d_%H:%M:%S'`.zip .

rsync-to-remote: ## Sync to remote server directory from current directory
	ssh ${REMOTE_SERVER_USER}@${REMOTE_SERVER_ADDRESS} -p ${REMOTE_SERVER_PORT} "mkdir -p $(patsubst "%",%,$(REMOTE_SERVER_PATH))" && rsync -vhra -e "ssh -p ${REMOTE_SERVER_PORT}" ./ ${REMOTE_SERVER_USER}@${REMOTE_SERVER_ADDRESS}:${REMOTE_SERVER_PATH} --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after

up: ## Only up   the main containers
	$(docker_compose_command) up -d --build

down: ## Only down the main containers
	$(docker_compose_command) down

nginx-proxy-start: ## Start nginx-proxy
	$(docker_command) network create nginx-proxy-network || true && $(docker_command) run -d -p 80:80 -p 443:443 --name nginx-proxy-container --net nginx-proxy-network --volume /etc/nginx/certs --volume /etc/nginx/vhost.d --volume /usr/share/nginx/html --volume /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

nginx-proxy-stop: ## Stop  nginx-proxy
	$(docker_command) stop nginx-proxy-container && $(docker_command) rm nginx-proxy-container && $(docker_command) network rm nginx-proxy-network

nginx-proxy-letsencrypt-start: ## Start letsencrypt-nginx-proxy-companion
	docker run --detach --name nginx-proxy-letsencrypt --volumes-from nginx-proxy-container --volume /var/run/docker.sock:/var/run/docker.sock:ro --env "DEFAULT_EMAIL=${LETSENCRYPT_EMAIL}" jrcs/letsencrypt-nginx-proxy-companion

nginx-proxy-letsencrypt-stop: ## Stop  letsencrypt-nginx-proxy-companion
	$(docker_command) stop nginx-proxy-letsencrypt && $(docker_command) rm nginx-proxy-letsencrypt

docker-ps: ## Show all running docker containers
	clear && $(docker_command) ps -a

docker-remove-all-containers: ## WARNING! Stop and remove ALL docker containers
	clear && $(docker_command) stop `$(docker_command) ps -a -q` && $(docker_command) rm `$(docker_command) ps -a -q` && $(docker_command) ps -a

docker-remove-all-images: ## WARNING! Remove ALL docker images
	clear && $(docker_command) rmi `$(docker_command) images -q`
