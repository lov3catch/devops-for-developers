# Terraform

В этом задании необходимо подготовить инфраструктуру с помощью [Terraform](https://www.terraform.io/). Результатом этого задания станет описанная инфраструктура - 2 веб-сервера, балансировщик нагрузки, домен.

## Ссылки

* [Terraform](https://www.terraform.io/)
* [DO - How to Create a Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
* [How To Use Terraform with DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean)
* [DigitalOcean Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
* [Terraform Variables](https://www.terraform.io/docs/language/values/variables.html)
* [Resource - digitalocean_ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/ssh_key)
* [Data source - digitalocean_ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key)
* [Resource - digitalocean_droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet)
* [Resource - digitalocean_loadbalancer](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer)
* [Resource - digitalocean_domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain)
* [hexlet-basics](https://github.com/hexlet-basics/hexlet-basics/tree/master/terraform)
* [Digital Ocean - How to Create a Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/)

## Задачи

### Подготовка

* Установите Terraform на машину на которой выполняете задание. Его можно установить официальным способом или с помощью роли [migibert.terraform](https://galaxy.ansible.com/migibert/terraform)
* Создайте в Digital Ocean access token

### Terraform

* Создайте директорию *terraform/* и опишите в ней [провайдер](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs) Digital Ocean.
* Выполните `terraform init`. Terraform подготовит структуру, скачает файлы для работы с Digital Ocean
* Изменения в инфраструктуру вносятся командой `terraform apply`. Просмотр потенциальных изменений без их внесения выполняется командой `terraform plan`

* Добавьте ресурс (resource) с публичным SSH-ключом или используйте уже созданный на DO с помощью data source [ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key)

* Опишите ресурс дроплета с параметрами:
  * Образ - `docker-20-04`
  * Имя - `web-terraform-homework-01`
  * Регион - `ams3
  * Размер - `s-1vcpu-1gb`
  * SSH ключ - тот, который уже ранее был создан

  Перед созданием ресурса выполните `terraform plan`, чтобы посмотреть изменения

* Опишите второй дроплет с именем *web-terraform-homework-02*. Выполните `terraform plan`, изучите вывод, примените изменения с помощью `terraform apply`
* Удалите один из дроплетов

  ```sh
  terraform destroy -target "digitalocean_droplet.web_terraform_homework_02"
  ```

* Выполните `terraform apply` и создайте снова удаленный дроплет. Если что-то из инфраструктуры не описано (например удалено или закомментировано), то Terraform удалит это, актулизировав состояние инфраструктуры

* Опишите балансировщик нагрузки. Перед созданием выполните `terraform plan`
  * Входящий порт - 80
  * Целевой порт (на котором принимает запросы веб-серверы) - 5000
  * healthcheck - http-запрос на корневую страницу веб-сервера
  * Свяжите дроплеты с балансером
* Добавьте (или поддомен) к созданному ранее балансеру

* Команда  `terraform show <tfstate>` выводит всю информацию о созданной инфраструктуре

  ```sh
    terraform show terraform.tfstate
  ```

* Для вывода какой-либо информации, то используют [output](https://www.terraform.io/docs/language/values/outputs.html). Выведите IP адреса дроплетов. Вывод можно объединять следующим образом

```terraform
output "output_name" {
  value = [
    value1,
    value2
  ]
}
```

* Создайте вручную инвентори файл с IP адресами дроплетов. Выполните деплой приложения [devops-example-app](https://github.com/hexlet-components/devops-example-app)

* Убедитесь, что токен Digital Ocean не хранится в коде, а попадает снаружи

* Опишите необходимые команды в *Makefile*

* В *solution* приложите ссылку на домен куда был выполнен деплой
