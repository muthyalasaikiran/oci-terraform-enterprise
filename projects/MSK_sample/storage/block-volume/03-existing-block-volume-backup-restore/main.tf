# Source block volume is referenced by OCID only. It is NEVER managed by this state.
resource "oci_core_volume_backup" "backup" {
  count         = var.create_backup ? 1 : 0
  volume_id     = var.existing_volume_id
  display_name  = var.backup_name
  type          = var.backup_type
  freeform_tags = var.tags

  lifecycle {
    prevent_destroy = false
  }
}

resource "oci_core_volume" "restored" {
  count               = var.create_restore ? 1 : 0
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.restored_volume_name
  freeform_tags       = var.tags
  vpus_per_gb         = var.restored_vpus_per_gb

  source_details {
    type = "volumeBackup"
    id   = oci_core_volume_backup.backup[0].id
  }

  lifecycle {
    prevent_destroy = false
  }
}
