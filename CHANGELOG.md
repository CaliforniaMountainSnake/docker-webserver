# Changelog
The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security


## [2.0.2] - 2020-08-23
### Fixed
- Fixed "rsync-to-remote" Makefile target.

## [2.0.1] - 2020-08-23
### Added
- Added additional commands in the Makefile.
### Changed
- General log in the mysql.cnf has been turned off.

## [2.0.0] - 2020-08-15
### Changed
- MySQL database has been changed to MariaDB. MariaDB works better with Docker. Warning! Old mysql db-files are not compatible for the new MariaDB!

## [1.7.3] - 2020-08-14
### Removed
- Z-parameter has been removed from the paths in the docker-compose.yml.

## [1.7.2] - 2020-05-10
### Fixed
- Line separators have been fixed to LF in the some files. All files have LF line separators now.

## [1.7.1] - 2020-05-09
### Fixed
- Added forgotten Imagick and GD php extensions.

## [1.7.0] - 2020-05-09
### Added
- Added a possibility to install `Xdebug` into the php container.
- Added a possibility to install `ffmpeg` into the php container.
- Added a possibility to install `NodeJS` into the php container.
### Changed
- Image of the cron container has been updated to `debian:10-slim`.
- Image of the nginx container has been updated to `nginx:1.17`.
- Image of the php container has been updated to `php:7.4-fpm`.
- Image of the mysql container has been updated to `mysql:8.0`.
- Image of the phpmyadmin container has been updated to `phpmyadmin/phpmyadmin:5.0`.
- Makefile has been updated. Now you can use the same makefile on Windows (in Git Bash) and on Linux.
- README.md has been translated into English.
- CHANGELOG.md will now be in English too.
### Fixed
- Fixed php error logs mounting.

## [1.6.0] - 2018-05-11
### Added
- Добавил крон-задание на запуск скрипта каждый месяц.
- Добавил удобнейший Makefile, позволяющий запускать/останавливать/перезапускать контейнеры одной командой, также заходить в терминалы контейнеров. Все это без использования специфических docker-команд.
- У каждого контейнера теперь есть свое, задаваемое в .env-файле, имя.
### Changed
- Вместо запуска php-скриптов из контейнера CRON по fast-cgi сделал полноценный запуск любых скриптов и команд напрямую внутри php-fpm-контейнера путем технологии docker in docker.
- Папку public_html переименовал в public для совместимости с некоторыми фреймворками.
### Fixed
- Обновил версии пакетов и зависимостей контейнеров (версии операционных систем образов, php, nginx, mysql и т.п.)
### Removed
- Убрал ffmpeg из php-fpm контейнера.

## [1.5.4] - 2018-10-23
### Added
- Добавил htop в каждый контейнер для отслеживания процессов в ходе разработки.
- Добавил предупреждение о том, что QUERY_STRING при вызове cgi-fcgi должны быть urlencoded.

## [1.5.3] - 2018-10-22
### Changed
- Убрал вывод первых строк с заголовками из результата выполнения php-скрипта по fast-cgi. Также убрал буферизацию пайпа: " | stdbuf -i0 -o0 -e0 tail -n +4". Сделал более простую и логичную команду запуска скрипта по fast-cgi.
### Fixed
- Переименовал папку "php_fpm" в "phpfpm" для унификации с названием сервиса в docker-compose.yml.

## [1.5.2] - 2018-10-20
### Added
- Добавил забытые сокеты в докерфайл phpfpm.
- Добавил инструкцию по цепочкам сертификатов с сайта nginx в .env.example.

## [1.5.1] - 2018-10-18
### Fixed
- Улучшен перевод на английский различных файлов.
### Security
- В целях совместимости с переменными окружения php ENV-переменная SERVER_NAME переименована в NGINX_SERVER_NAME.

## [1.5.0] - 2018-10-16
### Added
- Добавил поддержку SSL-сертификата в конфигурацию Nginx.

## [1.4.1] - 2018-10-16
### Fixed
- Добавил в реп забытый /www/public_html/test_cron.php, тестирующий выполнение php-скрипта через fast-cgi.

## [1.4.0] - 2018-10-13
### Added
- Добавил контейнер с CRON. Из крона можно вызывать php-скрипты по fast-cgi.
### Changed
- Добавил единообразную настройку таймзоны в контейнерах с phpfpm и cron.
### Security
- Добавил в реп папку /mysql_files/. Если раскомментировать в docker-compose.yml строку, то файлы баз данных mysql будут хранится на хосте и можно будет пересоздавать контейнеры без потери данных БД.

## [1.3.0] - 2018-10-04
### Added
- Добавил GD в образ php-fpm.
- Сделал монтирование логов Nginx на хост.
- Сделал монтирование логов MySQL на хост.
### Changed
- Некоторые мелкие изменения в конфигурациях контейнеров.

## [1.2.0] - 2018-10-03
### Added
- Добавил поддержку MySQL 5.7. Изначально планировал добавить самую свежую версию 8, но там некоторые проблемы с обратной совместимостью.
- Добавил PhpMyAdmin 4.7.
### Fixed
- Добавил забытые настройки в .env.example.

## [1.1.0] - 2018-10-02
### Added
- Добавил поддержку php:7.2.10-fpm.
- Настройка php через свой файл php.ini.
- В php-контейнере установлены пакеты: Curl, wget, imagick, ffmpeg, composer, git, procps, mysqli, pdo.


## [1.0.0] - 2018-10-02
### Added
- Реализован самый базовый функционал: поднятие веб-сервера nginx, подключение папки проекта с хоста в контейнер.

[2.0.2]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/1.7.3...2.0.0
[1.7.3]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/1.7.2...1.7.3
[1.7.2]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/1.7.1...1.7.2
[1.7.1]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/1.7.0...1.7.1
[1.7.0]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/1.6.0...1.7.0
[1.6.0]: https://github.com/CaliforniaMountainSnake/docker-webserver/compare/3bec73745367c497ff3f9a2e155c67a3e17b3f47...1.6.0
