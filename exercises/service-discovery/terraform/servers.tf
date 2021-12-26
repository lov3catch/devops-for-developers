resource "digitalocean_droplet" "servers" {
  count              = 2
  image              = "docker-20-04"
  name               = "service-discovery-${count.index + 1}"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  private_networking = true

  // BEGIN
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
  // END
}
