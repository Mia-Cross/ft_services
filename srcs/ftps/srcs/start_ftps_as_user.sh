passwd userftps << EOF
simple
simple
EOF
screen -dmS telegraf telegraf
screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf
