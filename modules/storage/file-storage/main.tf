resource "oci_file_storage_file_system" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.name
  freeform_tags       = var.tags

  lifecycle { prevent_destroy = false }
}
