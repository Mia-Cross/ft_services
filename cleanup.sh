# nettoyer les fichiers de config
#kubectl delete -f srcs/mysql/mysql.yaml
#kubectl delete -f srcs/phpmyadmin/phpmyadmin.yaml
#kubectl delete -f srcs/wordpress/wordpress.yaml
#kubectl delete -f srcs/grafana/grafana.yaml
#kubectl delete -f srcs/influxdb/influxdb.yaml
kubectl delete -f srcs/nginx/nginx.yaml
kubectl delete -f srcs/ftps/ftps.yaml

# supprimer les services
#kubectl delete services wordpress
#kubectl delete services nginx
#kubectl delete services mysql
#kubectl delete services phpmyadmin

# supprimer les deploiements
#kubectl delete deployments wordpress-deployment
#kubectl delete deployments nginx-deployment
#kubectl delete deployments mysql-deployment
#kubectl delete deployments phpmyadmin-deployment

# arreter le cluster
#minikube stop

# relancer ?
#	minikube start

# "machine does not exist" ?
#	rm -rf ~/.minikube