#!/bin/bash

##############################################
#        INSTALL ALL NEEDED COMPONENTS       #
##############################################
SYSTEM=`uname -s`
if [[ ! `which minikube` ]] || [[ `which minikube` = 'minikube not found' ]]
then
    echo "Minikube not found, installing..."
    if [ $SYSTEM = 'Linux' ]
    then
        snap install minikube
    else
        brew install minikube
    fi
fi
if [[ ! `which screen` ]] || [[ `which screen` = 'screen not found' ]]
then
    echo "Screen not found, installing..."
    if [ $SYSTEM = 'Linux' ]
    then
        sudo apt-get install screen
    else
        brew install screen
    fi
fi
if [[ ! `which filezilla` ]] || [[ `which filezilla` = 'filezilla not found' ]]
then
    echo "FileZilla not found, installing..."
    if [ $SYSTEM = 'Linux' ]
    then
        sudo apt-get install filezilla
    else
        tar -xjf srcs/ftps/FileZilla_3.49.1_macosx-x86.app.tar.bz2
    fi
fi

##############################################
#   START THE CLUSTER (depending on the OS)  #
##############################################
if [ $SYSTEM = 'Linux' ]
then
    VM_DRIVER="docker"
    NB_CORES=2
    MEM=3000
    FZ_PATH=""
    if [[ $(groups | grep docker) = '' ]]
    then
        sudo usermod -aG docker $USER && newgrp docker
    fi
    if [[ $(service docker status | grep running) = '' ]]
    then
        echo "Starting Docker service..."
        service docker start
        while [[ $(service docker status | grep running) = '' ]]
        do
            sleep 1
        done
    fi
else
    VM_DRIVER="virtualbox"
    NB_CORES=4
    MEM=5000
    FZ_PATH="./FileZilla.app/Contents/MacOS/"
    if [[ $(launchctl list | grep docker.docker) = '' ]]
    then
        echo "Starting Docker service..."
        launchctl start docker
        while [[ $(launchctl list | grep docker.docker) = '' ]]
        do
            sleep 1
        done
    fi
fi
echo "Starting the cluster now..."
minikube start --vm-driver=$VM_DRIVER --cpus=$NB_CORES --memory=$MEM
screen -dmS filezilla ${FZ_PATH}filezilla

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
    IP=`echo $IP|awk -F '.' '{print $1"."$2"."$3"."128}'`
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
#    DATABASE HANDLING    #
###########################

eval $(minikube docker-env)
docker build -t my_telegraf srcs/telegraf/
docker build -t my_nginx srcs/nginx/
docker build -t my_wordpress srcs/wordpress/
eval $(minikube docker-env -u)
kubectl apply -f srcs/wordpress/wordpress.yaml
IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
while [ $IPWP = '<none>' ]
do
	sleep 1
	IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
done
cp srcs/mysql/srcs/wordpress_base.sql srcs/mysql/srcs/wordpress.sql
sed -ie "s/WORDPRESS_IP/$IPWP/g" srcs/mysql/srcs/wordpress.sql

###########################
#   BUILD DOCKER IMAGES   #
###########################
eval $(minikube docker-env)
#docker build -t my_telegraf srcs/telegraf/
#docker build -t my_nginx srcs/nginx/
docker build -t my_ftps srcs/ftps/
docker build -t my_grafana srcs/grafana/
docker build -t my_influxdb srcs/influxdb/
docker build -t my_mysql srcs/mysql/
docker build -t my_phpmyadmin srcs/phpmyadmin/
#docker build -t my_wordpress srcs/wordpress/
eval $(minikube docker-env -u)

#########################
#    DEPLOY SERVICES    #
#########################
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/grafana/grafana.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
#kubectl apply -f srcs/wordpress/wordpress.yaml

##########################
#    LAST ADJUSTMENTS    #
##########################
echo ""
screen -dmS ftpip ./srcs/ftps/srcs/get_ftps_ip.sh
echo "Getting IP for FTPS, it will be running shortly..."
echo "Waiting a few moments before launching other services..."
sleep 10
echo "Launching dashboard..."
screen -dmS dashboard minikube dashboard
echo "Importing MySQL database for WordPress, it will be running shortly..."
#bash srcs/mysql/import_wp_database2.sh
echo "Thank you for waiting :)"
echo ""
#while
