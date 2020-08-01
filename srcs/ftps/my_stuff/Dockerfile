FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs import

RUN apk add vsftpd openssl filezilla && adduser -D userftps \
    && mv import/vsftpd.conf /etc/vsftpd/ \
    && mkdir -p /home/userftps/ftp /var/run/vsftpd/empty \
    && chown nobody:nogroup /home/userftps/ftp && chmod a-w /home/userftps/ftp \
    && mv import/vsftpd.userlist /etc/vsftpd/vsftpd.userlist \
#    && mv import/confd /etc/conf.d/vsftpd \
    && echo "If you can see this Im a FUCKING BOSS" > /home/userftps/ftp/boss.txt \
	&& sed -i "s/TMP_BDD/ftps/g" /etc/telegraf/telegraf.conf

CMD sh import/define_user_pswd.sh ; \
    screen -dmS telegraf telegraf ; \
    screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf ; tail -F /dev/null
#    screen -dmS filezilla filezilla ; \
#    tail -F /dev/null

EXPOSE 21 36000