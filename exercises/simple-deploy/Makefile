test:
	test -s solution

# BEGIN
ansible-install-roles:
	cd run && ansible-galaxy install -r requirements.yml

ansible-enc-variable:
	cd run && ansible-vault encrypt_string --vault-password-file vault-password 'Hexlet Awesome Server' --name 'the_secret'

ansible-deploy:
	cd run && ansible-playbook -v --vault-password-file vault-password playbook.yml
# END
