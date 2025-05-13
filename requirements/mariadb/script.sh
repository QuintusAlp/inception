#!/bin/bash
set -e

# Attendre que le dossier mysql soit prêt (uniquement à la première init)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "📦 Initialisation de la base de données MariaDB..."

    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Génération du fichier init.sql
    INIT_SQL_PATH="/etc/mysql/init.sql"
    cat > "$INIT_SQL_PATH" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Démarrer MariaDB sans réseau
    mysqld_safe --skip-networking &
    sleep 5

    echo "⚙️  Exécution du script SQL..."
    mysql -u root < "$INIT_SQL_PATH"

    mysqladmin shutdown
fi

echo "🚀 Lancement final de MariaDB..."
exec mysqld_safe
