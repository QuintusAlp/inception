FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Autoriser les connexions distantes
RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY setup_mdb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mdb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup_mdb.sh"]
