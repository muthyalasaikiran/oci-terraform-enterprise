output "bucket_name" {
  value = module.bucket.bucket_name
}
output "bucket_id" {
  value = module.bucket.bucket_id
}
output "namespace" {
  value = module.bucket.namespace
}
output "sample_object_name" {
  value = var.upload_sample_object ? var.sample_object_name : null
}
