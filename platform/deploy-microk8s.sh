#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "=============================deploy microk8s============================================================="
usermod -a -G microk8s $USER #add your current user to the group and gain access to the .kube caching directory

#microk8s status --wait-ready #Check the status
echo "Waiting for  microk8s to be ready ..."
# for i in {1..60}; do # Timeout after 5 minutes, 60x5=300 secs
#     if sudo microk8s kubectl get pods --namespace=kube-system | grep Running ; then
#       break
#     fi
#     sleep 3
# done
for i in {1..60}; do # Timeout after 3 minutes, 60x5=300 secs
     if microk8s kubectl get pods --namespace=kube-system  | grep ContainerCreating ; then
         sleep 5
     else
         break
     fi
done

microk8s kubectl get pods --all-namespaces
microk8s kubectl get pod -o wide #The IP column will contain the internal cluster IP address for each pod.
microk8s kubectl get service --all-namespaces # find a Service IP,list all services in all namespaces
microk8s kubectl get nodes
microk8s kubectl get services




microk8s kubectl version
microk8s kubectl version --client #the version of the client
microk8s kubectl cluster-info
microk8s status
