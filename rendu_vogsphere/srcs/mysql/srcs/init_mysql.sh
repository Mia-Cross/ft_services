#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi
if [ ! -d "/var/log/mysql" ]; then
  mkdir -p /var/log/mysql
fi
if [ ! -d "/var/lib/mysql" ]; then
  mkdir -p /var/lib/mysql
fi
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
tfile=`mktemp`
if [ ! -f "$tfile" ]; then
    return 1
fi
cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'meh' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
CREATE USER 'user'@'%' IDENTIFIED BY 'random';
GRANT ALL ON *.* TO 'user'@'%';
CREATE DATABASE wordpress;
FLUSH PRIVILEGES;
EOF
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
rm -f $tfile
screen -dmS mysql /usr/bin/mysqld --user=mysql --console
sleep 10
while [[ ! `mysqladmin ping` ]]
do
	sleep 3
done
mysql -u root wordpress < /import/wordpress.sql > cmd_output