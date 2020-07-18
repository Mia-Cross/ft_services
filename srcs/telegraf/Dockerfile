FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs .

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk add telegraf@testing

RUN mkdir /etc/telegraf && mv telegraf.conf /etc/telegraf/

CMD telegraf ; sh