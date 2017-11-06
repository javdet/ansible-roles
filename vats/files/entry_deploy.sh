#!/bin/sh

php /var/www/html/src/console cache:clear
php /var/www/html/src/console assets:install
php /var/www/html/src/console assetic:dump


chmod -R 0700 /var/www/html/var/cache /var/www/html/var/logs
chown -R www-data:www-data /var/www/html/var/cache /var/www/html/var/logs

exec php-fpm