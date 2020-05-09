# CRON Bash scripts
This is a directory with sh-scripts that will be executed every minute, hour, day and month.
You can write any needed tasks inside this scripts.
Sh-scripts are easy to edit without reloading containers and without modifying the crontab file.
If you want to have more specific CRON settings, you should edit the file `.docker_build_configs/cron/crontab_config.txt` before starting the containers.

# Example of running a php script from the sh-script:
```bash
. /var/www/.env.docker && /usr/bin/docker exec ${CONTAINER_NAME_PHPFPM} /bin/sh -c "cd /var/www/public/ && php test_cron.php"
```
