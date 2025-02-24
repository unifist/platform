.PHONY: tfenv init install uninstall

tfenv:
	tfenv use 1.10.5

init: tfenv
	terraform init

install: init
	terraform apply

uninstall: init
	terraform destroy
