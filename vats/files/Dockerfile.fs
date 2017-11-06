FROM repo.itmh.io/base/php:5-fpm

COPY . /var/www

VOLUME /var/www
WORKDIR /var/www
RUN chown -hR root:root /var/www/storage