resource "proxmox_virtual_environment_pool" "pool" {
  comment = var.name
  pool_id =var.id
}

resource "proxmox_virtual_environment_group" "group" {
  acl {
    path    = "/pool/${proxmox_virtual_environment_pool.pool.pool_id}"
    role_id = "PVEVMAdmin"
    propagate = true
  }

  acl {
    path    = "/storage"
    role_id = "PVEAdmin"
    propagate = true
  }
  # acl {
  #   path    = "/storage/lvm-over-iscsi"
  #   role_id = "PVEDatastoreUser"
  #   propagate = true
  # }
  # acl {
  #   path    = "/storage/truenas-nfs"
  #   role_id = "PVEDatastoreUser"
  #   propagate = true
  # }
  group_id = var.id
}