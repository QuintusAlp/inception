#!/bin/bash
set -e

echo "🔸 SQL_DATABASE       = ${MYSQL_DATABASE}"
echo "🔸 SQL_USER           = ${MYSQL_USER}"
echo "🔸 SQL_PASSWORD       = ${MYSQL_PASSWORD}"
echo "🔸 SQL_ROOT_PASSWORD  = ${MYSQL_ROOT_PASSWORD}"
# 📁 Répertoire où la DB sera stockée
DATABASE_DIR="/var/lib/mysql/${MYSQL_DATABASE}"

echo "📦 Vérification de l'existence de la base de données : ${MYSQL_DATABASE}..."
# Si la DB n'existe pas encore (premier lancement)
if [ ! -d "$DATABASE_DIR" ]; then
    echo "🛠️  Base de données non trouvée. Initialisation en cours..."

    echo "🚀 Démarrage temporaire du service MariaDB..."
	service mysql start

	mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mysql -e "CREATE USER '${MYSQL_DATABAS}'@'%' IDENTIFIED BY '${mysql_password}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	mysql -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
else
    echo "✅ La base de données '${MYSQL_DATABASE}' existe déjà. Aucune action nécessaire."
fi

echo "🚀 Lancement final de MariaDB..."
exec "$@"
