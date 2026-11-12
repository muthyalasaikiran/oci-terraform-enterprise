resource "oci_core_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.name
  size_in_gbs         = var.size_gb
  vpus_per_gb         = var.vpus_per_gb
  freeform_tags       = var.tags

  lifecycle { prevent_destroy = true }
}
