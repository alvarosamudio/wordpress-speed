FROM ubuntu
MAINTAINER Alvaro Samudio <alvarosamudio@criptext.com>

# Install lamp stack plus curl
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php7.4 php7.4 php7.4-mysql phpmyadmin mysql-server curl

# Download WordPress
RUN wp_version=5.4.2 && \
    curl -L "https://wordpress.org/wordpress-${wp_version}.tar.gz" > /wordpress-${wp_version}.tar.gz && \
    rm /var/www/html/index.html && \
    tar -xzf /wordpress-${wp_version}.tar.gz -C /var/www/html --strip-components=1 && \
    rm /wordpress-${wp_version}.tar.gz
 
# WordPress configuration
ADD wp-config.php /var/www/html/wp-config.php

# Apache access
RUN chown -R www-data:www-data /var/www/html
    
# Add configuration script
ADD config_and_start_mysql.sh /config_and_start_mysql.sh
ADD config_apache.sh /config_apache.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# MySQL environment variables
ENV MYSQL_WP_USER WordPress
ENV MYSQL_WP_PASSWORD secret

EXPOSE 80 3306
CMD ["/run.sh"]