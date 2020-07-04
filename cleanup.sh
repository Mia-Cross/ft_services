sudo kubeadm reset
rm -rf /etc/cni/net.d
rm $HOME/.kube/config

#kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
#kubeadm reset
#kubectl delete node <node name>