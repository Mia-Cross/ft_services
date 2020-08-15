FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs/ import/

RUN apk add vsftpd openssl && adduser -D userftps \
    && mv import/vsftpd.conf /etc/vsftpd/ \
    && mv /import/ssl/certs/* /etc/ssl/certs/ \
    && mv /import/ssl/private/* /etc/ssl/private/ \
    && mkdir -p /home/userftps/ftp /var/run/vsftpd/empty \
    && chown nobody:nogroup /home/userftps/ftp && chmod 777 /home/userftps/ftp \
    && mv import/vsftpd.userlist /etc/vsftpd/vsftpd.userlist \
    && mv import/deer_interview.jpg /home/userftps/ftp \
    && mv import/file.txt /home/userftps/ftp \
	&& sed -i "s/TMP_BDD/ftps/g" /etc/telegraf/telegraf.conf

CMD sh import/define_user_pwd.sh ; \
    screen -dmS telegraf telegraf ; \
    screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf ; \
    tail -F /dev/null

EXPOSE 21 36000