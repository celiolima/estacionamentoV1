# Dockerfile
FROM php:7.4-apache

# Copiar seu php.ini
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \

    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \   
    libonig-dev \
    libxml2-dev \
    libssl-dev\
    libicu-dev\
    zip \
    unzip \
    default-mysql-client\  
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo_mysql mbstring exif gd
# Instalar extensões PHP
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
#    && docker-php-ext-install -j$(nproc) gd \
#    && docker-php-ext-install pdo pdo_mysql mysqli zip\
#    && docker-php-ext-install mbstring exif intl zip opcache bcmath soap

#RUN docker-php-ext-enable mysqli

# Permission for PHP to write in volumes
RUN usermod -u 1000 www-data


# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite

# Definir diretório de trabalho
WORKDIR /var/www/html


# Copiar raiz
COPY ./app/ /var/www/html

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expor porta
EXPOSE 80

CMD ["apache2-foreground"]

