output "password" {
  value = local.password
  sensitive = true
}

output "token" {
  value = proxmox_virtual_environment_user_token.token.value
  sensitive = true
}