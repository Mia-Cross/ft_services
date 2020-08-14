FROM my_telegraf:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

COPY srcs import

RUN apk add vsftpd openssl && adduser -D userftps \
    && mv import/vsftpd.conf /etc/vsftpd/ \
    && mv /import/ssl/certs/* /etc/ssl/certs/ \
    && mv /import/ssl/private/* /etc/ssl/private/ \
    && mkdir -p /home/userftps/ftp /var/run/vsftpd/empty \
    && chown nobody:nogroup /home/userftps/ftp && chmod 777 /home/userftps/ftp \
    && mv import/vsftpd.userlist /etc/vsftpd/vsftpd.userlist \
    && echo "If you can see this Im a M_TH_RF_CK_NG BOSS" > /home/userftps/ftp/boss.txt \
	&& sed -i "s/TMP_BDD/ftps/g" /etc/telegraf/telegraf.conf
#    && mv import/confd /etc/conf.d/vsftpd \

CMD sh import/start_ftps_as_user.sh ; \
    tail -F /dev/null

EXPOSE 21 36000