FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apt-get update && apt-get upgrade\
	&& apt-get install wget \
    && wget -c  https://wordpress.org/latest.tar.gz -O - | tar -xz -C /var/www/localhost \
	&& chown -R www-data: /var/www/localhost/wordpress 

# faire le lien avec les ports phpmyadmin et wordpress
EXPOSE 5050