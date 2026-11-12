variable "availability_domain" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "display_name" {
  type = string
}

variable "backup_id" {
  type = string
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

