resource "proxmox_virtual_environment_acme_account" "example" {
  name      = "default"
  contact   = var.acme_contact
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.3-September-21-2022.pdf"
}

resource "proxmox_virtual_environment_acme_dns_plugin" "example" {
  plugin = "default"
  api    = var.acme_api
  data =  var.acme_data
}