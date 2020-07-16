#!/bin/bash

##########################
# demarrer le cluster ou clean le build precedent ?
#minikube start --vm-driver="virtualbox"
bash cleanup.sh

###########################
# create namespace
#kubectl apply -f srcs/ns_ft_services.yaml

############################
# load-balancer : MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
cp srcs/metallb/config_base.yaml srcs/metallb/config.yaml
sed -ie "s/MINIKUBE_IP/$(minikube ip)/g" srcs/metallb/config.yaml
kubectl apply -f srcs/metallb/config.yaml

############################
# faire le lien entre les docker daemons de minikube et de docker
eval $(minikube docker-env)

##########################
# nginx
cd srcs/nginx
docker build -t my_nginx .
kubectl apply -f nginx.yaml

##########################
# my_sql
cd ../mysql
docker build -t my_mysql .
kubectl apply -f mysql.yaml
#kubectl apply -k ./

##########################
# wordpress
cd ../wordpress
docker build -t my_wordpress .
kubectl apply -f wordpress.yaml

##########################
# phpmyadmin
cd ../phpmyadmin
docker build -t my_phpmyadmin .
kubectl apply -f phpmyadmin.yaml

#screen -dmS dash minikube dashboard
