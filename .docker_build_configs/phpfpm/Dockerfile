FROM php:7.4-fpm

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_PHPFPM
ARG IS_INSTALL_NODEJS
ARG IS_INSTALL_FFMPEG
ARG IS_INSTALL_XDEBUG

# [_______INSTALL_DEPENDENCIES_______]
# Update sources.list:
RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list

# Install base soft:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    zip \
    nano \
    htop \
    git \
    libzip-dev \
    zlib1g-dev \
    libicu-dev \
    g++

# Install php extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

# Install intl php extension:
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Install utils to work with processes:
RUN apt-get update && apt-get install -y procps

# Install sockets for PHP.
RUN docker-php-ext-install sockets

# Install Composer:
RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Compile and install fresh ffmpeg from sources:
# See: https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
RUN if [ "$IS_INSTALL_FFMPEG" = "true" ]; then \
    apt-get update -qq && apt-get -y install \
          autoconf \
          automake \
          build-essential \
          cmake \
          git-core \
          libass-dev \
          libfreetype6-dev \
          libsdl2-dev \
          libtool \
          libva-dev \
          libvdpau-dev \
          libvorbis-dev \
          libxcb1-dev \
          libxcb-shm0-dev \
          libxcb-xfixes0-dev \
          pkg-config \
          texinfo \
          wget \
          zlib1g-dev \
          nasm \
          yasm \
          libx265-dev \
          libnuma-dev \
          libvpx-dev \
          libmp3lame-dev \
          libopus-dev \
          libx264-dev \
          libfdk-aac-dev \
    && mkdir -p ~/ffmpeg_sources ~/bin && cd ~/ffmpeg_sources && \
        wget -O ffmpeg-4.2.2.tar.bz2 https://ffmpeg.org/releases/ffmpeg-4.2.2.tar.bz2 && \
        tar xjvf ffmpeg-4.2.2.tar.bz2 && \
        cd ffmpeg-4.2.2 && \
        PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
          --prefix="$HOME/ffmpeg_build" \
          --pkg-config-flags="--static" \
          --extra-cflags="-I$HOME/ffmpeg_build/include" \
          --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
          --extra-libs="-lpthread -lm" \
          --bindir="$HOME/bin" \
          --enable-libfdk-aac \
          --enable-gpl \
          --enable-libass \
          --enable-libfreetype \
          --enable-libmp3lame \
          --enable-libopus \
          --enable-libvorbis \
          --enable-libvpx \
          --enable-libx264 \
          --enable-libx265 \
          --enable-nonfree && \
        PATH="$HOME/bin:$PATH" make -j8 && \
        make install -j8 && \
        hash -r \
    && mv ~/bin/ffmpeg /usr/local/bin && mv ~/bin/ffprobe /usr/local/bin && mv ~/bin/ffplay /usr/local/bin \
; fi

# Install XDebug:
RUN if [ "$IS_INSTALL_XDEBUG" = "true" ]; then \
    pecl install xdebug && docker-php-ext-enable xdebug \
; fi

# Install Nodejs via NVM:
RUN if [ "$IS_INSTALL_NODEJS" = "true" ]; then \
    apt-get update && apt-get install -y python3 \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install 'lts/erbium' \
; fi

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
