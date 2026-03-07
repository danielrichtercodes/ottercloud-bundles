resource "proxmox_virtual_environment_dns" "first_node_dns_configuration" {
  domain    = var.dns_domain
  node_name = var.node_name

  servers = var.dns_servers
}