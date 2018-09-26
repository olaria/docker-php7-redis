FROM php:7.2-fpm-alpine3.7

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS \
		libxml2-dev \
        libressl-dev

RUN docker-php-ext-install pdo_mysql zip

RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

RUN pecl install redis \
	&&  docker-php-ext-enable redis

ENV XDEBUG_INI_DIR /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_enable=on" >> $XDEBUG_INI_DIR \
    && echo "xdebug.remote_autostart=off" >> $XDEBUG_INI_DIR \
    && echo "xdebug.remote_port=9001" >> $XDEBUG_INI_DIR

RUN rm -rf /tmp/pear \
	&& rm -rf /var/cache/apk/*

RUN apk del .phpize_deps
