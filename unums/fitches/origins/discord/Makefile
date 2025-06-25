CLUSTER="do-fitches-unum"
NAMESPACE="discord"

.PHONY: tfenv init remote install secret uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

install: init
	terraform apply

secret:
	./secret.sh ${CLUSTER} ${NAMESPACE}

remote:
	kubectl --context=${CLUSTER} -n ${NAMESPACE} logs `kubectl --context=${CLUSTER} -n ${NAMESPACE} get pod | grep '-daemon' | awk '{print $1}'`

uninstall: init
	terraform destroy
