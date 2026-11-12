variable "region" {
  type = string
}
variable "compartment_id" {
  type = string
}
variable "namespace" {
  description = "Find using: oci os ns get --region ap-mumbai-1 --profile DEFAULT"
  type        = string
}
variable "bucket_name" {
  description = "Choose a unique sample test bucket name; do not use an existing bucket name."
  type        = string
}
variable "upload_sample_object" {
  description = "Upload only the harmless sample text file when true."
  type        = bool
  default     = true
}
variable "sample_object_name" {
  type    = string
  default = "terraform-tests/test-upload.txt"
}
variable "tags" {
  type    = map(string)
  default = {}
}
