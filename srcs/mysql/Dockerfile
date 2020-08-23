FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs/ import/

RUN apk add mariadb mariadb-client mariadb-server-utils \
	&& addgroup mysql mysql \
	&& sed -i "s/DB_NAME/mysql/g" /etc/telegraf/telegraf.conf

RUN mv import/mysqld.cnf /etc/my.cnf

CMD screen -dmS telegraf telegraf ; \
	sh import/init_mysql.sh ; \
	tail -F /dev/null

EXPOSE 3306