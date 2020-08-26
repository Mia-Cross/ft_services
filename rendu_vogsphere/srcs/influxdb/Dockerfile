FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN apk add influxdb && sed -i "s/DB_NAME/influxdb/g" /etc/telegraf/telegraf.conf \
	&& sed -i "s/http:\/\/influxdb:/http:\/\/127.0.0.1:/g" /etc/telegraf/telegraf.conf

CMD screen -dmS telegraf telegraf ; \
	screen -dmS influxd influxd ; \
	tail -F /dev/null

EXPOSE 8086