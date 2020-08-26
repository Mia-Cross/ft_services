#!/bin/bash

while true
do
	if [ `kubectl exec deploy/ftps -- grep FTPS_IP /etc/vsftpd/vsftpd.conf` ]
	then
		IPFTPS=`kubectl get services/ftps -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		while [ $IPFTPS = '<none>' ]
		do
			sleep 1
			IPFTPS=`kubectl get services/ftps -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		done
		kubectl exec deploy/ftps -- pkill vsftpd
		kubectl exec deploy/ftps -- sed -ie "s/FTPS_IP/$IPFTPS/g" /etc/vsftpd/vsftpd.conf
		kubectl exec deploy/ftps -- screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf
		echo "$IPFTPS (FTPS)" > services_ips
	fi
	sleep 10
done
