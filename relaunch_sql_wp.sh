eval $(minikube docker-env)
docker build -t my_mysql srcs/mysql/
docker build -t my_wordpress srcs/wordpress/
kubectl delete -f srcs/mysql/mysql.yaml
kubectl delete -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
eval $(minikube docker-env -u)

#bash srcs/mysql/import_wp_database2.sh