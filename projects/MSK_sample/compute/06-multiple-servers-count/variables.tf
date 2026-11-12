
variable "region" {
  default = "ap-mumbai-1"
}

variable "oci_profile" {
  default = "DEFAULT"
}

variable "compartment_id" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "image_id" {
  type = string
}

variable "ssh_public_key_path" {
  type    = string
  default = null
}

variable "nsg_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "server_count" {
  type    = number
  default = 0

  validation {
    condition     = var.server_count >= 0 && floor(var.server_count) == var.server_count
    error_message = "server_count must be a nonnegative integer."
  }
}

variable "name_prefix" {
  default = "MSK-TF-UAT-COUNT"
}

variable "shape" {
  default = "VM.Standard.E5.Flex"
}

variable "ocpus" {
  default = 1
}

variable "memory_in_gbs" {
  default = 8
}

# Optional private IPs for count instances.
# [] means all IPs are automatically allocated.
# null entries mean automatic allocation for those servers.

variable "private_ips" {
  description = "Private IPs by count index; null means automatic allocation."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.private_ips) == 0 || length(var.private_ips) == var.server_count
    error_message = "Provide an empty list or exactly one IP entry per server."
  }

  validation {
    condition = length(distinct([
      for ip in var.private_ips : ip
      if ip != null
      ])) == length([
      for ip in var.private_ips : ip
      if ip != null
    ])

    error_message = "Manual private IP addresses must be unique."
  }
}
