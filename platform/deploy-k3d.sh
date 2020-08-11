#!/bin/bash


echo "=============================k3d============================================================="
sh -c "curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash" #grab the latest release
k3d version
k3d check-tools #Check if docker is running
k3d --timestamp --verbose  create cluster --wait 360 --name demo --workers 4
docker ps
k3d list clusters
export KUBECONFIG="$(sudo k3d get-kubeconfig --name='demo')"
cat $KUBECONFIG
kubectl get nodes
sudo kubectl get pod -o wide
sudo kubectl get pod -n kube-system -o wide
sudo kubectl get pod -n default -o wide
sudo kubectl get pods --all-namespaces
sudo kubectl get service --all-namespaces
sudo kubectl cluster-info
for i in {1..60}; do # Timeout after 5 minutes, 60x1=60 secs
      if nc -z -v 127.0.0.1 6443 2>&1 | grep succeeded ; then
        break
      fi
      sleep 5
done
kubectl get nodes --all-namespaces # verify "*helm-install-traefik-*"
for i in {1..60}; do # Timeout after 5 minutes, 60x7= 7 mins
      if [[ $(kubectl get nodes | awk '{print $1}') == "*helm-install-traefik-*" ]] && [[ $(sudo kubectl get nodes | awk '{print $4}') == "Running" ]]; then
        break
      fi
      sleep 3
done
kubectl get nodes --all-namespaces # verify "*helm-install-traefik-*"
kubectl get pods --namespace=kube-system # verify namespace=kube-system Running
echo "Waiting for Kubernetes to be ready ..."
for i in {1..150}; do # Timeout after 5 minutes, 150x2=300 secs
      if sudo kubectl get pods --namespace=kube-system | grep Running ; then
        break
      fi
      sleep 2
done
kubectl get pods --namespace=kube-system # verify namespace=kube-system Running
kubectl get nodes
kubectl get pod -o wide
kubectl get pod -n kube-system -o wide
kubectl get pod -n default -o wide
kubectl get pods --all-namespaces
kubectl get service --all-namespaces
kubectl cluster-info
echo "=============================k3d============================================================="
