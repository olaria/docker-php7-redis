FROM php:7.2-fpm

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get autoremove -y \
    && apt-get install zip unzip zlib1g-dev -y

RUN docker-php-ext-install pdo_mysql zip

RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

RUN pecl install redis \
	&&  docker-php-ext-enable redis

ENV XDEBUG_INI_DIR /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_enable=on" >> $XDEBUG_INI_DIR \
    && echo "xdebug.remote_autostart=off" >> $XDEBUG_INI_DIR \
    && echo "xdebug.remote_port=9001" >> $XDEBUG_INI_DIR

RUN rm -rf /tmp/pear
RUN apt-get clean -y
