# supprimer les services
kubectl delete services wordpress --namespace=wordpress
kubectl delete services nginx --namespace=nginx

# supprimer le deploiement
#kubectl delete namespaces ft-services

# arreter le cluster
#minikube stop

# relancer ?
#	minikube start

# "machine does not exist" ?
#	rm -rf ~/.minikube