#!/bin/bash

##############################################
#   START THE CLUSTER (depending on the OS)  #
##############################################
SYSTEM=`uname -s`
if [ $SYSTEM = 'Linux' ]
then
    VM_DRIVER="docker"
    NB_CORES=2
    CMD="sudo apt-get"
    if [[ $(groups | grep docker) = '' ]]
    then
        sudo usermod -aG docker $USER && newgrp docker
    fi
    if [[ $(service docker status | grep running) = '' ]]
    then
        service docker start
        while [[ $(service docker status | grep running) = '' ]]
        do
            sleep 1
        done
    fi
else
    VM_DRIVER="virtualbox"
    NB_CORES=4
    CMD="brew"
    if [[ $(launchctl list | grep docker.docker) = '' ]]
    then
        ## exec 42toolbox script
        while [[ $(launchctl list | grep docker.docker) = '' ]]
        do
            sleep 1
        done
    fi
fi
if [ `which screen` = 'screen not found' ]
then
    $CMD install screen
fi
if [ `which filezilla` = 'filezilla not found' ]
then
    $CMD install filezilla
    #enfait ca va pas marcher sur mac, faut DL a la main
fi
minikube start --vm-driver=$VM_DRIVER --cpus=$NB_CORES
screen -dmS filezilla filezilla

######################################
#      CLEAN-UP PREVIOUS BUILD ?     #
######################################
#kubectl delete -f srcs/ftps/ftps.yaml
#kubectl delete -f srcs/grafana/grafana.yaml
#kubectl delete -f srcs/influxdb/influxdb.yaml
#kubectl delete -f srcs/mysql/mysql.yaml
#kubectl delete -f srcs/nginx/nginx.yaml
#kubectl delete -f srcs/phpmyadmin/phpmyadmin.yaml
#kubectl delete -f srcs/wordpress/wordpress.yaml

######################################
# CONFIGURE METALLB AS LOAD-BALANCER #
######################################
if [ $SYSTEM = 'Linux' ]
then
    IP=`docker inspect minikube --format="{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}"`
    #IP=`echo $IP|awk -F '.' '{print $1"."$2"."$3"."128}'`
else
    IP=`minikube ip`
fi
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
cp srcs/metallb/config_base.yaml srcs/metallb/config.yaml
sed -ie "s/MINIKUBE_IP/$IP/g" srcs/metallb/config.yaml
kubectl apply -f srcs/metallb/config.yaml

###########################
#   BUILD DOCKER IMAGES   #
###########################
eval $(minikube docker-env)
docker build -t my_telegraf srcs/telegraf/
docker build -t my_nginx srcs/nginx/
docker build -t my_ftps srcs/ftps/
docker build -t my_grafana srcs/grafana/
docker build -t my_influxdb srcs/influxdb/
docker build -t my_mysql srcs/mysql/
docker build -t my_phpmyadmin srcs/phpmyadmin/
docker build -t my_wordpress srcs/wordpress/

#########################
#    DEPLOY SERVICES    #
#########################
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/grafana/grafana.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml

##########################
#    LAST ADJUSTMENTS    #
##########################
#echo "Waiting 10 seconds in order to make the last adjusments"
#sleep 10
#screen -dmS dash minikube dashboard
#echo "Dashboard launched !"
screen -dmS ftp ./srcs/ftps/srcs/get_ftps_ip.sh
echo "Getting IP for FTPS, it will be running shortly..."
echo "Thank you for waiting :)"
