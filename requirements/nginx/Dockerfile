FROM debian:latest

RUN apt update && apt upgrade && apt install -y nginx

COPY default.conf /etc/nginx/conf.d/.

CMD ["nginx", "-g", "daemon off;"]
