ARG PHP_VERSION
FROM ${PHP_VERSION}

RUN apt-get update && apt-get install -y libz-dev libmemcached-dev libjpeg-dev libpng-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-install -j$(nproc) pdo pdo_mysql mysqli gd \
    && docker-php-ext-enable pdo pdo_mysql mysqli gd 
    
CMD ["php-fpm"]

EXPOSE 9000