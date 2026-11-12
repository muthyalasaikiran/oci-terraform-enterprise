module "data_attachment" {
  source          = "../../../../../modules/storage/volume-attachment"
  name            = var.attachment_name
  instance_id     = var.instance_id
  volume_id       = var.volume_id
  attachment_type = var.attachment_type
}
