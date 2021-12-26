# Ansible for servers

В этом задании научимся создавать инфраструктуру и конфигурировать сервера с помощью Ansible.

## Ссылки

* [Terraform output](https://www.terraform.io/docs/cli/commands/output.html)
* [Ansible Galaxy - geerlingguy.docker](https://galaxy.ansible.com/)
* [Docker - Managing access tokens](https://docs.docker.com/docker-hub/access-tokens/)
* [Ansible terraform module](https://docs.ansible.com/ansible/latest/collections/community/general/terraform_module.html)
* [Ansible docker_login module](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_login_module.html)
* [Ansible authorized_key module](https://docs.ansible.com/ansible/latest/collections/ansible/posix/authorized_key_module.html)

## Задачи

Автоматизируйте создание настройку инфраструктуры, деплой приложения используя Ansible.

* Создайте инфраструктуру
  * 2 виртуальных машины, которые будут выполнять роль веб-серверов. Используйте образ `ubuntu-20-10-x64`, если используете Digital Ocean (Docker будет установлен с помощью ansible)
  * 1 балансировщик нагрузки, который подключен к созданным веб-серверам
  * Домен, который подключен к балансировщику

* Установите Docker
* Создайте пользователя `deploy`. Добавьте его в группу `docker`. Добавьте в авторизованные ключи публичный ключ. Убедитесь, что вы можете зайти этим пользователем по ssh

* Создайте приватный образ на основе приложения [hexlet-components/devops-example-app](https://github.com/hexlet-components/devops-example-app)
* Создайте access token в Dockerhub
* Выполните деплой приватного образа пользователем `deploy`
* Добавьте в *Makefile* команду деплоя приложения
* В файле *solution* добавьте ссылку на задеплоенное приложение: http://<адрес>
