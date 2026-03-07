variable "name" {
  type = string
}

variable "id" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_realm" {
  type = string
}


variable "admin_email" {
  type = string
}


variable "admin_password" {
  type = string
  default = ""
}

resource "random_password" "password" {
  length           = 16
  special          = true
}

locals {
  password = var.admin_password == "" ? random_password.password.result : var.admin_password
}