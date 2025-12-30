#!/bin/sh

# Esperar a que la base de datos esté lista
echo "Esperando a que la base de datos esté lista..."
while ! wp db check --allow-root > /dev/null 2>&1; do
    sleep 2
done

# Instalar WordPress si no está instalado
if ! wp core is-installed --allow-root; then
    echo "Instalando WordPress..."
    wp core install \
        --allow-root \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email

    echo "Configurando idioma..."
    wp language core install es_ES --allow-root
    wp site switch-language es_ES --allow-root

    echo "Eliminando plugins innecesarios..."
    wp plugin delete hello akismet --allow-root

    echo "Instalando plugins de rendimiento..."
    wp plugin install redis-cache query-monitor --activate --allow-root
    
    echo "Configurando Redis..."
    wp config set WP_REDIS_HOST redis --allow-root
    wp redis enable --allow-root

    echo "WordPress instalado y configurado correctamente."
else
    echo "WordPress ya está instalado."
fi
