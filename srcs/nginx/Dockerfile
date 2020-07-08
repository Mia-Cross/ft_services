FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx
RUN apk update && apk upgrade \
	&& apk add nginx \
	&& apk add php7 php7-fpm

RUN adduser -D -g 'www' www && mkdir /www/ \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

#copie des sources dans le container
COPY srcs .

#configuration de nginx a partir des sources importees
RUN rm -f /etc/nginx/nginx.conf && mv my_nginx_config /etc/nginx/nginx.conf \
	&& mv index.html /www/ && mkdir -p /run/nginx

CMD nginx && sh

#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	#-subj /C=FR/ST=IDF/L=Paris/O=42/CN=lemarabe/ \
    #-keyout /etc/ssl/private/ssl_key.key -out /etc/ssl/certs/ssl_certif.crt

# faire le lien entre les ports de l'ordi et le reseau
EXPOSE 80
#EXPOSE 80 443
