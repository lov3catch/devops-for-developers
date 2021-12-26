
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
data "digitalocean_ssh_key" "example" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "key"
}

output "webservers" {
  value = digitalocean_droplet.web
}

output "bastion" {
  value = digitalocean_droplet.bastion
}

// Создаём виртуальную сеть
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc
resource "digitalocean_vpc" "example" {
  name     = "security-network-example"
  region   = "ams3"
  ip_range = "192.168.10.0/24"
}

// Создание балансировщика нагрузки
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer
resource "digitalocean_loadbalancer" "example" {
  name   = "security-loadbalancer-example"
  region = "ams3"
  vpc_uuid = digitalocean_vpc.example.id

  sticky_sessions {
    type               = "cookies"
    cookie_name        = "lb"
    cookie_ttl_seconds = 120
  }

  dynamic "forwarding_rule" {
    for_each = [
      {
        port     = 80
        protocol = "http"
      }
    ]

    content {
      entry_port = forwarding_rule.value["port"]

      entry_protocol = forwarding_rule.value["protocol"]

      target_port     = 8080
      target_protocol = "http"
    }
  }

  healthcheck {
    port     = 8080
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.web.*.id
}


// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web" {
  count              = 2
  image              = "docker-20-04"
  name               = "security-web-${count.index + 1}"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  private_networking = true
  vpc_uuid = digitalocean_vpc.example.id
  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.example.id
  ]
}

// Создаём файрволл
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall
resource "digitalocean_firewall" "web" {
  name = "web-only-lb-and-ssh"

  droplet_ids = digitalocean_droplet.web.*.id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_droplet_ids = [digitalocean_droplet.bastion.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_load_balancer_uids = [digitalocean_loadbalancer.example.id]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_droplet" "bastion" {
  image              = "ubuntu-20-04-x64"
  name               = "security-bastion"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  private_networking = true
  vpc_uuid = digitalocean_vpc.example.id

  ssh_keys = [
    data.digitalocean_ssh_key.example.id
  ]
}

resource "digitalocean_firewall" "bastion" {
  name = "only-lb-and-ssh"

  droplet_ids = digitalocean_droplet.bastion.id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
  }

  outbound_rule {
    protocol         = "icmp"
    port_range       = "1-65535"
  }
}

// Создание домена
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain
resource "digitalocean_domain" "example" {
  name = "hexlet.devops-baby.club"
  ip_address = digitalocean_loadbalancer.example.ip
}
