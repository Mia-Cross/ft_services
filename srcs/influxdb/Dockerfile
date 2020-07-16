FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

#COPY srcs .

RUN apk add influxdb \
	&& sed -i 's/TMP_PORT/3000/g' /etc/nginx/nginx.conf

CMD sh

EXPOSE 8086