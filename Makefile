IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-chaosmesh:
	bash app/deploy-chaosmesh.sh

provision-helm:
	bash app/provision-helm.sh

provision-kubectl:
	bash app/provision-kubectl.sh

deploy-kind:
	bash deploy-kind.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-kind deploy-openesb deploy-dashboard deploy-dashboard-helm deploy-istio push-image
