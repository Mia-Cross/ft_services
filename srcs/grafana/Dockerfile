FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN rm /var/www/index.html && sed -i 's/TMP_PORT/3000/g' /etc/nginx/nginx.conf \
	&& echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add grafana@testing

CMD nginx ; php-fpm7 ; sh
#tail -F /dev/null

EXPOSE 3000