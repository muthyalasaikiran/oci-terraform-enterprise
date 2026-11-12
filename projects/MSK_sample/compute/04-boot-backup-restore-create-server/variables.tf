variable "region" {
  type    = string
  default = "ap-mumbai-1"
}

variable "oci_profile" {
  type    = string
  default = "DEFAULT"
}

variable "compartment_id" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "source_boot_volume_id" {
  type = string
}

variable "backup_name" {
  type = string
}

variable "restored_boot_volume_name" {
  type = string
}

variable "new_server_name" {
  type = string
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "shape" {
  type    = string
  default = "VM.Standard.E4.Flex"
}

variable "ocpus" {
  type    = number
  default = 1
}

variable "memory_in_gbs" {
  type    = number
  default = 8
}

variable "ssh_authorized_keys" {
  type    = string
  default = ""
}

variable "create_backup" {
  type    = bool
  default = false
}

variable "create_restore" {
  type    = bool
  default = false
}

variable "create_server" {
  type    = bool
  default = false
}

variable "freeform_tags" {
  type    = map(string)
  default = { ManagedBy = "Terraform", Project = "MSK_sample" }
}

variable "private_ip" {
  description = "Specific private IP address for the new test server"
  type        = string
  default     = null
}


variable "nsg_ids" {
  description = "NSGs for the compute instance primary VNIC"
  type        = list(string)
  default     = []
}
