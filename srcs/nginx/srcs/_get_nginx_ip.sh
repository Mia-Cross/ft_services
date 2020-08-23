#!/bin/bash

while true
do
    if [[ `kubectl exec deploy/nginx-deployment -- grep NGINX_IP /etc/ssh/sshd_config` ]]
    then
        #echo "looking for address"
        IPNGINX=`kubectl get services/nginx -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
        while [ $IPNGINX = '<none>' ]
        do
	        sleep 1
	        IPNGINX=`kubectl get services/nginx -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
        done
        kubectl exec deploy/nginx-deployment -- pkill sshd
        kubectl exec deploy/nginx-deployment -- sed -ie "s/NGINX_IP/$IPNGINX/g" /etc/ssh/sshd_config
        kubectl exec deploy/nginx-deployment -- screen -dmS ssh /usr/sbin/sshd -D
        export NGINX_IP=$IPNGINX
    fi
    #echo "begin sleep"
    sleep 10
done