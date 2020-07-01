FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx
RUN apt-get update && apt-get upgrade\
	&& apt-get install -y nginx \
	&& apt-get install -y php7.3 php7.3-fpm php7.3-mysql

RUN mkdir /var/www/localhost && chown -R $USER:$USER /var/www/localhost

#copie des sources dans le container
COPY my_nginx_config .

#configuration de nginx a partir des sources importees
RUN rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && mv my_nginx_config /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/my_nginx_config /etc/nginx/sites-enabled/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj /C=FR/ST=IDF/L=Paris/O=42/CN=lemarabe/ \
    -keyout /etc/ssl/private/ssl_key.key -out /etc/ssl/certs/ssl_certif.crt

#demarrer le service depuis l'exterieur
RUN service nginx start && service php7.3-fpm start

# faire le lien entre les ports de l'ordi et le reseau
EXPOSE 80 443
