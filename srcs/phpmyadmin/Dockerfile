FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN apk add wget && apk add tar && rm /var/www/index.html \
    && wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar -xf phpMyAdmin-5.0.2-all-languages.tar.gz && mv phpMyAdmin-5.0.2-all-languages/* /var/www/ \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/5000/g' /etc/nginx/nginx.conf \
	&& sed -i "s/nginx/phpmyadmin/g" /etc/telegraf/telegraf.conf

COPY config.inc.php /var/www/

CMD nginx ; php-fpm7 ; screen -dmS telegraf telegraf ; tail -F /dev/null

EXPOSE 5000

