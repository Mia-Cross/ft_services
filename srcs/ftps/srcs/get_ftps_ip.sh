while true
do
	if [ `kubectl exec deploy/ftps-deployment -- grep FTPS_IP /etc/vsftpd/vsftpd.conf` ]
	then
		IPFTPS=`kubectl get services/ftps -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		while [ $IPFTPS = '<none>' ]
		do
			sleep 1
			IPFTPS=`kubectl get services/ftps -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		done
		kubectl exec deploy/ftps-deployment -- pkill vsftpd
		kubectl exec deploy/ftps-deployment -- sed -ie "s/FTPS_IP/$IPFTPS/g" /etc/vsftpd/vsftpd.conf
		kubectl exec deploy/ftps-deployment -- screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf
	fi
	sleep 10
done
