variable "compartment_id" {
  type = string
}
variable "namespace" {
  type = string
}
variable "name" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
