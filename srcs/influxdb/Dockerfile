FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

#COPY srcs .

RUN apk add influxdb \
	&& sed -i "s/http:\/\/influxdb:/http:\/\/127.0.0.1:/g" /etc/telegraf/telegraf.conf \
	&& sed -i "s/TMP_BDD/influxdb/g" /etc/telegraf/telegraf.conf
#RUN mkdir /etc/influxdb && mv influxdb.conf /etc/influxdb/

CMD screen -dmS telegraf telegraf ; screen -dmS influxdb influxd ; tail -F /dev/null

EXPOSE 8086