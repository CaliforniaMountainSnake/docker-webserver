#!/bin/bash
# Workdir is /var/www/cron/

# Simple test:
echo "Simple every minute test from a bash script: $(date)" >> /var/www/public/cron_test_from_bash.txt

# Script executes directly in the cli environment of the cron container.
. /var/www/.env.docker && /usr/bin/docker exec ${CONTAINER_NAME_PHPFPM} /bin/sh -c "cd /var/www/public/ && php test_cron.php"
