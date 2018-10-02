FROM php:7.2.10-fpm

# [_______НАСТРОЙКА_ЗАВИСИМОСТЕЙ_ОДИНАКОВАЯ_ДЛЯ_WEB_И_CLI_______]
# Устанавливаем дополнительный софт:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ffmpeg \
    git \
    zip \
    nano

# Устанавливаем расширения php:
RUN docker-php-ext-install mysqli pdo pdo_mysql

# install Imagemagick & PHP Imagick ext:
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends
RUN pecl install imagick && docker-php-ext-enable imagick

# Устанавливаем композер:
RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Пытаемся поставить таймзону, хоть это нихрена и не работает:
RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure -f noninteractive tzdata && date

# Поставим утилиты работы с процессами.
RUN apt-get update && apt-get install -y procps
# [/_______НАСТРОЙКА_ЗАВИСИМОСТЕЙ_ОДИНАКОВАЯ_ДЛЯ_WEB_И_CLI_______]

