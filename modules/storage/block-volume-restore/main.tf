resource "oci_core_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.name
  vpus_per_gb         = var.vpus_per_gb
  freeform_tags       = var.tags

  source_details {
    type = "volumeBackup"
    id   = var.backup_id
  }

  lifecycle {
    prevent_destroy = false
  }
}
