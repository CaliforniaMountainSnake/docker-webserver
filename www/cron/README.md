# CRON Bash scripts
Это папка с sh-файлами, которые будут регулярно вызываться CRON каждую минуту, час и день.
Внутри них можно описать любые нужные задачи.
SH-скрипты можно легко редактировать без перезапуска контейнеров и изменения crontab-заданий.
Если хотите иные, более уникальные настройки CRON, отредактируйте файл .docker_build_configs/cron/crontab_config.txt перед запуском контейнеров.

## Пример crontab-задания для запуска php-скрипта через fast-cgi:
* * * * * DOCUMENT_ROOT="/var/www/public_html/" MY_SCRIPT="test_cron.php" QUERY_STRING=param1=value1\&param2=value2 SCRIPT_NAME=$DOCUMENT_ROOT/$MY_SCRIPT SCRIPT_FILENAME=$SCRIPT_NAME REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect phpfpm:9000 | stdbuf -i0 -o0 -e0 tail -n +4
