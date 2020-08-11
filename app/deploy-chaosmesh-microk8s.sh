#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# https://chaos-mesh.org/docs/installation/get_started_on_minikube/
echo "===============================Install Chaos Mesh==========================================================="



microk8s kubectl kubectl config get-contexts

# Check whether the helm tiller pod is running
microk8s kubectl -n kube-system get pods -l app=helm

/bin/sh -c 'curl -sSL https://raw.githubusercontent.com/chaos-mesh/chaos-mesh/master/install.sh | bash' 
# curl -sSL https://raw.githubusercontent.com/chaos-mesh/chaos-mesh/master/install.sh | bash


#Deploy the sample application
microk8s  kubectl get service --all-namespaces #list all services in all namespace
microk8s  kubectl get services #The application will start. As each pod becomes ready, the Istio sidecar will deploy along with it.
microk8s  kubectl get pods

echo "Waiting for chaos-mesh to be ready ..."
for i in {1..60}; do # Timeout after 3 minutes, 60x5=300 secs
     if microk8s  kubectl get pods --namespace=chaos-testing  | grep ContainerCreating ; then
         sleep 5
     else
         break
     fi
done

microk8s  kubectl get service --all-namespaces #list all services in all namespace

# Verify your installation
microk8s  kubectl get pod -n chaos-testing
