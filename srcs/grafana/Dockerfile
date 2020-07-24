FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add grafana@testing \
#	&& sed -i "s/http:\/\/influxdb:/http:\/\/127.0.0.1:/g" /etc/telegraf/telegraf.conf \
	&& sed -i "s/TMP_BDD/grafana/g" /etc/telegraf/telegraf.conf

#COPY srcs/grafana.db /usr/share/grafana/data

CMD screen -dmS telegraf telegraf ; screen -dmS grafana grafana-server --homepath "usr/share/grafana"; tail -F /dev/null

EXPOSE 3000