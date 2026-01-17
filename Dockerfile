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
    zip \
    unzip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli zip

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

