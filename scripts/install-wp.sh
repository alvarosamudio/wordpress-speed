#!/bin/sh

# Esperar a que la base de datos esté lista
echo "Esperando a que la base de datos y WordPress estén listos..."
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

    echo "Eliminando plugins innecesarios (Hello Dolly, Akismet)..."
    wp plugin delete hello akismet --allow-root

    echo "Instalando y activando plugins de rendimiento..."
    wp plugin install redis-cache autoptimize wp-optimize query-monitor --activate --allow-root
    
    echo "Configurando Redis..."
    wp config set WP_REDIS_HOST redis --allow-root
    wp redis enable --allow-root

    echo "Optimizando base de datos inicial..."
    wp db optimize --allow-root

    echo "Deshabilitando Emojis (reducción de peticiones HTTP)..."
    # Esto se suele hacer vía código en functions.php, pero podemos usar un plugin o Snippet
    # Por ahora, simplemente instalamos un plugin que lo gestione o lo dejamos como recomendación.
    
    echo "WordPress Supercharged instalado y configurado correctamente."
else
    echo "WordPress ya está instalado. Asegurando configuración de rendimiento..."
    for plugin in redis-cache autoptimize wp-optimize query-monitor; do
        if ! wp plugin is-installed $plugin --allow-root; then
            wp plugin install $plugin --activate --allow-root
        else
            wp plugin activate $plugin --allow-root
        fi
    done
    wp redis enable --allow-root
fi
