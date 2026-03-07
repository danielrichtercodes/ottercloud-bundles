terraform {
  required_providers {
    http = { source = "hashicorp/http", version = ">= 3.4.0" }
  }
}

variable "PROXMOX_VE_ENDPOINT" {
  default = "https://gaia.danielr1996.de"
}
variable "PROXMOX_VE_USERNAME" {
  default = "root@pam"
}
variable "PROXMOX_VE_PASSWORD" {
  default = "proxmoxpve"
}

data "http" "ticket" {
  url     = "${var.PROXMOX_VE_ENDPOINT}/api2/json/access/ticket"
  method  = "POST"
  insecure = true

  request_body = "username=${urlencode(var.PROXMOX_VE_USERNAME)}&password=${urlencode(var.PROXMOX_VE_PASSWORD)}"

  request_headers = {
    Content-Type = "application/x-www-form-urlencoded"
  }
}
locals {
  ticket_json = jsondecode(data.http.ticket.response_body)
  ticket      = local.ticket_json.data.ticket
  csrf        = local.ticket_json.data.CSRFPreventionToken
}
data "http" "nextid" {
  depends_on = [time_static.nextid]
  url = "${var.PROXMOX_VE_ENDPOINT}/api2/json/cluster/nextid"
  insecure = true
  request_headers = {
    Cookie             = "PVEAuthCookie=${local.ticket}"
    CSRFPreventionToken = local.csrf
  }
}
output "id" {
  value = tonumber(jsondecode(data.http.nextid.response_body).data)

}
resource "time_static" "nextid" {}
