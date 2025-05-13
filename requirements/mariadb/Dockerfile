FROM debian:latest

RUN apt update && apt upgrade && apt install -y mariadb-server mariadb-client
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY script.sh .
RUN chmod +x script.sh
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld
CMD ["./script.sh"]
