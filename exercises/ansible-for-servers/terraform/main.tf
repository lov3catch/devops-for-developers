terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
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
data "digitalocean_ssh_key" "macbook" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "macbook"
}

// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web1" {
  image  = "ubuntu-20-10-x64"
  name   = "web-ansible-homework-01"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
}

resource "digitalocean_droplet" "web2" {
  image  = "ubuntu-20-10-x64"
  name   = "web-ansible-homework-02"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = "nyc1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]
}

output "droplet_ips" {
  value = [
    digitalocean_droplet.web1.ipv4_address,
    digitalocean_droplet.web2.ipv4_address
  ]
}