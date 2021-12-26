data "digitalocean_ssh_key" "macbook" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "macbook"
}