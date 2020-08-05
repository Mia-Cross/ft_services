#!/bin/bash

##########################
# demarrer le cluster

## sur MAC :
minikube start --vm-driver="virtualbox"
bash cleanup.sh

## dans la VM :
#NEED 2 CPUs TO WORK PROPERLY !!!
#verifier si screen est installee
#service docker start
#sudo usermod -aG docker $USER && newgrp docker
#minikube start --driver=docker

############################
# obtenir l'IP de Minikube puis passer dans l'env docker de minikube
#cp srcs/metallb/config_base.yaml srcs/metallb/config.yaml
#sed -ie "s/MINIKUBE_IP/$(minikube ip)/g" srcs/metallb/config.yaml
#cp srcs/ftps/srcs/vsftpd_base.conf srcs/ftps/srcs/vsftpd.conf
#sed -ie "s/MINIKUBE_IP/$(minikube ip)/g" srcs/ftps/srcs/vsftpd.conf
eval $(minikube docker-env)

############################
# load-balancer : MetalLB
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
#kubectl apply -f srcs/metallb/config.yaml

##########################
# telegraf
#docker build -t my_telegraf srcs/telegraf/
##########################
# nginx
docker build -t my_nginx srcs/nginx/
kubectl apply -f srcs/nginx/nginx.yaml
##########################
# influxdb
#docker build -t my_influxdb srcs/influxdb/
#kubectl apply -f srcs/influxdb/influxdb.yaml
##########################
# grafana
#docker build -t my_grafana srcs/grafana/
#kubectl apply -f srcs/grafana/grafana.yaml
##########################
# mysql
#docker build -t my_mysql srcs/mysql/
#kubectl apply -f srcs/mysql/mysql.yaml
##########################
# wordpress
#docker build -t my_wordpress srcs/wordpress/
#kubectl apply -f srcs/wordpress/wordpress.yaml
##########################
# phpmyadmin
#docker build -t my_phpmyadmin srcs/phpmyadmin/
#kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
##########################
# ftps
docker build -t my_ftps srcs/ftps/
kubectl apply -f srcs/ftps/ftps.yaml

##########################
# lancer les utilitaires
echo "Waiting until Dashboard launch"
sleep 10
screen -dmS dash minikube dashboard
echo -n "Trying to get FTPS IP... "
screen -dmS ftp ./srcs/ftps/srcs/setup_ftps.sh
echo "Done ! You're all set :)"
