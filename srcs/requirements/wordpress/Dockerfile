FROM debian:bullseye

# Installer les dépendances nécessaires
RUN apt update -y && apt install -y \
    curl \
    php7.4 \
    php7.4-fpm \
    php7.4-curl \
    php7.4-mysqli \
    mariadb-client

# Copier la configuration FPM pool adaptée à PHP 7.4
COPY www.conf /etc/php/7.4/fpm/pool.d/
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Copier le script de setup WordPress
COPY wp.sh /
RUN chmod +x /wp.sh

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Point d'entrée pour configurer WordPress
ENTRYPOINT ["/wp.sh"]

# Lancer PHP-FPM 7.4 en mode foreground
CMD ["/usr/sbin/php-fpm7.4", "-F"]
