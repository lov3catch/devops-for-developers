// Для удобства всё находится в одном файле
// При необходимости разделяется на отдельные .tf файлы

// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  // Использование переменной (токен доступа к DO)
  // https://www.terraform.io/docs/language/values/variables.html
  token = var.do_token
}

variable "do_token" {}
variable "pvt_key" {
  default = "~/.ssh/id_rsa"
}

output "webserver_ips" {
  value = digitalocean_droplet.servers.*.ipv4_address
}

// Создаём дроплеты
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "servers" {
  count              = 2
  image              = "docker-20-04"
  name               = "service-discovery-${count.index + 1}"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  private_networking = true

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.example.id
  ]
}

// Ключ можно либо получить созданный, либо создать новый
// resource "digitalocean_ssh_key" "default" {
//   name       = "Terraform Homework"
//   public_key = file("~/.ssh/id_rsa.pub")
// }
// Используется data source - ресурс не создаётся. Terraform запрашивает информацию о ресурсе
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/droplet
data "digitalocean_ssh_key" "example" {
  name = "key"
}

