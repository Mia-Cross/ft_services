sleep 30
while [[ ! `kubectl exec deploy/mysql-deployment -- mysqladmin ping` ]]
do
	sleep 3
done
if [[ `kubectl exec deploy/mysql-deployment -- grep WORDPRESS_IP /import/wordpress.sql` ]]
then
	IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	while [ $IPWP = '<none>' ]
	do
		sleep 1
		IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	done
	kubectl exec deploy/mysql-deployment -- ls import > ls_before
	kubectl exec deploy/mysql-deployment -- head -n 115 /import/wordpress.sql | tail -n 10 > file_before
	kubectl exec deploy/mysql-deployment -- sed -ie "s/WORDPRESS_IP/$IPWP/g" /import/wordpress.sql
	kubectl exec deploy/mysql-deployment -- ls import > ls_after
	kubectl exec deploy/mysql-deployment -- head -n 115 /import/wordpress.sql | tail -n 10 > file_after
	kubectl exec deploy/mysql-deployment -- mysql -u root wordpress < srcs/mysql/srcs/wordpress.sql
fi