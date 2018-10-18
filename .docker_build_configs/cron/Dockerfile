FROM debian:9.5-slim

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_CRON

# Install the base soft:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    zip \
    nano \
    iputils-ping \
    libfcgi0ldbl

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_CRON /etc/localtime && echo $CONTAINER_TIMEZONE_CRON > /etc/timezone

# Install CRON:
RUN apt-get update && apt-get install -y --no-install-recommends cron

# Add a crontab task:
ADD ./.docker_build_configs/cron/crontab_config.txt /var/crontab_config.txt
RUN crontab /var/crontab_config.txt

# Launch the container:
CMD ["cron", "-f"]
