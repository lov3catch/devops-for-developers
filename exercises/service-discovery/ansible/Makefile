setup:
	make install

install:
	ansible-galaxy collection install -r requirements.yml
	ansible-galaxy role install -r requirements.yml

setup-servers:
	ansible-playbook -i hosts.ini setup_servers.yml

setup-consul-server:
	ansible-playbook -i hosts.ini setup_consul_server.yml

setup-consul-client:
	ansible-playbook -i hosts.ini setup_consul_client.yml

register-consul-service:
	ansible-playbook -i hosts.ini register_consul_service.yml

# BEGIN

# END
