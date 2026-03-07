variable "hosts" {
  type = list(string)
}

variable "known_hosts_file" {
  type = string
  default = "$HOME/.ssh/known_hosts"
}

# -f '/home/dani/.ssh/known_hosts
resource "terraform_data" "update-host-keys" {
  provisioner "local-exec" {
    command     = <<-EOF
      %{ for host in var.hosts }
      ssh-keygen -f ${var.known_hosts_file} -R ${host} || return 0
      ssh-keyscan -H ${host} >> ${var.known_hosts_file} || return 0
      %{ endfor }
    EOF
    interpreter = ["sh", "-c"]
  }
}