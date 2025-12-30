FROM wordpress:fpm-alpine

# Instalar dependencias para extensiones PHP
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    imagemagick-dev \
    libzip-dev \
    libgomp \
    autoconf \
    g++ \
    make \
    pcre-dev \
    icu-dev

# Configurar e instalar extensiones PHP críticas para rendimiento
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    mysqli \
    opcache \
    zip \
    intl \
    exif

# Instalar extensiones via PECL
RUN pecl install redis imagick \
    && docker-php-ext-enable redis imagick

# Limpiar dependencias de construcción para mantener la imagen ligera
RUN apk del autoconf g++ make

# Opcache tuning (Best practices for WordPress)
COPY php/conf.d/speed.ini /usr/local/etc/php/conf.d/speed.ini

# Asegurar permisos correctos
RUN chown -R www-data:www-data /var/www/html

LABEL maintainer="Alvaro Samudio <alvarosamudio@protonmail.com>"
LABEL status="supercharged"
