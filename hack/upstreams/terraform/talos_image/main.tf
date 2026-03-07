data "talos_image_factory_versions" "this" {}

variable "talos_version" {
  type = string
  default = ""
}

variable "talos_features" {
  type = list(string)
  default = ["qemu-guest-agent","util-linux-tools"]
}

variable "talos_platform" {
  type = string
  default = "nocloud"
}

locals {
  talos_latest = [for i in reverse(data.talos_image_factory_versions.this.talos_versions) : i if length(regexall("-", i)) == 0][0]
  talos_version = coalesce(var.talos_version,local.talos_latest)
}


data "talos_image_factory_extensions_versions" "this" {
  talos_version = local.talos_version
  filters = {
    names = var.talos_features
  }
}
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info.*.name
        }
      }
    }
  )
}
data "talos_image_factory_urls" "nocloud" {
  talos_version = local.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.talos_platform
}

output "url" {
  value = data.talos_image_factory_urls.nocloud.urls.disk_image
}

output "version" {
  value = local.talos_version
}
output "platform" {
  value = var.talos_platform
}

output "filename" {
  value = "talos-${local.talos_version}-${var.talos_platform}.img"
}