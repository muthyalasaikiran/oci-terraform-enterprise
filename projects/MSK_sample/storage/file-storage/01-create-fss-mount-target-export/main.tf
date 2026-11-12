module "file_system" {
  source              = "../../../../../modules/storage/file-storage"
  name                = var.file_system_name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  tags                = var.tags
}

module "mount_target" {
  source              = "../../../../../modules/storage/mount-target"
  name                = var.mount_target_name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  subnet_id           = var.mount_target_subnet_id
  nsg_ids             = var.mount_target_nsg_ids
  tags                = var.tags
}

module "export" {
  source         = "../../../../../modules/storage/fss-export"
  file_system_id = module.file_system.file_system_id
  export_set_id  = module.mount_target.export_set_id
  path           = var.export_path
  client_cidr    = var.client_cidr
  access         = var.export_access
}
