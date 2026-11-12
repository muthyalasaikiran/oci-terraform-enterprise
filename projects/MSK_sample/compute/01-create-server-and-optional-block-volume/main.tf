module "server" {
  source              = "../../../../modules/compute/compute"
  name                = var.instance_name
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = var.subnet_id
  shape               = var.shape
  shape_ocpus         = var.shape_ocpus
  shape_memory_gbs    = var.shape_memory_gbs
  source_type         = "image"
  source_id           = var.source_id
  ssh_public_key_path = var.ssh_public_key_path
  nsg_ids             = var.nsg_ids
  assign_public_ip    = var.assign_public_ip
  tags                = var.tags
}

module "data_volume" {
  count               = var.create_data_volume ? 1 : 0
  source              = "../../../../modules/storage/block-volume"
  name                = var.data_volume_name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  size_gb             = var.data_volume_size_gb
  vpus_per_gb         = var.data_volume_vpus_per_gb
  tags                = var.tags
}

module "data_attachment" {
  count       = var.create_data_volume ? 1 : 0
  source      = "../../../../modules/storage/volume-attachment"
  name        = "${var.instance_name}-data-attachment"
  instance_id = module.server.instance_id
  volume_id   = module.data_volume[0].volume_id
}
