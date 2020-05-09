# Docker webserver configuration: Nginx, php-fpm, mysql, phpmyadmin, cron.
This is a docker-compose configuration intended for running a web server.


### Includes:
- Nginx 1.17.x.
- PHP 7.4.x with: imagick, gd, procps, composer, git. Optionally: xdebug, ffmpeg 4.2.2, nodejs.
- MySQL 8.0.x.
- PhpMyAdmin 5.0.x.
- CRON.


### Files structure:
- `/.docker_build_configs` - directories with Dockerfiles and configurations of the containers.
- `/logs` - various log files.
- `/www` - app directory, mounts to `/var/www`.
- `/www/public` - webserver root, mounts to `/var/www/public`.
So, php working directory is `/var/www`, but webserver root is `/var/www/public`


### Extra configuration:
You can additionally configure the server by edit the files stored inside `/.docker_build_configs`.
Such as nginx configuration, php.ini, xdebug.ini, mysql.cnf, phpmyadmin config, etc.


### INSTALL:
1. Copy project to any directory.
2. Rename `/.env.example` to `/.env` and configure passwords and other settings.
3. Put SSL-certificate files into the `/ssl_files` directory and configure their names in the `/.env` file. Current nginx configuration requires to set ssl configuration. You can use self-signed certificate.
4. If you need to, configure containers' additional config files in the `/.docker_build_configs`.
5. Put your app files into the `/www` directory and public accessible files into the `/www/public` directory.
6. Run containers using `make up`.
7. Stop containers using `make down`.
