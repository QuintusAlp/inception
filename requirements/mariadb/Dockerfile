FROM debian:buster

# Installation des paquets nécessaires
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    apt-get clean

# Préparation des dossiers
COPY 50-server.cnf etc/mysql/mariadb.conf.d/.
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

RUN rm -f /var/lib/mysql/tc.log
RUN mysql_install_db
# Initialisation de la base de données

# # Autoriser les connexions externes
# RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
#
# Copier le script de setup
COPY setup_mdb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mdb.sh

EXPOSE 3306

# Utiliser le script d’init comme point d’entrée
ENTRYPOINT ["/usr/local/bin/setup_mdb.sh"]

# Lancer MariaDB par défaut
CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]
