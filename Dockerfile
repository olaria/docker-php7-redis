FROM php:7.2-fpm-alpine3.7

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS \
		libxml2-dev \
        libressl-dev

RUN docker-php-ext-install pdo_mysql zip

RUN pecl install redis \
	&&  docker-php-ext-enable redis

RUN rm -rf /tmp/pear \
	&& rm -rf /var/cache/apk/*

RUN apk del .phpize_deps
