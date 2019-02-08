FROM olaria/php7:7.3-alpine

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS

RUN pecl install redis \
	&&  docker-php-ext-enable redis

RUN apk del .phpize_deps 

RUN rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*
