variable "source_boot_volume_id" {
  type = string
}

variable "display_name" {
  type = string
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

