variable "region" {
  type = string
}
variable "compartment_id" {
  type = string
}
variable "availability_domain" {
  type = string
}
variable "volume_name" {
  type = string
}
variable "size_gb" {
  type = number
  validation {
    condition     = var.size_gb >= 50
    error_message = "OCI block volumes must be at least 50 GB."
  }
}
variable "vpus_per_gb" {
  type    = number
  default = 10
}
variable "tags" {
  type    = map(string)
  default = {}
}
