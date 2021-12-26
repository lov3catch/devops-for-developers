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

// Токен DO и путь к приватному ключу, будут передаваться через CLI
variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  // Использование переменной (токен доступа к DO)
  // https://www.terraform.io/docs/language/values/variables.html
  token = var.do_token
}

// Ключ можно либо получить созданный, либо создать новый
// resource "digitalocean_ssh_key" "default" {
//   name       = "Terraform Homework"
//   public_key = file("~/.ssh/id_rsa.pub")
// }
// Используется data source - ресурс не создаётся. Terraform запрашивает информацию о ресурсе
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/droplet
data "digitalocean_ssh_key" "terraform" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "key"
}

// Outputs похожи на возвращаемые значения. Они позволяют сгруппировать информацию или распечатать то, что нам необходимо
// https://www.terraform.io/docs/language/values/outputs.html
output "droplets" {
  // Обращение к ресурсу. Каждый ресурс имеет атрибуты, к которым можно получить доступ
  value = [
    digitalocean_droplet.web-1,
    digitalocean_droplet.web-2
  ]
}

// Создание балансировщика нагрузки
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer
resource "digitalocean_loadbalancer" "lb" {
  name = "lb"
  region = "ams3"

  forwarding_rule {
    // Порт по которому балансировщик принимает запросы
    entry_port = 80
    entry_protocol = "http"

    // Порт по которому балансировщик передает запросы (на другие сервера)
    target_port = 8080
    target_protocol = "http"
  }

  // Порт, протокол, путь по которому балансировщик проверяет, что дроплет жив и принимает запросы
  healthcheck {
    port = 8080
    protocol = "http"
    path = "/"
  }

  droplet_ids = [
    digitalocean_droplet.web-1.id,
    digitalocean_droplet.web-2.id
  ]
}

// Создание домена
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain
resource "digitalocean_domain" "example" {
  name = "hexlet.devops-baby.club"
  ip_address = digitalocean_loadbalancer.example.ip
}

// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web-1" {
    image = "ubuntu-20-10-x64"
    name = "web-1"
    region = "ams3"
    size = "s-1vcpu-1gb"
    private_networking = true

    // Добавление приватного ключа на создаваемый сервер
    // Обращение к datasource выполняется через data.
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}

resource "digitalocean_droplet" "web-2" {
    image = "ubuntu-20-10-x64"
    name = "web-2"
    region = "ams3"
    size = "s-1vcpu-1gb"
    private_networking = true

    // Добавление приватного ключа на создаваемый сервер
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}
