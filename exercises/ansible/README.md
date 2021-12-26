# Ansible

Настроим Vagrant-окружение c помощью [Ansible Provisioning](https://www.vagrantup.com/docs/provisioning/ansible) и запустим внутри него Fastify-проект.

## Ссылки

* [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
* [Vagrant: Проброс портов](https://www.vagrantup.com/docs/networking/forwarded_ports)
* [Интеграция Ansible с Vagrant](https://github.com/hexlet-boilerplates/vagrant-ansible)

## Задачи

* [Установите Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* Инициализируйте Vagrant-проект

    ```sh
    vagrant init ubuntu/focal64
    ```

* Создайте директорию *provisioning* и файл *playbook.yml*, который будет использовать Ansible
* Ansible: Добавьте репозиторий [Node.js](https://github.com/nodesource/distributions#installation-instructions) с помощью [shell-скрипта](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/script_module.html) командой:

    ```sh
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    ```

* Ansible: Установите пакет *nodejs* с помощью [apt](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html)
* Ansible: Добавьте установку зависимостей для Fastify-проекта с помощью команды *npm install*. Эту команду нужно выполнять в директории */vagrant* и только [при условии](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html), что существует файл *package.json*.
* В *Vagrantfile* пробросьте изнутри виртуальной машины наружу 3000 порт. На нем запустится Fastify
* Инициализируйте Fastify-проект и убедитесь что он работает

    ```sh
    vagrant ssh
    cd /vagrant
    npm init -y fastify
    npm install
    FASTIFY_ADDRESS=0.0.0.0 npm run dev
    # открываем в браузере http://localhost:3000 и проверяем что все работает
    ```

Результатом домашней работы будет Fastify-проект, который запускается внутри виртуальной машины VirtualBox с помощью Vagrant и доступен снаружи по адресу http://localhost:3000. А также файл *playbook.yml*, в котором происходит добавление репозитория и установка необходимых пакетов.

## Самостоятельная работа

Добавьте переменную `FASTIFY_ADDRESS` в */etc/environment* с помощью Ansible. Тогда не придется ее указывать при запуске Fastify. Используйте для этого модуль *lineinfile*.
