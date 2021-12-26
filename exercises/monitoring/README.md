# Мониторинг

В этой домашней работе мы подключим Datadog к серверам Digital Ocean и настроим монитор, который будет проверять доступность нашего приложения, и, в случае отклонения от нормы, посылать уведомление об этом по электронной почте.

В качестве проверки состояния приложения мы будем использовать [http_check](https://docs.datadoghq.com/integrations/http_check/) от Datadog. Агент будет проверять, что наше приложение запущено на 5000 порту, а сама проверка конфигурируется с помощью переменных Ansible.

## Ссылки

* [Datadog](https://www.datadoghq.com/)
* [HTTP Check](https://docs.datadoghq.com/integrations/http_check/) - монитор состояния приложения, который мы будем устанавливать. Опрашивает определенный адрес каждые N секунд
* [Alerting](https://docs.datadoghq.com/monitors/) - Документация Datadog по алертам и мониторам
* [https://galaxy.ansible.com/DataDog/datadog](https://galaxy.ansible.com/DataDog/datadog) - роль Ansible Galaxy для установки Datadog
* [Installing roles and collections from the same requirements.yml file](https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-roles-and-collections-from-the-same-requirements-yml-file) - документация Ansible по работе с зависимостями

## Задачи

* Зарегистрируйтесь на [datadoghq.com](https://app.datadoghq.com/signup)
* На шаге *3. Agent Setup*. Выберите Ansible в качестве способа установки. (В дальнейшем сгенерировать новые ключи можно на странице [Integrations — Apis](https://app.datadoghq.com/account/settings#api)

### hosts

Добавьте в файл *hosts* два сервера, на которых будет запущено приложение.

### requirements.yml

Добавьте роль Datadog в *requirements.yml* и выполните `make setup`. Добавьте в файл *vault-password* секретный пароль для шифрования переменных

### group_vars/webservers/vault.yml

Добавьте в файл ключ апи Datadog и зашифруйте файл

```shell
make encrypt-vault FILE=group_vars/webservers/vault.yml                                                          2 ↵
ansible-vault encrypt group_vars/webservers/vault.yml --vault-password-file vault-password
Encryption successful
```

### playbook.yml

Добавьте блок (play), использующий роль Datadog для установки и запуска агента. Запустить роль можно добавив роль или с помощью модуля [ansible.builtin.include_role](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/include_role_module.html). Выполните деплой (`make deploy`)

Если агент настроен правильно, то через 2-3 минуты информация будет отправлена в Datadog.

### Создание монитора в Datadog

* Создайте новый монитор в разделе Network. Выберите созданный *http_check*, далее вам необходимо выбрать все хосты, сколько проверок требуется для оповещения и восстановления
* В сообщении оповещения сделайте заголовок *Hexlet HTTP Alert! <host_name>*, где host_name - это переменная, которая будет подставляться из переменных Datadog
* Добавьте себя в оповещение. Проверьте, что оповещение настроено корректно, отправьте тестовое сообщение с помощью соответствующей кнопки
* Зайдите на один из серверов и остановите контейнер приложения. Если все было настроено правильно, то придёт оповещение от Datadog о недоступности сервиса
* В файле *solution* добавьте ссылку на задеплоенное приложение: http://<адрес>

После выполнения домашней работы приложите скриншоты в директории *screenshots*:

1. Запущенный монитор HTTP

![](assets/monitor.png)

2. Сработавший алерт монитора

![](assets/alert.png)

3. Тело письма оповещения

![](assets/alert-notification.png)

## Дополнительное задание

Настройте дашборд и выведите текущие метрики сервера.
