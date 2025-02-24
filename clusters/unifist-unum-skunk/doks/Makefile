CLUSTER=unifist-unum-skunk

.PHONY: tfenv init install context uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

install: init
	terraform apply

context:
	doctl kubernetes cluster kubeconfig save ${CLUSTER} --alias ${CLUSTER}

uninstall: init
	terraform destroy
