resource "proxmox_virtual_environment_user" "admin" {
  user_id = "${var.admin_username}@${var.admin_realm}"
  password = local.password
  email = var.admin_email
  groups = [proxmox_virtual_environment_group.group.group_id]
}

resource "proxmox_virtual_environment_user_token" "token" {
  comment         = "Tenant Admin Token"
  token_name      = var.id
  user_id         = proxmox_virtual_environment_user.admin.id
  privileges_separation = false
}
