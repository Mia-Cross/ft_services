FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php
RUN apk add wget && apk add tar \
    && wget -c  https://wordpress.org/latest.tar.gz  && tar -xf latest.tar.gz \
	&& rm /var/www/index.html && mv wordpress/* /var/www/ \
	&& rm latest.tar.gz && rm -rf wordpress \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/5050/g' /etc/nginx/nginx.conf \
	&& sed -i "s/\"nginx\"/\"wordpress\"/g" /etc/telegraf/telegraf.conf

CMD nginx ; php-fpm7 ; screen -dmS telegraf telegraf ; tail -F /dev/null

EXPOSE 5050