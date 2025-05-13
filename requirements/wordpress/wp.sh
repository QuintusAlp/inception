#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
	cd /var/www/html
	# Download wordpress with wp-cli
	wp core download --allow-root

	# Waiting mariadb
	#Confif the first and second page of wordpress
	wp config create	--dbname=${MYSQL_DATABASE} \
						--dbuser=${MYSQL_USER} \
						--dbpass=${MYSQL_PASSWORD} \
						--dbhost=mariadb \
						--allow-root
	#Admin config
	wp core install		--url=${DOMAIN_NAME} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--skip-email \
						--allow-root
	#anotherone just for fun
	wp user create 		${WP_USER} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD} \
						--role=author \
						--allow-root

fi;
exec "$@"
