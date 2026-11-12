variable "region" {
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
variable "instance_name" {
  type = string
}
variable "shape" {
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
variable "source_id" {
  type = string
}
variable "ssh_public_key_path" {
  type    = string
  default = null
}
variable "nsg_ids" {
  type    = list(string)
  default = []
}
variable "assign_public_ip" {
  type    = bool
  default = false
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "create_data_volume" {
  type    = bool
  default = false
}
variable "data_volume_name" {
  type    = string
  default = "msk-sample-data"
}
variable "data_volume_size_gb" {
  type    = number
  default = 100
}
variable "data_volume_vpus_per_gb" {
  type    = number
  default = 10
}