# CRON Bash scripts
Это папка с sh-файлами, которые будут регулярно вызываться CRON каждую минуту, час и день.
Внутри них можно описать любые нужные задачи.
SH-скрипты можно легко редактировать без перезапуска контейнеров и изменения crontab-заданий.
Если хотите иные, более уникальные настройки CRON, отредактируйте файл .docker_build_configs/cron/crontab_config.txt перед запуском контейнеров.

## Пример crontab-задания для запуска php-скрипта через fast-cgi:
* * * * * SCRIPT_NAME=/var/www/public_html/test_cron.php SCRIPT_FILENAME=/var/www/public_html/test_cron.php QUERY_STRING=VAR1 DOCUMENT_ROOT=/var/www/public_html/ REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect phpfpm:9000
