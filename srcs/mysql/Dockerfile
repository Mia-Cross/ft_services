FROM alpine:latest

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apt-get update && apt-get upgrade\
    && apt-get install -y mariadb-server

#configuration de mysql = creer un utilisateur priviligié de la base de données
RUN	service mysql start \
	mysql -u root -e "CREATE DATABASE wordpress" \
	mysql -u root -e "GRANT ALL ON wordpress.* TO 'lemarabe'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION" \
	mysql -u root -e "FLUSH PRIVILEGES"

# redemarrer mysql pour appliquer les modifs de config
RUN service mysql restart

# faire le lien avec les ports phpmyadmin et wordpress
EXPOSE 5000 5050