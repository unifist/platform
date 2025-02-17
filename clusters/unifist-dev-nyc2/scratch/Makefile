CLUSTER=do-nyc2-unifist-dev-nyc2
APP=scratch

.PHONY: deploy mysql

deploy:
	kubectl --context $(CLUSTER) create namespace $(APP)

mysql:
	kubectl --context $(CLUSTER) apply -f mysql.yaml
