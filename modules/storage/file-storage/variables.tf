variable "availability_domain" { type = string }
variable "compartment_id" { type = string }
variable "name" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}

