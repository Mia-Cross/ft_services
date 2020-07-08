FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apk add wget && apk add tar \
    && wget -c  https://wordpress.org/latest.tar.gz  && tar -xf latest.tar.gz \
	&& mv wordpress/ /www/ && chown -R www:www /www/wordpress

# faire le lien avec les ports phpmyadmin et wordpress
EXPOSE 5050