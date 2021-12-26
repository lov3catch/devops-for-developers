test:
	test -s solution

# BEGIN
ansible-install-roles:
	cd run && ansible-galaxy install -r requirements.yml

ansible-deploy:
	cd run && ansible-playbook playbook.yml
# END
