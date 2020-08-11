#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# https://chaos-mesh.org/docs/installation/get_started_on_minikube/
echo "===============================Install Chaos Mesh==========================================================="

kubectl get nodes
strace -eopenat kubectl version

docker container ls
docker version
kubeadm version
kubectl version
kubelet version

# Kubernetes master is running at https://135.122.6.50:6443
kubectl cluster-info

kubectl config get-contexts
# CURRENT   NAME   CLUSTER   AUTHINFO   NAMESPACE
# kubectl config use-context minikube
# error: no context exists with the name: "minikube"



# Check whether the helm tiller pod is running
kubectl -n kube-system get pods -l app=helm

/bin/sh -c 'curl -sSL https://raw.githubusercontent.com/chaos-mesh/chaos-mesh/master/install.sh | bash' 
# curl -sSL https://raw.githubusercontent.com/chaos-mesh/chaos-mesh/master/install.sh | bash


#Deploy the sample application
kubectl get service --all-namespaces #list all services in all namespace
kubectl get services #The application will start. As each pod becomes ready, the Istio sidecar will deploy along with it.
kubectl get pods

echo "Waiting for chaos-mesh to be ready ..."
for i in {1..60}; do # Timeout after 3 minutes, 60x5=300 secs
     if kubectl get pods --namespace=chaos-testing  | grep ContainerCreating ; then
         sleep 5
     else
         break
     fi
done

kubectl get service --all-namespaces #list all services in all namespace
# Verify your installation
kubectl get pod -n chaos-testing
