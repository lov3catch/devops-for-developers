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
