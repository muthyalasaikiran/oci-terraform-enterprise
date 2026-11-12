variable "region" {
  type = string
}
variable "instance_id" {
  type = string
}
variable "volume_id" {
  type = string
}
variable "attachment_name" {
  type = string
}
variable "attachment_type" {
  type    = string
  default = "paravirtualized"
  validation {
    condition     = contains(["paravirtualized", "iscsi"], var.attachment_type)
    error_message = "Use paravirtualized or iscsi."
  }
}
