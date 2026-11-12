module "bucket" {
  source         = "../../../../../modules/storage/object-storage"
  compartment_id = var.compartment_id
  namespace      = var.namespace
  name           = var.bucket_name
  tags           = var.tags
}

resource "oci_objectstorage_object" "sample" {
  count        = var.upload_sample_object ? 1 : 0
  namespace    = module.bucket.namespace
  bucket       = module.bucket.bucket_name
  object       = var.sample_object_name
  source       = "${path.module}/sample/test-upload.txt"
  content_type = "text/plain"

  lifecycle {
    prevent_destroy = true
  }
}