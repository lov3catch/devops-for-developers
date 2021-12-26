test:
	test -s solution

# BEGIN
install-ansible-deps:
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

encrypt:
	ansible-vault encrypt --vault-password-file vault-password group_vars/webservers/vault.yml
	ansible-vault encrypt --vault-password-file vault-password host_vars/localhost/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file vault-password group_vars/webservers/vault.yml
	ansible-vault decrypt --vault-password-file vault-password host_vars/localhost/vault.yml

prepare-infrastructure:
	ansible-playbook -i inventory.ini -vv infrastructure.yml --vault-password-file vault-password

prepare-servers:
	ansible-playbook -i inventory.ini -vv servers.yml --vault-password-file vault-password

deploy:
	make prepare-infrastructure
	make prepare-servers
# END
