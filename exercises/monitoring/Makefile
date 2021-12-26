test:
	test -s solution

setup: touch-vault-password-file install

deploy:
	ansible-playbook -i hosts -v --vault-password-file vault-password playbook.yml

install:
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

touch-vault-password-file:
	touch vault-password

encrypt-vault:
	ansible-vault encrypt $(FILE) --vault-password-file vault-password

decrypt-vault:
	ansible-vault decrypt $(FILE) --vault-password-file vault-password

view-vault:
	ansible-vault view $(FILE) --vault-password-file vault-password

edit-vault:
	ansible-vault edit $(FILE) --vault-password-file vault-password

create-vault:
	ansible-vault create $(FILE) --vault-password-file vault-password
