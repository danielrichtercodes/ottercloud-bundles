variable "name" {
  type = string
}
variable "id" {
  type = string
}

variable "node_name" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "agent" {
  type = bool
  default = true
}

variable "datastore_id_vms" {
  default = "local-lvm"
}

variable "datastore_id_config" {
  default = "local"
}
variable "arch" {
  default = "x86-64-v2-AES"
}

variable "datastore_id_isos" {
  default = "local"
}

variable "nics" {
  type = list(object({bridge: string,mac: optional(string),vlan: optional(number)}))
  default = []
}

variable "boot_disk" {
  type = object({
    datastore_id: optional(string)
    content_type: optional(string)
    file_format: optional(string)
    file_name: string
    size: optional(number)
  })
}

variable "disks" {
  type = list(object({
    datastore_id: optional(string)
    size: optional(number)
    path_in_datastore: optional(string)
  }))
  default = []
}

variable "cloudinit" {
  type = object({
    user-data: optional(string),
    network-config: optional(string),
  })
  default = {}
}