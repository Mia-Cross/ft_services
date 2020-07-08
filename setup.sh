#!/bin/bash

##########################
# lancher docker (MacOS only)
#bash ~/42toolbox/init_docker.sh
# demarrer le cluster
minikube start
# clean le build precedent
#bash cleanup.sh

###########################
# create namespace
#kubectl apply -f srcs/ns_ft_services.yaml

############################
# load-balancer : MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/config.yaml
kubectl config set-context $(kubectl config current-context) --namespace=metallb-system

############################
# faire le lien entre les docker daemons de minikube et de docker
eval $(minikube docker-env)

##########################
# nginx
cd srcs/nginx
docker build -t my_nginx .
#kubectl apply -f ns_nginx.yaml
#kubectl apply -f pod_nginx.yaml
#kubectl apply -f service_nginx.yaml

##########################
# wordpress
#cd ../wordpress
#docker build -t my_wordpress .
#kubectl apply -f ns_wordpress.yaml
#kubectl apply -f service_wordpress.yaml

##########################
# deploiement
cd ..
#kubectl apply -f deploy_ft_services.yaml
kubectl apply -f tuto.yaml
#kubectl apply -f service_nginx.yaml
#kubectl expose deployment ft-services --type=LoadBalancer --name=my-metallb
#kubectl expose service my-metallb --type=NodePort --name=ss-nginx
#kubectl expose deployment ft-services --type=NodePort --name=wordpress
