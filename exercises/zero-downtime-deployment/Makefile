test:
	test -s solution

# BEGIN
pods:
	kubectl --kubeconfig ~/k8s/k8s.yaml get pods

apply:
	kubectl --kubeconfig ~/k8s/k8s.yaml apply -f app-deployment.yaml,app-service.yaml,env-configmap.yaml

deploy-monitoring:
	ansible-playbook -i monitoring.ini -v --vault-password-file vault-password monitoring.yml
# END
