FROM debian:latest

# Installer PHP 8.3 + PHP-FPM
RUN apt update && apt-get  install -y \
	curl \
	php \
	php-fpm \
	php-curl \
	php-mysqli 

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY wp.sh .
RUN chmod +x wp.sh
# WordPress command line interface (wp-cli)
RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
# download wordpress
ENTRYPOINT ["wp.sh"]
# Lancer PHP-FPM
CMD ["/usr/sbin/php-fpm8.2", "-F"]
