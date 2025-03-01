CLUSTER="do-dev-unum"
DATABASE="do-dev-unum"

.PHONY: tfenv init install context connect uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

install: init
	terraform apply

context:
	doctl kubernetes cluster kubeconfig save ${CLUSTER} --alias ${CLUSTER}

connect:
	doctl databases connection ${DATABASE}

uninstall: init
	terraform destroy
