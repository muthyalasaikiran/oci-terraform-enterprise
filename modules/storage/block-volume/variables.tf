variable "name" {
  type = string
}
variable "availability_domain" {
  type = string
}
variable "compartment_id" {
  type = string
}
variable "size_gb" {
  type = number
}
variable "vpus_per_gb" {
  type    = number
  default = 10
}
variable "tags" {
  type    = map(string)
  default = {}
}
