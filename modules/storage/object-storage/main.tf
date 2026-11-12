resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_id
  namespace      = var.namespace
  name           = var.name
  access_type    = "NoPublicAccess"
  versioning     = "Disabled"
  storage_tier   = "Standard"
  freeform_tags  = var.tags

  lifecycle {
    prevent_destroy = true
  }
}
