resource "oci_core_instance" "this" {
  availability_domain  = var.availability_domain
  compartment_id       = var.compartment_id
  display_name         = var.name
  shape                = var.shape
  preserve_boot_volume = true

  dynamic "shape_config" {
    for_each = var.shape_ocpus == null ? [] : [1]
    content {
      ocpus         = var.shape_ocpus
      memory_in_gbs = var.shape_memory_gbs
    }
  }

  source_details {
    source_type = var.source_type
    source_id   = var.source_id
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
    nsg_ids          = var.nsg_ids
    hostname_label   = var.hostname_label
  }

  metadata = var.ssh_public_key_path == null ? {} : {
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))
  }


  freeform_tags = var.tags

  lifecycle {
    prevent_destroy = true
    precondition {
      condition     = var.shape_ocpus == null || var.shape_memory_gbs != null
      error_message = "shape_memory_gbs must be set when shape_ocpus is set."
    }
  }
}
