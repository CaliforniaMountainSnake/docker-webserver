#!/bin/bash
# Workdir is /var/www/cron/

# Simple test:
echo "test $(date)" >> /var/www/public_html/simple_test_from_bash.txt

# Run php script throw fast-cgi:
phpoutput="$(SCRIPT_NAME=/var/www/public_html/test_cron.php SCRIPT_FILENAME=/var/www/public_html/test_cron.php QUERY_STRING=VAR1 DOCUMENT_ROOT=/var/www/public_html/ REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect phpfpm:9000)"
echo "${phpoutput}"
