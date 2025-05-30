FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /var/run/nginx

RUN openssl req -new -newkey rsa:4096 -x509 -sha512 -days 365 -nodes  \
	-subj "/C=BE/ST=Bruxelles/O=19/CN=qalpesse.42.fr"  \
	-out /etc/ssl/certs/inception.crt  \
	-keyout /etc/ssl/private/inception.key

COPY default.conf /etc/nginx/conf.d/.

CMD ["nginx", "-g", "daemon off;"]
