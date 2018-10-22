#!/bin/bash
# Workdir is /var/www/cron/

# Simple test:
echo "test $(date)" >> /var/www/public_html/simple_test_from_bash.txt

# Run php script throw fast-cgi:
# You can redirect output to the file without buffering:
# ...bla bla bla...-connect phpfpm:9000 | stdbuf -i0 -o0 -e0 tail -n +4 >> "/var/my_log_file.log"
DOCUMENT_ROOT="/var/www/public_html/" MY_SCRIPT="test_cron.php" QUERY_STRING=param1=value1\&param2=value2 SCRIPT_NAME=$DOCUMENT_ROOT/$MY_SCRIPT SCRIPT_FILENAME=$SCRIPT_NAME REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect phpfpm:9000 | stdbuf -i0 -o0 -e0 tail -n +4
