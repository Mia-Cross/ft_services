FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs import

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add curl && apk add grafana@testing \
	&& sed -i "s/TMP_BDD/grafana/g" /etc/telegraf/telegraf.conf

#COPY srcs/grafana.db /usr/share/grafana/data

CMD screen -dmS telegraf telegraf ; screen -dmS grafana grafana-server --homepath "usr/share/grafana"; sh import/import_datasources.sh ; tail -F /dev/null

EXPOSE 3000