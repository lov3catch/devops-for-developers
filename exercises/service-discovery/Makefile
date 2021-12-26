test:
	test -s solution

setup:
	make -C ansible setup
	make -C terraform setup

install:
	make -C ansible install
setup-servers:
	make -C ansible setup-servers
setup-consul-server:
	make -C ansible setup-consul-server
setup-consul-client:
	make -C ansible setup-consul-client
register-consul-service:
	make -C ansible register-consul-service

init:
	make -C terraform init

plan:
	make -C terraform plan

apply:
	make -C terraform apply

show:
	make -C terraform show

destroy:
	make -C terraform destroy
