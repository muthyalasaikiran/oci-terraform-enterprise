variable "region" { default = "ap-mumbai-1" }
variable "oci_profile" { default = "DEFAULT" }
variable "compartment_id" { type = string }
variable "availability_domain" { type = string }
variable "subnet_id" { type = string }
variable "image_id" { type = string }
variable "ssh_public_key_path" {
  type    = string
  default = null
}
variable "nsg_ids" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "servers" {
  description = "Map keyed by durable server names. Empty map prevents deployment."
  type = map(object({
    private_ip    = string
    shape         = string
    ocpus         = number
    memory_in_gbs = number
  }))
  default = {}
}
