FROM debian:latest

# Installer PHP 8.3 + PHP-FPM
RUN apt update && apt-get  install -y \
	curl \
	php \
	php-fpm \
	php-curl \
	php-mysql 

COPY www.conf /etc/php/8.2/fpm/pool.d/.
EXPOSE 9000
# Lancer PHP-FPM
CMD ["/usr/sbin/php-fpm8.2", "-F"]
