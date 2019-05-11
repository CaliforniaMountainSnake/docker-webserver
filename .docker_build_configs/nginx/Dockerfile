FROM nginx:1.15.8

# Wait dynamic arguments:
ARG CONTAINER_TIMEZONE_NGINX
ARG NGINX_SERVER_NAME
ARG SSL_LOCAL_CRT_FILE
ARG SSL_LOCAL_KEY_FILE
ARG SSL_LOCAL_CA_FILE

# SSL certificate files in the container:
ARG SSL_SERVER_CRT_FILE=/etc/nginx/ssl/site_crt.crt
ARG SSL_SERVER_KEY_FILE=/etc/nginx/ssl/site_key.key
ARG SSL_SERVER_CA_FILE=/etc/nginx/ssl/site_ca.crt

# Nginx configuration file:
ARG SSL_LOCAL_CONF_FILE=.docker_build_configs/nginx/default.conf
ARG SSL_SERVER_CONF_FILE=/etc/nginx/conf.d/default.conf

# Install the base soft:
RUN apt-get update && apt-get install -y \
    nano \
    htop

# Copy files:
ADD $SSL_LOCAL_CONF_FILE $SSL_SERVER_CONF_FILE
ADD $SSL_LOCAL_CRT_FILE $SSL_SERVER_CRT_FILE
ADD $SSL_LOCAL_KEY_FILE $SSL_SERVER_KEY_FILE
ADD $SSL_LOCAL_CA_FILE $SSL_SERVER_CA_FILE

# Change params in the nginx conf:
RUN sed -i 's#^\(\s*\)\#*\s*\(server_name\s\+\).*$#\1\2'"$NGINX_SERVER_NAME;"'#' $SSL_SERVER_CONF_FILE
RUN sed -i 's#^\(\s*\)\#*\s*\(ssl_certificate\s\+\).*$#\1\2'"$SSL_SERVER_CRT_FILE;"'#' $SSL_SERVER_CONF_FILE
RUN sed -i 's#^\(\s*\)\#*\s*\(ssl_certificate_key\s\+\).*$#\1\2'"$SSL_SERVER_KEY_FILE;"'#' $SSL_SERVER_CONF_FILE

# Check configuration:
RUN cat $SSL_SERVER_CONF_FILE

# Если сейчас запустить проверку конфигурации, она не будет пройдена.
# Вероятно, дело в dns-резолвинге имени сервиса phpfpm или что-то в этом духе.
# Или в том, что на момент сборки dockerfile'а сеть еще не поднята.
# Но сервер будет успешно запущен.
#RUN nginx -t

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE_NGINX /etc/localtime && echo $CONTAINER_TIMEZONE_NGINX > /etc/timezone


