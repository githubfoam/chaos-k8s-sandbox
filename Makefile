IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-chaosmesh-minikube:
	bash app/deploy-chaosmesh-minikube.sh

deploy-chaosmesh-kind:
	bash app/deploy-chaosmesh-kind.sh

provision-helm:
	bash app/provision-helm.sh

provision-kubectl:
	bash app/provision-kubectl.sh

deploy-kind:
	bash platform/deploy-kind.sh

deploy-microk8s:
	bash platform/deploy-microk8s.sh

deploy-k3d:
	bash platform/deploy-k3d.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-kind deploy-openesb deploy-dashboard deploy-dashboard-helm deploy-istio push-image
