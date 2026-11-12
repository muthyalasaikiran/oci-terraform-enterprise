module "data_volume" {
  source              = "../../../../../modules/storage/block-volume"
  name                = var.volume_name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  size_gb             = var.size_gb
  vpus_per_gb         = var.vpus_per_gb
  tags                = var.tags
}
