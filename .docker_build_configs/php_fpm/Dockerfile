FROM php:7.2.10-fpm

LABEL maintainer="bond.ge@yandex.ru"

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_PHPFPM

# [_______НАСТРОЙКА_ЗАВИСИМОСТЕЙ_ОДИНАКОВАЯ_ДЛЯ_WEB_И_CLI_______]
# Устанавливаем базовый софт:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ffmpeg \
    git \
    zip \
    nano

# Install mysqli and pdo extensions:
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install Imagemagick & PHP Imagick ext:
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends
RUN pecl install imagick && docker-php-ext-enable imagick

# Install GD:
RUN apt-get update && apt-get install -y \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

# Поставим утилиты работы с процессами:
RUN apt-get update && apt-get install -y procps

# Install Composer:
RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_PHPFPM /etc/localtime && echo $CONTAINER_TIMEZONE_PHPFPM > /etc/timezone
# [/_______НАСТРОЙКА_ЗАВИСИМОСТЕЙ_ОДИНАКОВАЯ_ДЛЯ_WEB_И_CLI_______]



# Указываем рабочую директорию для PHP
WORKDIR /var/www

# Запускаем контейнер
# Из документации: The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, 
# or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.
CMD ["php-fpm"]
