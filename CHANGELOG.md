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
