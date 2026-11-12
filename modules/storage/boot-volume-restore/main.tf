resource "oci_core_boot_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  source_details {
    type = "bootVolumeBackup"
    id   = var.backup_id
  }
  freeform_tags = var.freeform_tags
  lifecycle {
    prevent_destroy = true
  }
}
