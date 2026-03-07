variable "datastore_id" {
  type = string
  default = "local"
}

variable "node_name" {
  type = string
  default = "pve"
}
variable "images" {
  type = list(object({
    content_type = optional(string)
    url          = string
    filename     = string
    datastore_id = optional(string)
    node_name = optional(string)
    decompression_algorithm = optional(string)
  }))
}

variable "dns_servers" {
  type = list(string)
  default = ["9.9.9.9","149.112.112.112"]
}
variable "dns_domain" {
  type = string
  default = "home.arpa"
}

variable "acme_data" {
}

variable "acme_api" {
  type =string
}
variable "acme_contact" {
  type =string
}

resource "proxmox_virtual_environment_cluster_options" "options" {
  language                  = "en"
  keyboard                  = "de"
}