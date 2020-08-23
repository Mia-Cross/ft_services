FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs import

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add curl && apk add grafana@testing \
	&& sed -i "s/DB_NAME/grafana/g" /etc/telegraf/telegraf.conf \
	&& mv import/provisioning /usr/share/grafana/

CMD screen -dmS telegraf telegraf ; \
	screen -dmS grafana grafana-server --homepath "usr/share/grafana" \
	--config "import/grafana.ini"; tail -F /dev/null

EXPOSE 3000