FROM debian:10-slim

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_CRON

# Install the base soft:
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    zip \
    nano \
    htop

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_CRON /etc/localtime && echo $CONTAINER_TIMEZONE_CRON > /etc/timezone

# Install docker (Yep, this is docker in docker):
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Install CRON:
RUN apt-get update && apt-get install -y --no-install-recommends cron

# Add a crontab task:
ADD ./.docker_build_configs/cron/crontab_config.txt /var/crontab_config.txt
RUN crontab /var/crontab_config.txt

# Launch the container:
CMD ["cron", "-f"]
