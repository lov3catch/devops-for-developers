# Инициализация проекта терраформ
# может добавляться флаг -chdir=<dirname> если нужно команда выполняется не в директории с tf файлами
terraform init

# В примерах ниже используется переменная окружения для токена Digital Ocean
export DO_PAT=<token>

# Посмотреть изменения без их выполнения
# https://www.terraform.io/docs/cli/commands/plan.html
terraform plan -var "do_token=$DO_PAT"

# Применить изменения
# https://www.terraform.io/docs/cli/commands/apply.html
terraform apply -var "do_token=$DO_PAT"

# Удалить созданную инфраструктуру
# https://www.terraform.io/docs/cli/commands/destroy.html
terraform destroy -var "do_token=$DO_PAT"

# После применения изменений сохраняется состояние инфраструктуры. Её можно посмотреть
terraform show

# Форматирование
# https://www.terraform.io/docs/cli/commands/fmt.html
terraform fmt

# Проверка стиля (формата) с выводом диффа
terraform fmt -check -diff

# Проверка конфигурации
# https://www.terraform.io/docs/cli/commands/validate.html
terraform validate

# Таким образом можно зашифровать значение hexlet в переменную the_secret
# с помощью пароля в файле vault-password
ansible-vault encrypt_string --vault-password-file vault-password 'hexlet' --name 'the_secret'

# Чтобы расшифровать зашифрованные с помощью Ansible Vault переменные
# если пароль хранится в файле, используется флаг --vault-password-file
ansible-playbook -v --vault-password-file vault-password playbook.yml

# Устанавливаем коллекции определённые в файле requirements.yml
ansible-galaxy collection install -r requirements.yml

# Устанавливаем роли определённые в файле requirements.yml
ansible-galaxy role install -r requirements.yml

# Деплоим приложение
ansible-playbook -i hosts playbook.yml -v --vault-password-file vault-password

# Подключаемся по ssh к хосту с IP 192.168.0.2
ssh username@192.168.0.2
