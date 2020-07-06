#!/bin/bash

# demarrer le cluster
minikube start

# clean le build precedent
bash cleanup.sh

# load-balancer : MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# nginx
cd srcs/nginx
echo ""
ls
echo ""
docker build -t my_nginx .
echo 1
kubectl apply -f ns_nginx.yaml
echo 2
kubectl apply -f service_nginx.yaml
echo 3

#kubectl exec nginx -- bash
cd ../wordpress
echo ""
ls
echo ""
docker build -t my_wordpress .
kubectl apply -f ns_wordpress.yaml
kubectl apply -f service_wordpress.yaml

cd ..
kubectl apply -f ns_ft_services.yaml
kubectl apply -f deploy_ft_services.yaml







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


