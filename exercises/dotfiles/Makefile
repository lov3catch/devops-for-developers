all: dependencies-install dotfiles-install

dependencies-install:
	apt-get update
	apt-get -y install make zsh git asdf curl git oh-my-zsh

dotfiles-install:
	docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

test:
	vagrant -v
	test -e Vagrantfile || exit