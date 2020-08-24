eval $(minikube docker-env)
docker build -t my_telegraf srcs/telegraf
docker build -t my_influxdb srcs/influxdb
kubectl delete -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml