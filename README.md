# Конфигурация веб-сервера Docker: Nginx 1.15.4 + PHP-FPM 7.2.10 + MySQL 5.7.
Это конфиг докера для поднятия вебсервера.
### Состав:
- Nginx 1.15.4.
- php:7.2.10-fpm (Curl, wget, imagick, ffmpeg, composer, git, procps, mysqli, pdo).
- MySQL 5.7.
- PhpMyAdmin 4.7.

### Структура файлов:
- /.docker_build_configs/ - файлы с настройками контейнеров.
- /logs/ - монтируется из /var/logs/.
- /www/ - монтируется из /var/www/.
- /www/public_html/ - корень вебсервера.
То есть, рабочей директорией php является www, но корень вебсервера - /www/public_html/.
Поэтому проект на php может размещать в видимой из веба области только нужные файлы, а файлы, находящиеся в /www не будут видны извне.

### Дополнительная настройка:
Вы можете дополнительно настроить сервер путем изменения файлов в ```/.docker_build_configs/```.
Таких, как конфигурция nginx, php.ini, mysql.cnf, настройки phpmyadmin и т.п.


## INSTALL:
1. Скопируйте все содержимое данного проекта в любую директорию, какую хотите.
2. Переименуйте файл /.env.example в /.env и задайте нам необходимые настройки.
3. По необходимости задайте нужные настройки в файлах конфигурации контейнеров в /.docker_build_configs/.
4. Разместите файлы вашего php-проекта в директории /www.
5. Перейдите через cd в папку с docker-compose.yml и запустите вебсервер командой ```docker-compose up -d --build```. (Смотрите команды для работы с docker-compose).
6. Остановка вебсервера выполняется командой ```docker-compose down```.


## КОМАНДЫ ДЛЯ РАБОТЫ С DOCKER-COMPOSE:
Собрать контейнеры и запустить в фоне:
```bash
clear && docker-compose up -d --build
```

Остановить контейнеры и уничтожить их:
```bash
clear && docker-compose down
```

Просмотреть весь список имеющихся контейнеров:
```bash
clear && docker ps -a
```

Stop and remove all docker containers:
```bash
clear && docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker ps -a
```

Зайти в терминал нужного контейнера:
```bash
clear && docker exec -it CONTAINER_NAME bash
```
```bash
clear && docker exec -it docker-server-mark-2_nginx_1 bash
```

Выполнить произвольный код в контейнере:
```bash
clear && docker exec -ti moderation_telegram_bot_php_cli_cron_1 sh -c "ls"
```

Выйти из терминала контейнера:
```CTRL+PQ```

Просмотреть список всех имеющихся образов:
```bash
clear && docker images
```

