FROM my_nginx:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs .

RUN apk add influxdb \
	&& mv import/nginx_for_services.conf /etc/nginx/nginx.conf \
	&& sed -i 's/TMP_PORT/8086/g' /etc/nginx/nginx.conf

RUN mkdir /etc/influxdb && mv influxdb.conf /etc/influxdb/

CMD nginx ; php-fpm7 ; tail -F /dev/null

EXPOSE 8086