#!/bin/bash

# demarrer le cluster
minikube start

# nginx
docker build -t srcs/nginx:v1 .

#kubectl create deployment nginx --image=
kubectl exec nginx service nginx start && service php7.3-fpm start







#init le cluster

#sudo kubeadm init --pod-network-cidr=192.168.0.0/16
	#on peut changer l'adresse si le port est deja occupe
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

#ajouter le dashboard web de kubernetes
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml

#install calico
#kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
#kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
#watch kubectl get pods -n kube-system
#kubectl taint nodes --all node-role.kubernetes.io/master-
#kubectl get nodes -o wide
#kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml

# "SSH to the machine"
#sudo apt-get install openssh-server


