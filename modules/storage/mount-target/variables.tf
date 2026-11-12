variable "availability_domain" { type = string }
variable "compartment_id" { type = string }
variable "subnet_id" { type = string }
variable "name" { type = string }
variable "nsg_ids" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}

