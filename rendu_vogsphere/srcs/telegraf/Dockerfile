FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs/ import/

RUN apk update && apk upgrade && apk add openrc openssh mysql-client screen \
	&& echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add telegraf@testing \
	&& mkdir /etc/telegraf && mv /import/telegraf.conf /etc/telegraf/