# supprimer les services
kubectl delete services wordpress
kubectl delete services nginx

# supprimer le deploiement
kubectl delete deployment ft-services

# arreter le cluster
#minikube stop

# relancer ?
#	minikube start

# "machine does not exist" ?
#	rm -rf ~/.minikube