CLUSTER="do-fitches-unum"
ARGOCD_PORT=6567
.PHONY: tfenv init remote install uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

remote:
	kubectx ${CLUSTER}
	@echo "u/p u: admin p;"
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
	@echo "\n"
	@open "http://localhost:${ARGOCD_PORT}"
	kubectl port-forward -n argocd service/argocd-server ${ARGOCD_PORT}:http

install: init
	terraform apply

uninstall: init
	terraform destroy
