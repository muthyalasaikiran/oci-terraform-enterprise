
# MSK_sample - Multiple OCI Servers using count
# Supports automatic, manual and mixed private IP allocation

module "servers" {
  count  = var.server_count
  source = "../../../../modules/compute/multi-server-instance"

  name = format("%s%02d", var.name_prefix, count.index + 1)

  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = var.subnet_id
  image_id            = var.image_id

  shape         = var.shape
  ocpus         = var.ocpus
  memory_in_gbs = var.memory_in_gbs

  # Empty list or null = OCI automatically assigns an IP
  # Specified IP = OCI requests that private IP
  private_ip = try(var.private_ips[count.index], null)

  nsg_ids             = var.nsg_ids
  ssh_public_key_path = var.ssh_public_key_path
  tags                = var.tags
}

