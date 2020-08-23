adduser -D lemarabe
passwd lemarabe << EOF
qwerty
qwerty
EOF
screen -dmS telegraf telegraf
nginx
php-fpm7
screen -dmS ssh /usr/sbin/sshd -D