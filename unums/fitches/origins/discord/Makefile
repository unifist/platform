CLUSTER="do-fitches-unum"
NAMESPACE="discord"

.PHONY: tfenv init install secret uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

install: init
	terraform apply

secret:
	./secret.sh ${CLUSTER} ${NAMESPACE}

uninstall: init
	terraform destroy
