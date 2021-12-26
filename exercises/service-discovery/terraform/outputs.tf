output "webserver_ips" {
  value = digitalocean_droplet.servers.*.ipv4_address
}
