sleep 30
cp srcs/mysql/srcs/wordpress_base.sql srcs/mysql/srcs/wordpress.sql
while [[ ! `kubectl exec deploy/mysql-deployment -- mysqladmin ping` ]]
do
	sleep 3
done
if [[ `grep WORDPRESS_IP srcs/mysql/srcs/wordpress.sql` ]]
then
	IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	while [ $IPWP = '<none>' ]
	do
		sleep 1
		IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	done
	sed -ie "s/WORDPRESS_IP/$IPWP/g" srcs/mysql/srcs/wordpress.sql
	eval $(minikube docker-env)
	docker build -t my_mysql srcs/mysql/
	eval $(minikube docker-env -u)
	kubectl set image deployment/mysql-deployment mysql=my_mysql --record
	kubectl exec deploy/mysql-deployment -- mysql -u root wordpress < srcs/mysql/srcs/wordpress.sql > cmd_output
fi

#faut faire le grep et le sed a l exterieur banane !
#allez bye a demain !