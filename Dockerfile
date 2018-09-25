FROM olaria/php7-xdebug:alpine

RUN pecl install redis \
	&&  docker-php-ext-enable redis \
	&&  rm -rf /tmp/pear
