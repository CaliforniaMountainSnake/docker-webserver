# Docker webserver configuration: Nginx + PHP-FPM + MySQL + PhpMyAdmin + CRON.
Это конфиг докера для поднятия вебсервера.
### Состав:
- Nginx 1.15.4.
- php:7.2.10-fpm (Curl, wget, imagick, gd, ffmpeg, composer, git, procps, mysqli, pdo).
- MySQL 5.7.
- PhpMyAdmin 4.7.
- CRON.

### Структура файлов:
- ```/.docker_build_configs/``` - файлы с настройками контейнеров.
- ```/logs/``` - папка логов контейнеров.
- ```/www/``` - монтируется из ```/var/www/```.
- ```/www/public_html/``` - корень вебсервера.
То есть, рабочей директорией php является ```/www/```, но корень вебсервера - ```/www/public_html/```.
Поэтому проект на php может размещать в видимой из веба области только нужные файлы, а файлы, находящиеся в ```/www/``` не будут видны извне.

### Дополнительная настройка:
- Вы можете дополнительно настроить сервер путем изменения файлов в ```/.docker_build_configs/```. Таких, как конфигурция nginx, php.ini, mysql.cnf, настройки phpmyadmin и т.п.
- Если вы хотите, чтобы файлы баз данных MySQL хранились на хосте и не уничтожались при перезапуске контейнеров, раскомментируйте в ```docker-compose.yml``` строку ```#- ./mysql_files:/var/lib/mysql:Z```.


## INSTALL:
1. Скопируйте все содержимое данного проекта в любую директорию, какую хотите.
2. Переименуйте файл ```/.env.example``` в ```/.env``` и задайте нам необходимые настройки.
3. По необходимости задайте нужные настройки в файлах конфигурации контейнеров в ```/.docker_build_configs/```.
4. Разместите файлы вашего php-проекта в директории /www.
5. Перейдите через cd в папку с ```docker-compose.yml``` и запустите вебсервер командой ```docker-compose up -d --build```. (Смотрите команды для работы с docker-compose).
6. Остановка вебсервера выполняется командой ```docker-compose down```.

## Что еще предстоит сделать:
- Перевести на английский всю документацию.

## КОМАНДЫ ДЛЯ РАБОТЫ С DOCKER И DOCKER-COMPOSE:
### Main docker-compose.
Build containers and run services in the background.
```bash
clear && docker-compose up -d --build
```

Stop containers and remove them.
```bash
clear && docker-compose down
```

### Containers manipulation.
Show all docker containers:
```bash
clear && docker ps -a
```

Stop and remove all docker containers:
```bash
clear && docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker ps -a
```

### Images manipulation.
Show all docker images:
```bash
clear && docker images
```

Delete a docker image:
```bash
clear && docker rmi IMAGE_NAME
```

WARNING! Delete all docker images:
```bash
clear && docker rmi $(docker images -q)
```

### Container terminal manipulation.
Connect to the container terminal:
```bash
clear && docker exec -it CONTAINER_NAME bash
```
```bash
clear && docker exec -it docker-server-mark-2_nginx_1 bash
```

Execute some code in the container:
```bash
clear && docker exec -ti docker-server-mark-2_nginx_1 sh -c "ls"
```

Exit from a container terminal:
```CTRL+PQ```
