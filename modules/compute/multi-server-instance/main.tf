resource "oci_core_instance" "this" {
  compartment_id       = var.compartment_id
  availability_domain  = var.availability_domain
  display_name         = var.name
  shape                = var.shape
  preserve_boot_volume = false

  dynamic "shape_config" {
    for_each = endswith(var.shape, ".Flex") ? [1] : []
    content {
      ocpus         = var.ocpus
      memory_in_gbs = var.memory_in_gbs
    }
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = false
    private_ip       = var.private_ip
    nsg_ids          = var.nsg_ids
  }

  metadata = var.ssh_public_key_path == null ? {} : {
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))
  }
  freeform_tags = var.tags

  lifecycle {
    # Protect approved servers. For DELETION ONLY, change false temporarily,
    # review terraform plan (specific instance only), then restore true..
    prevent_destroy = true
  }
}
