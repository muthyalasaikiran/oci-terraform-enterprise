module "servers" {
  for_each = var.servers
  source   = "../../../../modules/compute/multi-server-instance"

  name                = each.key
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = var.subnet_id
  image_id            = var.image_id
  shape               = each.value.shape
  ocpus               = each.value.ocpus
  memory_in_gbs       = each.value.memory_in_gbs
  private_ip          = each.value.private_ip
  nsg_ids             = var.nsg_ids
  ssh_public_key_path = var.ssh_public_key_path
  tags                = var.tags
}
