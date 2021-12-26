# Infrastructure as a code

Научиться автоматизировать создание инфраструктуры в Digital Ocean используя Ansible.

## Ссылки

* [Ansible Galaxy - digitalocean collection](https://galaxy.ansible.com/community/digitalocean)
* [community.digitalocean.digital_ocean_droplet – Create and delete a DigitalOcean droplet](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/digital_ocean_droplet_module.html)
* [community.digitalocean.digital_ocean_sshkey_info – Gather information about DigitalOcean SSH keys](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/digital_ocean_sshkey_info_module.html)
* [Registering variables](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#registering-variables)
* [Module ansible.builtin.template](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html)
* [Jinja2 documentation](https://jinja.palletsprojects.com/en/3.0.x/templates/)

## Задачи

Автоматизируйте с помощью Ansible создание дроплетов Digital Ocean и генерацию файла инвентаризации из шаблона.

* Перед созданием серверов необходимо получить информацию о ssh-ключах, которые были созданы ранее. Ключи нужны, чтобы подключиться к удаленной машине по SSH. Получите информацию о текущих ключах с помощью модуля `digitalocean.digital_ocean_sshkey_info` и зарегистрируйте переменную.

* Создайте 2 дроплета в Digital Ocean с параметрами, указанными ниже. Используйте зарегистрированную переменную для того, чтобы передать ID одного или нескольких ключей. Используйте переменные Ansible для удобства хранения конфигурации машины.

  * Образ - `docker-20-04` (Ubuntu с предустановленным Docker)
  * Размер - `s-1vcpu-1gb`
  * Регион - `ams3`
  * Имя - `as-a-code-homework-XX`, где XX - это номер сервера. Пример итогового имени сервера -  *as-a-code-homework-02*. Имя должно быть уникально
  * Состояние - `active`

* Сформируйте инвентори файл с группой `digital-ocean` с созданными хостами:
  * Имя хоста - указанное имя сервера(as-a-code-homework-01, например)
  * IP-адрес - адрес созданного дроплета
  * Пользователь - `root` (или любой другой, который будет использоваться для подключения)

  Пример содержимого созданного инвентори файла

  ```ini
  [digital-ocean]
  as-a-code-homework-01 ansible_host=161.35.156.11 ansible_user=root
  as-a-code-homework-02 ansible_host=161.35.146.58 ansible_user=root
  ```

* Создайте в *Makefile* команду `ping`, которая с помощью ad-hoc Ansible пингует созданную группу серверов. Проверьте, что команда выполняется успешно.

## Подсказки

* Для того, чтобы на дроплет был добавлен SSH-ключ, можно использовать тот, который уже был создан (добавлен) На Digital Ocean. Необходимо передать его ID.
