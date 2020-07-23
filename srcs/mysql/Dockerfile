FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs .

RUN apk add mariadb mariadb-client mariadb-server-utils \
	&& addgroup mysql mysql \
	&& sed -i "s/TMP_BDD/mysql/g" /etc/telegraf/telegraf.conf

RUN mv mysqld.cnf /etc/my.cnf

CMD sh init_mysql.sh ; screen -dmS telegraf telegraf ; tail -F /dev/null

EXPOSE 3306