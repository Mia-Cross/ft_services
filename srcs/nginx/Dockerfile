# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lemarabe <lemarabe@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/14 18:41:53 by lemarabe          #+#    #+#              #
#    Updated: 2020/08/01 15:54:07 by lemarabe         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

RUN apk update && apk upgrade && apk add nginx \
	&& apk add libmcrypt-dev zlib-dev gmp-dev freetype-dev libjpeg-turbo-dev libpng-dev \
	&& apk add php7 php7-fpm php7-json php7-zlib php7-xml php7-pdo php7-phar \
    php7-pdo_mysql php7-mysqli php7-session php7-openssl php7-gd php7-iconv \
    php7-mcrypt php7-gmp php7-zip php7-curl php7-opcache php7-ctype php7-apcu \
    php7-intl php7-bcmath php7-dom php7-mbstring php7-xmlreader \
	&& mkdir -p /home/lemarabe/.ssh

COPY srcs/ import/

RUN sh /import/prepare_nginx.sh \
	&& sed -i "s/DB_NAME/nginx/g" /etc/telegraf/telegraf.conf

CMD sed -i 's/TMP_PORT/80/g' /etc/nginx/nginx.conf ; \
	sh import/start_nginx.sh ; tail -F /dev/null

EXPOSE 80 443 22
