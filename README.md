# Конфигурация веб-сервера Docker: Nginx.
Это конфиг докера для поднятия вебсервера.

## КОМАНДЫ ДЛЯ РАБОТЫ С DOCKER-COMPOSE:
Собрать контейнеры и запустить в фоне:
```bash
clear && docker-compose up -d --build
```

Остановить контейнеры и уничтожить их:
```bash
clear && docker-compose down
```

Просмотреть весь список имеющихся контейнеров:
```bash
clear && docker ps -a
```

Stop and remove all docker containers:
```bash
clear && docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker ps -a
```

Зайти в терминал нужного контейнера:
```bash
clear && docker exec -it CONTAINER_NAME bash
```
```bash
clear && docker exec -it docker-server-mark-2_nginx_1 bash
```

Выполнить произвольный код в контейнере:
```bash
clear && docker exec -ti moderation_telegram_bot_php_cli_cron_1 sh -c "ls"
```

Выйти из терминала контейнера:
```CTRL+PQ```

Просмотреть список всех имеющихся образов:
```bash
clear && docker images
```

