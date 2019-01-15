FROM olaria/php7-xdebug:7.3-alpine

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS

RUN pecl install redis \
	&&  docker-php-ext-enable redis

RUN rm -rf /tmp/pear \
	&& rm -rf /var/cache/apk/*

RUN apk del .phpize_deps
