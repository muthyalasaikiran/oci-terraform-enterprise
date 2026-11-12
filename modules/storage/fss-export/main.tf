resource "oci_file_storage_export" "this" {
  export_set_id  = var.export_set_id
  file_system_id = var.file_system_id
  path           = var.path

  export_options {
    source          = var.client_cidr
    access          = var.access
    identity_squash = "ROOT"
  }

  lifecycle { prevent_destroy = false }
}
