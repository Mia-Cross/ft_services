# supprimer les services
kubectl delete services wordpress
kubectl delete services nginx
kubectl delete services mysql
kubectl delete services phpmyadmin

#supprimer le PVC
#kubectl delete -f srcs/mysql/pvc_mysql.yaml

# supprimer le deploiement
kubectl delete deployments wordpress-deployment
kubectl delete deployments nginx-deployment
kubectl delete deployments mysql-deployment
kubectl delete deployments phpmyadmin-deployment

# arreter le cluster
#minikube stop

# relancer ?
#	minikube start

# "machine does not exist" ?
#	rm -rf ~/.minikube