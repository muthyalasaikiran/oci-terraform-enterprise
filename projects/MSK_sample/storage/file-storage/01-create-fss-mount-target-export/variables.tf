variable "region" { type = string }
variable "compartment_id" { type = string }
variable "availability_domain" { type = string }
variable "file_system_name" { type = string }
variable "mount_target_name" { type = string }
variable "mount_target_subnet_id" { type = string }
variable "mount_target_nsg_ids" { type = list(string) }
variable "export_path" { type = string }
variable "client_cidr" { type = string }
variable "export_access" {
  type    = string
  default = "READ_ONLY"
  validation {
    condition     = contains(["READ_ONLY", "READ_WRITE"], var.export_access)
    error_message = "export_access must be READ_ONLY or READ_WRITE."
  }
}
variable "tags" {
  type    = map(string)
  default = {}
}

