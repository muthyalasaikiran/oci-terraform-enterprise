variable "region" { type = string }
variable "compartment_id" { type = string }
variable "availability_domain" { type = string }
variable "existing_volume_id" {
  type = string
  validation {
    condition     = startswith(var.existing_volume_id, "ocid1.volume.")
    error_message = "Supply a block volume OCID beginning ocid1.volume.; not an instance or boot-volume OCID."
  }
}
variable "backup_name" { type = string }
variable "backup_type" {
  type    = string
  default = "FULL"
  validation {
    condition     = contains(["FULL", "INCREMENTAL"], var.backup_type)
    error_message = "Use FULL or INCREMENTAL."
  }
}
variable "restored_volume_name" { type = string }
variable "restored_vpus_per_gb" {
  type    = number
  default = 10
}
variable "create_backup" {
  type    = bool
  default = true
}
variable "create_restore" {
  type    = bool
  default = false
  validation {
    condition     = !var.create_restore || var.create_backup
    error_message = "create_restore=true requires create_backup=true."
  }
}
variable "tags" {
  type    = map(string)
  default = {}
}
