FROM debian:latest

RUN apt update && apt upgrade && apt install -y mariadb-server

# COPY default.conf /etc/nginx/conf.d/.

CMD ["mysqld_safe"]
