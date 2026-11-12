variable "export_set_id" { type = string }
variable "file_system_id" { type = string }
variable "path" { type = string }
variable "client_cidr" { type = string }
variable "access" {
  type    = string
  default = "READ_ONLY"
  validation {
    condition     = contains(["READ_ONLY", "READ_WRITE"], var.access)
    error_message = "access must be READ_ONLY or READ_WRITE."
  }
}
