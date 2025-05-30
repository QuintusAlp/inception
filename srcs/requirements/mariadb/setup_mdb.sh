#!/bin/bash
MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
# Chemin vers la base système MariaDB
DB_SYSTEM_DIR="/var/lib/mysql/mysql"

echo "🔧 Vérification de l’état de MariaDB..."

if [ ! -d "$DB_SYSTEM_DIR" ]; then
    echo "📦 Initialisation de MariaDB..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

    echo "🚀 Démarrage temporaire de MariaDB..."
    mysqld_safe --datadir=/var/lib/mysql &

    # Attente que le serveur soit prêt
    until mysqladmin ping --silent; do
        echo "⏳ En attente du démarrage de MariaDB..."
        sleep 2
    done

    echo "🔐 Configuration des utilisateurs..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    echo "🛑 Arrêt temporaire de MariaDB..."
	mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

echo "✅ Lancement final de MariaDB"
/usr/bin/mysqld_safe --datadir=/var/lib/mysql
