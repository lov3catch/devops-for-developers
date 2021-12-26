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

resource "digitalocean_vpc" "web_vps" {
  name     = "security-network-for-web"
  region   = "nyc1"
  ip_range = "192.168.10.0/24"
}

// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web1" {
  image  = "ubuntu-20-10-x64"
  name   = "web-ansible-homework-01"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.web_vps.id

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
  vpc_uuid = digitalocean_vpc.web_vps.id

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
}

resource "digitalocean_droplet" "bastion" {
  image  = "ubuntu-20-10-x64"
  name   = "web-ansible-bastion"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.web_vps.id

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
}


resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = "nyc1"
  vpc_uuid = digitalocean_vpc.web_vps.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]
}

output "droplet_ips" {
  value = [
    digitalocean_droplet.web1.ipv4_address_private,
    digitalocean_droplet.web2.ipv4_address_private
  ]
}

output "bastion" {
  value = digitalocean_droplet.bastion
}

resource "digitalocean_firewall" "web" {
  name = "web-only-lb-and-ssh"

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_droplet_ids = [digitalocean_droplet.bastion.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "9090"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "9090"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "bastion" {
  name = "only-lb-and-ssh"

  droplet_ids = [digitalocean_droplet.bastion.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    port_range       = "1-65535"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "53"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

