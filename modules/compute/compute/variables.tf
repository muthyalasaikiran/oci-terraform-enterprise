variable "name" {
  type = string
}
variable "compartment_id" {
  type = string
}
variable "availability_domain" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "shape" {
  type = string
}
variable "source_type" {
  type = string
  validation {
    condition     = contains(["image", "bootVolume"], var.source_type)
    error_message = "source_type must be image or bootVolume."
  }
}
variable "source_id" {
  type = string
}
variable "shape_ocpus" {
  type    = number
  default = null
}
variable "shape_memory_gbs" {
  type    = number
  default = null
}
variable "assign_public_ip" {
  type    = bool
  default = false
}
variable "nsg_ids" {
  type    = list(string)
  default = []
}
variable "hostname_label" {
  type    = string
  default = null
}
variable "ssh_public_key_path" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
