resource "oci_file_storage_mount_target" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  subnet_id           = var.subnet_id
  display_name        = var.name
  nsg_ids             = var.nsg_ids
  freeform_tags       = var.tags

  lifecycle { prevent_destroy = false }
}
