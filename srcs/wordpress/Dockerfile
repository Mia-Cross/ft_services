FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs/ import/

RUN apk add wget && apk add tar \
    && wget -c  https://wordpress.org/latest.tar.gz  && tar -xf latest.tar.gz \
	&& rm /var/www/index.html && mv wordpress/* /var/www/ \
	&& rm /var/www/wp-admin/install.php /var/www/wp-admin/upgrade.php \
	&& rm latest.tar.gz && rm -rf wordpress \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/5050/g' /etc/nginx/nginx.conf \
	&& sed -i "s/\"nginx\"/\"wordpress\"/g" /etc/telegraf/telegraf.conf \
	&& mv import/wp-config.php /var/www/

CMD nginx ; php-fpm7 ; screen -dmS telegraf telegraf ; tail -F /dev/null

EXPOSE 5050