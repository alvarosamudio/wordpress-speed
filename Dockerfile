FROM wordpress:latest

# Instalar dependencias adicionales si se necesitan (ejemplo: extensiones PHP para Redis)
RUN pecl install redis && docker-php-ext-enable redis

# Configuración personalizada de PHP si es necesario
# COPY ./config/php.ini /usr/local/etc/php/conf.d/custom.ini

# Asegurarse de que los permisos sean correctos
RUN chown -R www-data:www-data /var/www/html

LABEL maintainer="Alvaro Samudio <alvarosamudio@criptext.com>"
LABEL status="optimized"
