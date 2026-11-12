resource "oci_core_boot_volume_backup" "this" {
  boot_volume_id = var.source_boot_volume_id
  display_name   = var.display_name
  type           = "FULL"
  freeform_tags  = var.freeform_tags
  lifecycle {
    prevent_destroy = true
  }
}
