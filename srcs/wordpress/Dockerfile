FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apk update && apk upgrade \
	&& apk add wget && apk add tar \
	&& adduser -D -g 'www' www && mkdir /www/ && chown -R www:www /www/ \
    && wget -c  https://wordpress.org/latest.tar.gz  && tar -xf latest.tar.gz \
	&& mv wordpress/ /www/
	#-o wpzip.gz && tar -x -C /www/ wpzip.gz \
	
	#wordpress 

CMD sh

# faire le lien avec les ports phpmyadmin et wordpress
EXPOSE 5050