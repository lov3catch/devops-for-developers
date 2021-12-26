test:
	test -s solution

# BEGIN
proxy-ping:
	ansible -i ansible/inventory.ini webservers -m ping --ssh-extra-args "-F ansible/ssh_config" --vault-password-file ansible/vault-password

install-ansible-deps:
	ansible-galaxy role install -r ansible/requirements.yml
	ansible-galaxy collection install -r ansible/requirements.yml

encrypt:
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/host_vars/localhost/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/host_vars/localhost/vault.yml

prepare-infrastructure:
	ansible-playbook -vv ansible/infrastructure.yml --vault-password-file ansible/vault-password

prepare-servers:
	ansible-playbook -i ansible/inventory.ini -vv ansible/servers.yml --ssh-extra-args "-F ansible/ssh_config" --vault-password-file ansible/vault-password

deploy:
	make prepare-infrastructure
	make prepare-servers
# END
