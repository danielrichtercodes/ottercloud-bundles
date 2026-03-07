terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.72.0"
    }
  }
}
output "connection" {
  value = {
    url         = "https://v01.mgmt.rtb.dani.rip"
    pool = "danielrichter"
  }
}

// schedule based on least utilized node
output "node" {
  value = "v01"
}


output "datastores" {
  value = {
    templates : "truenas-nfs"
    snippets : "truenas-nfs"
    images : "local-lvm"
  }
}