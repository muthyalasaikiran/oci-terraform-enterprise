variable "availability_domain" { type = string }
variable "compartment_id" { type = string }
variable "name" { type = string }
variable "backup_id" { type = string }
variable "vpus_per_gb" {
  type    = number
  default = 10
}
variable "tags" {
  type    = map(string)
  default = {}
}
