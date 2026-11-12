variable "volume_id" { type = string }
variable "name" { type = string }
variable "backup_type" {
  type    = string
  default = "FULL"
  validation {
    condition     = contains(["FULL", "INCREMENTAL"], var.backup_type)
    error_message = "backup_type must be FULL or INCREMENTAL."
  }
}
variable "tags" {
  type    = map(string)
  default = {}
}
