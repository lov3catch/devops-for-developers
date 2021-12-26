test:
	test -s solution
	test -d terraform
	make init validate lint

init:
	terraform -chdir=terraform init

lint:
	terraform fmt -check -diff terraform

validate:
	terraform -chdir=terraform validate

# BEGIN
ansible-install:
	ansible-galaxy role install -r ansible/requirements.yml
	ansible-galaxy collection install -r ansible/requirements.yml

plan:
	terraform -chdir=terraform plan

apply:
	terraform -chdir=terraform apply

deploy:
	ansible-playbook -vv -i ansible/hosts ansible/playbook.yml
# END
