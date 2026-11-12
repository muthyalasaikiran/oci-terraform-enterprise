resource "oci_core_volume_attachment" "this" {
  attachment_type = var.attachment_type
  instance_id     = var.instance_id
  volume_id       = var.volume_id
  display_name    = var.name

  lifecycle { prevent_destroy = true }
}
