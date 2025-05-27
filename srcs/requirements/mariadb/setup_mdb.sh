#!/bin/bash

rm -f /var/lib/mysql/tc.log
mysql_install_db 2> /dev/null

DATABASE_DIR=/var/lib/mysql/${MYSQL_DATABASE}

echo "🔧 Chargement des variables d’environnement..."
echo "🔸 SQL_DATABASE       = ${MYSQL_DATABASE}"
echo "🔸 SQL_USER           = ${MYSQL_USER}"
echo "🔸 SQL_PASSWORD       = ${MYSQL_PASSWORD}"
echo "🔸 SQL_ROOT_PASSWORD  = ${MYSQL_ROOT_PASSWORD}"
if [ ! -d "$DATABASE_DIR" ]; then

	# Launch mariadb in background
	echo "dataBase not found... creation of ${MYSQL_DATABASE}"
	/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	until mysqladmin ping ; do
		echo "waiting for mysql_safe launche"
		sleep 2
	done

	mysql -u root << EOF

	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DELETE FROM mysql.user WHERE user='';
	CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;

EOF
	# Stop mariadb => Restart it
	killall mysqld 2> /dev/null
	echo "data base created"

fi
exec "$@"
