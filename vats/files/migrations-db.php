<?php

return array(
    'driver'    => getenv('DB_DRIVER'),
    'host'      => getenv('DB_HOST'),
    'user'      => getenv('DB_USER'),
    'password'  => getenv('DB_PASSWORD'),
    'dbname'    => getenv('DB_SCHEMA')
);