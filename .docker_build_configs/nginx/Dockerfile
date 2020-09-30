FROM nginx:1.17

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_NGINX
ARG SERVER_NAME_NGINX

# Nginx configuration file:
ARG CONF_FILE_LOCAL=.docker_build_configs/nginx/default.conf
ARG CONF_FILE_SERVER=/etc/nginx/conf.d/default.conf

# Install the base soft:
RUN apt-get update && apt-get install -y \
    nano \
    htop

# Copy files:
ADD $CONF_FILE_LOCAL $CONF_FILE_SERVER

# Change params in the nginx conf:
RUN sed -i 's#^\(\s*\)\#*\s*\(server_name\s\+\).*$#\1\2'"$SERVER_NAME_NGINX;"'#' $CONF_FILE_SERVER

# Check configuration:
RUN cat $CONF_FILE_SERVER

# If you run the configuration checking now, it will fail.
# Probably, it is happening due to dns-resolving of the name of the phpfpm service or something like that.
# Or because of the network was not raised at the moment of bulding dockerfile.
# But server will be started successfully.
#RUN nginx -t

# Set the timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_NGINX /etc/localtime && echo $CONTAINER_TIMEZONE_NGINX > /etc/timezone
