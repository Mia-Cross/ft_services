#!/bin/bash

##########################
# demarrer le cluster ou clean le build precedent ?
minikube start --vm-driver="virtualbox"
#bash cleanup.sh

############################
# load-balancer : MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
cp srcs/metallb/config_base.yaml srcs/metallb/config.yaml
sed -ie "s/MINIKUBE_IP/$(minikube ip)/g" srcs/metallb/config.yaml
kubectl apply -f srcs/metallb/config.yaml

############################
# faire le lien entre les docker daemons de minikube et de docker
eval $(minikube docker-env)

##########################
# telegraf
docker build -t my_telegraf srcs/telegraf/
##########################
# nginx
docker build -t my_nginx srcs/nginx/
kubectl apply -f srcs/nginx/nginx.yaml
#########################
# influxdb
docker build -t my_influxdb srcs/influxdb/
kubectl apply -f srcs/influxdb/influxdb.yaml
##########################
# grafana
docker build -t my_grafana srcs/grafana/
kubectl apply -f srcs/grafana/grafana.yaml
##########################
# mysql
docker build -t my_mysql srcs/mysql/
kubectl apply -f srcs/mysql/mysql.yaml
##########################
# wordpress
docker build -t my_wordpress srcs/wordpress/
kubectl apply -f srcs/wordpress/wordpress.yaml
##########################
# phpmyadmin
docker build -t my_phpmyadmin srcs/phpmyadmin/
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
##########################
# ftps
docker build -t my_ftps srcs/ftps/
kubectl apply -f srcs/ftps/ftps.yaml
screen -dmS ftp ./srcs/ftps/setup_ftps.sh

screen -dmS dash minikube dashboard
