FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs/ import/

RUN apk add influxdb && mv /import/telegraf_for_influxdb_pod.conf /etc/telegraf/telegraf.conf
#	&& sed -i "s/DB_NAME/influxdb/g" /etc/telegraf/telegraf.conf
#	&& mkdir -p /var/lib/influxdb
#	&& sed -i "s/http:\/\/influxdb:/http:\/\/127.0.0.1:/g" /etc/telegraf/telegraf.conf \
#	&& mv influxdb_custom.conf /etc/influxdb.conf
#RUN mkdir /etc/influxdb && mv influxdb.conf /etc/influxdb/

CMD screen -dmS telegraf telegraf ; \
	screen -dmS influxdb influxd ; \
	tail -F /dev/null

EXPOSE 8086