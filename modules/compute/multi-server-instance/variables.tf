variable "name" { type = string }
variable "compartment_id" { type = string }
variable "availability_domain" { type = string }
variable "subnet_id" { type = string }
variable "shape" { type = string }
variable "image_id" { type = string }
variable "ocpus" { type = number }
variable "memory_in_gbs" { type = number }
variable "private_ip" {
  type    = string
  default = null
}
variable "nsg_ids" {
  type    = list(string)
  default = []
}
variable "ssh_public_key_path" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
