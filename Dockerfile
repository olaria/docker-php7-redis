FROM olaria/php7:7.4-alpine

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS

RUN pecl install redis-5.1.1 \
	&&  docker-php-ext-enable redis

RUN apk del .phpize_deps 

RUN rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*
