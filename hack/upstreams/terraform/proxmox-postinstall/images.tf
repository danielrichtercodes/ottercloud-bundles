resource "proxmox_virtual_environment_download_file" "image" {
  for_each = {
    for f in var.images :
    "${f.url}|${f.filename}" => {
      content_type = coalesce(
        f.content_type,
          can(regex("\\.iso(\\?.*)?$", lower(f.url))) ? "iso" : "import"
      )
      datastore_id            = coalesce(f.datastore_id, var.datastore_id)
      node_name               = coalesce(f.node_name, var.node_name)
      url                     = f.url
      file_name               = f.filename
      decompression_algorithm = try(f.decompression_algorithm, null)
    }
  }

  content_type            = each.value.content_type
  datastore_id            = each.value.datastore_id
  node_name               = each.value.node_name
  url                     = each.value.url
  file_name               = each.value.file_name
  decompression_algorithm = each.value.decompression_algorithm
}