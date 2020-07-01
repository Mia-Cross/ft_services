FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apt-get update && apt-get upgrade\
	&& apt-get install wget \
    && wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-english.tar.gz -O - | tar -xz -C /var/www/localhost \
	&& mv var/www/localhost/phpMyAdmin-4.9.2-english var/www/localhost/phpMyAdmin \
	&& chown -R www-data: /var/www/localhost/phpMyAdmin

# faire le lien avec les ports phpmyadmin et wordpress
EXPOSE 5000

