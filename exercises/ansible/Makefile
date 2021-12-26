test:
	vagrant -v
	test -e Vagrantfile || exit

install:
	npm install

start:
	npm start

vagrant-install:
	vagrant ssh -c "cd /vagrant && make install"

vagrant-start:
	vagrant ssh -c "cd /vagrant && make start"

up:
	vagrant up
