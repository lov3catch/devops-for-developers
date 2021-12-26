test:
	make install
	ansible-playbook --syntax-check ansible/playbook.yml

install:
	ansible-galaxy role install -r ansible/requirements.yml
	ansible-galaxy collection install -r ansible/requirements.yml

# BEGIN
create:
	ansible-playbook -vv ansible/playbook.yml --vault-password-file ansible/vault-password

ping:
	ansible digital-ocean -i ansible/inventory.ini -m ping

encrypt:
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/host_vars/localhost/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/host_vars/localhost/vault.yml
# END
