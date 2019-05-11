#!/bin/bash
# Workdir is /var/www/cron/

# Simple test:
echo "test $(date)" >> /var/www/public_html/simple_test_from_bash.txt

# Скрипт выполняется напрямую в cli-окружении контейнера cron
. /var/www/.env.docker && /usr/bin/docker exec ${CONTAINER_NAME_PHPFPM} /bin/sh -c "cd /var/www/public/ && php test_cron.php"
