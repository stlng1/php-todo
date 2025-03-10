FROM php:7.4 as php

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

ENV PORT=8000

WORKDIR /var/www
COPY . .
RUN chmod +x /var/www/entrypoint.sh
ENTRYPOINT [ "/var/www/entrypoint.sh" ]