<?php

// Just print some text to the text file for a cron testing.
file_put_contents('cron_test_from_php.txt',
    'Simple every minute test from a php script: ' . date('d.m.Y H:i:s') . "\n", FILE_APPEND);

echo "hello from test_cron.php!\n";
