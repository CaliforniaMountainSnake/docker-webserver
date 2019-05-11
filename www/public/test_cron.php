<?php

// Just print some text to the text file for a cron testing.
\file_put_contents('test_cron.txt', 'hello! ' . \date('d.m.Y H:i:s') . "\n", \FILE_APPEND);
echo "hello from test_cron.php!\n";
