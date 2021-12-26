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

// Токен DO и путь к приватному ключу, будут передаваться через CLI
variable "do_token" {}

// Ключ можно либо получить созданный, либо создать новый
// resource "digitalocean_ssh_key" "default" {
//   name       = "Terraform Homework"
//   public_key = file("~/.ssh/id_rsa.pub")
// }
// Используется data source - ресурс не создаётся. Terraform запрашивает информацию о ресурсе
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/droplet
data "digitalocean_ssh_key" "example" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "key"
}

// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web1" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.example.id
  ]
}

resource "digitalocean_droplet" "web2" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  ssh_keys = [
    data.digitalocean_ssh_key.example.id
  ]
}

// Создание балансировщика нагрузки
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer
resource "digitalocean_loadbalancer" "example" {
  name = "example"
  region = "nyc1"

  forwarding_rule {
    // Порт по которому балансировщик принимает запросы
    entry_port = 80
    entry_protocol = "http"

    // Порт по которому балансировщик передает запросы (на другие сервера)
    target_port = 8080
    target_protocol = "http"
  }

  // Порт, протокол, путь по которому балансировщик проверяет, что дроплет живой и принимает запросы
  healthcheck {
    port = 8080
    protocol = "http"
    path = "/"
  }

  droplet_ids = [
    digitalocean_droplet.web1.id,
    digitalocean_droplet.web2.id
  ]
}

// Создание домена
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain
resource "digitalocean_domain" "example" {
  name = "hexlet.devops-baby.club"
  ip_address = digitalocean_loadbalancer.example.ip
}

// Outputs похожи на возвращаемые значения. Они позволяют сгруппировать информацию или распечатать то, что нам необходимо
// https://www.terraform.io/docs/language/values/outputs.html
output "droplets_ips" {
  // Обращение к ресурсу. Каждый ресурс имеет атрибуты, ккоторым можно получить доступ
  value = [
    digitalocean_droplet.web1.ipv4_address,
    digitalocean_droplet.web2.ipv4_address
  ]
}
