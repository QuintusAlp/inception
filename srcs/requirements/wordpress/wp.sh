#!/bin/bash
MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
echo "📦 Vérification de l'existence de wp-config.php..."
if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "🔧 wp-config.php non trouvé. Initialisation de WordPress..."

	cd /var/www/html

	echo "⬇️ Téléchargement de WordPress avec WP-CLI..."
	wp core download --allow-root

	echo "⏳ Attente que MariaDB soit prêt à accepter des connexions..."
	until mysqladmin --user="$MYSQL_USER" --password="$MYSQL_PASSWORD" --host=mariadb ping 2>/dev/null | grep "mysqld is alive" > /dev/null; do
    	echo "⌛ En attente de MariaDB sur mariadb..."
    	sleep 5
	done

	echo "✅ MariaDB est prêt !"

	echo "⚙️ Configuration du fichier wp-config.php..."
	wp config create	--dbname=${MYSQL_DATABASE} \
						--dbuser=${MYSQL_USER} \
						--dbpass=${MYSQL_PASSWORD} \
						--dbhost=${MYSQL_HOST} \
						--allow-root

	echo "🛠 Installation du site WordPress..."
	wp core install		--url=${DOMAIN_NAME} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--skip-email \
						--allow-root

	echo "👤 Création d’un utilisateur supplémentaire (auteur)..."
	wp user create 		${WP_USER} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD} \
						--role=author \
						--allow-root
else
	echo "✅ wp-config.php déjà présent, aucune installation nécessaire."
fi

echo "🚀 Lancement du conteneur (commande finale : $@)..."
exec "$@"
