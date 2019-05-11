FROM php:7.3.1-fpm

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_PHPFPM

# [_______INSTALL_DEPENDENCIES_______]
# Install base soft:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    zip \
    nano \
    htop \
    git \
    libzip-dev

# Install php extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

# Install Imagemagick & PHP Imagick ext:
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends
RUN pecl install imagick && docker-php-ext-enable imagick

# Install GD:
RUN apt-get update && apt-get install -y \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

# Install utils to work with processes:
RUN apt-get update && apt-get install -y procps

# Install sockets for PHP. MadelineProto will not work without them.
RUN docker-php-ext-install sockets

# Install Composer:
RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_PHPFPM /etc/localtime && echo $CONTAINER_TIMEZONE_PHPFPM > /etc/timezone
# [_______INSTALL_DEPENDENCIES_______]



# Set workdir to PHP:
WORKDIR /var/www

# Launch the container:
# From documentation: The main purpose of a CMD is to provide defaults for an executing container.
# These defaults can include an executable, or they can omit the executable,
# in which case you must specify an ENTRYPOINT instruction as well.
CMD ["php-fpm"]
