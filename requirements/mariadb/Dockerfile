FROM debian:buster

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
# Créer les dossiers nécessaires
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copier le script d'init
COPY script.sh /script.sh
RUN chmod +x /script.sh

# Lancer le script comme point d'entrée
ENTRYPOINT ["/script.sh"]
CMD ["mysqld_safe"]
