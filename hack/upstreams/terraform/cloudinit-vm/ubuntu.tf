resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  node_name   = var.node_name
  vm_id = var.id
  operating_system { type = "l26"}
  cpu {
    cores = var.cpu
    type  = var.arch
  }
  memory { dedicated = var.memory }
  agent { enabled = var.agent }
  dynamic "network_device" {
    for_each = var.nics
    content {
      bridge = network_device.value.bridge
      vlan_id   = network_device.value.vlan
      mac_address = network_device.value.mac
    }
  }
  boot_order = ["virtio0"]
  disk {
    datastore_id = var.datastore_id_vms
    file_id      = "${var.datastore_id_isos}:${coalesce(var.boot_disk.content_type,"import")}/${var.boot_disk.file_name}"
    file_format  = var.boot_disk.file_format
    interface    = "virtio0"
    iothread = true
    discard = "on"
    size = var.boot_disk.size
  }
  dynamic "disk" {
    for_each = {
      for idx, nic in var.disks :
      idx => nic
    }
    content {
      datastore_id = coalesce(disk.value.datastore_id,var.datastore_id_vms)
      interface    = "virtio${disk.key+1}"
      size = disk.value.size
      iothread = true
      discard = "on"
      path_in_datastore = disk.value.path_in_datastore
    }
  }
  initialization {
    datastore_id = var.datastore_id_vms
    user_data_file_id =proxmox_virtual_environment_file.user-data.id
    network_data_file_id = proxmox_virtual_environment_file.network-config.id
    meta_data_file_id = proxmox_virtual_environment_file.meta-data.id
  }
}
locals {
  vendordata = yamldecode(file("${path.module}/templates/ubuntu/vendor-data.yaml.tftpl"))
  userdata = yamldecode(var.cloudinit.user-data)
  merged = {
    password: try(local.userdata.password,local.vendordata.password,null)
    package_update: try(local.userdata.package_update,local.vendordata.package_update,null)
    apt: try(local.userdata.apt,local.vendordata.apt,null)
    disk_setup: try(local.userdata.disk_setup,local.vendordata.disk_setup,null)
    device_aliases: try(local.userdata.device_aliases,local.vendordata.device_aliases,null)
    chpasswd: {
      expire: try(local.userdata.chpasswd.expire,local.vendordata.chpasswd.expire,null)
    }
    snap: {
      commands: distinct(concat(try(local.userdata.snap.commands,[]), try(local.vendordata.snap.commands,[])))
    }
    ssh_authorized_keys: distinct(concat(try(local.userdata.ssh_authorized_keys,[]), try(local.vendordata.ssh_authorized_keys,[])))
    users: distinct(concat(try(local.userdata.users,[]), try(local.vendordata.users,[])))
    packages: distinct(concat(try(local.userdata.packages,[]), try(local.vendordata.packages,[])))
    runcmd: concat(try(local.vendordata.runcmd,[]), try(local.userdata.runcmd,[]))
    fs_setup: distinct(concat(try(local.userdata.fs_setup,[]), try(local.vendordata.fs_setup,[])))
    mounts: distinct(concat(try(local.userdata.mounts,[]), try(local.vendordata.mounts,[])))
    write_files: distinct(concat(try(local.userdata.write_files,[]), try(local.vendordata.write_files,[])))
  }
}

resource "proxmox_virtual_environment_file" "user-data" {
  content_type = "snippets"
  datastore_id = var.datastore_id_config
  node_name    = var.node_name

  source_raw {
    data      = <<-EOT
#cloud-config
${yamlencode(local.merged)}
EOT
    file_name = "${var.id}-user-data.yaml"
  }
}
resource "proxmox_virtual_environment_file" "network-config" {
  content_type = "snippets"
  datastore_id = var.datastore_id_config
  node_name    = var.node_name

  source_raw {
    data      = coalesce(var.cloudinit.network-config,templatefile("${path.module}/templates/ubuntu/network-config.yaml.tftpl", {}))
    file_name = "${var.id}-network-config.yaml"
  }
}
resource "proxmox_virtual_environment_file" "meta-data" {
  content_type = "snippets"
  datastore_id = var.datastore_id_config
  node_name    = var.node_name

  source_raw {
    data      = templatefile("${path.module}/templates/ubuntu/meta-data.yaml.tftpl", {hostname: var.name,id: var.id})
    file_name = "${var.id}-meta-data.yaml"
  }
}
