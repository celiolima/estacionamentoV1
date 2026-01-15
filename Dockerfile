# Dockerfile
FROM php:7.4-apache

# Copiar seu php.ini
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libjpeg-dev\
    libfreetype6-dev\
    libssl-dev\
    libicu-dev\
    default-mysql-client\   
    unzip
# Ativa o mod_rewrite do Apache
RUN a2enmod rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql mbstring exif intl zip opcache bcmath soap
RUN docker-php-ext-enable mysqli

RUN docker-php-ext-configure gd --with-freetype=/usr --with-jpeg=/usr
RUN docker-php-ext-install gd

# Copiar raiz
COPY ./app /var/www/html

