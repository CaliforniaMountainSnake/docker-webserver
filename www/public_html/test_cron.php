<?php

// Just print some text to the text file for a cron testing.
\file_put_contents ('test_from_php.txt', 'test! ' . \date ('d.m.Y H:i:s') . "\n", \FILE_APPEND);
echo 'echo from test_cron.php!';
