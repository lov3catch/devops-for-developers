test:
	test -s solution

# BEGIN
encrypt-vault:
	 ansible-vault encrypt --vault-password-file vault-password group_vars/webservers/vault.yml

deploy:
	ansible-playbook -i hosts -v --vault-password-file vault-password playbook.yml
# END
