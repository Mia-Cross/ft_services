FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add grafana@testing && rm /var/www/index.html \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/3000/g' /etc/nginx/nginx.conf

CMD nginx ; php-fpm7 ; tail -F /dev/null

EXPOSE 3000