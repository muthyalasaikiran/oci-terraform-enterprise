resource "oci_core_volume_backup" "this" {
  volume_id     = var.volume_id
  display_name  = var.name
  type          = var.backup_type
  freeform_tags = var.tags

  lifecycle {
    prevent_destroy = false
  }
}
