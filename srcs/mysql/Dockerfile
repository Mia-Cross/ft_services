FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs .

RUN apk add mariadb mariadb-client mariadb-server-utils \
	&& addgroup mysql mysql \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/5050/g' /etc/nginx/nginx.conf

RUN mv mysqld.cnf /etc/my.cnf

CMD sh init_mysql.sh ; tail -F /dev/null

EXPOSE 3306