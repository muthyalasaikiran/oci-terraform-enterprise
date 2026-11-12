variable "name" {
  type = string
}
variable "instance_id" {
  type = string
}
variable "volume_id" {
  type = string
}
variable "attachment_type" {
  type    = string
  default = "paravirtualized"
  validation {
    condition     = contains(["paravirtualized", "iscsi"], var.attachment_type)
    error_message = "attachment_type must be paravirtualized or iscsi."
  }
}
