# Операционные системы и сети

Создайте Vagrant-проект, поместив туда ваш фреймворк/среду, с которой вы обычно работаете в повседневной практике.

## Ссылки

* [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
* [Vagrant: Проброс портов](https://www.vagrantup.com/docs/networking/forwarded_ports)
* [Интеграция Ansible с Vagrant](https://github.com/hexlet-boilerplates/vagrant-ansible)

## Задачи

* Инициализируйте Vagrant-проект

    ```sh
    vagrant init ubuntu/focal64
    ```

* Настройте систему с помощью Ansible Provisioning
* Инициализируйте проект на вашем фреймворке, убедитесь что он работает
* Пробросьте изнутри виртуальной машины наружу нужный порт и проверьте, что запущенный сервер доступен из браузера
* Поэкспериментируйте с Vagrant. Попробуйте пересоздать Vagrant-машину
