# IMPORTANT: Original source boot volume is referenced ONLY by OCID, never managed.
# This project owns only the new FULL backup, restored volume and optional test server.
# For cleanup, see README.md: temporarily set prevent_destroy=false ONE resource at a time.
resource "oci_core_boot_volume_backup" "backup" {
  count          = var.create_backup ? 1 : 0
  boot_volume_id = var.source_boot_volume_id
  display_name   = var.backup_name
  type           = "FULL"
  freeform_tags  = var.freeform_tags
  lifecycle {
    prevent_destroy = true
  }
}

resource "oci_core_boot_volume" "restored" {
  count               = var.create_restore ? 1 : 0
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.restored_boot_volume_name
  source_details {
    type = "bootVolumeBackup"
    id   = oci_core_boot_volume_backup.backup[0].id
  }
  freeform_tags = var.freeform_tags
  lifecycle {
    prevent_destroy = true
  }
}

resource "oci_core_instance" "test_server" {
  count               = var.create_server ? 1 : 0
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.new_server_name
  shape               = var.shape
  dynamic "shape_config" {
    for_each = endswith(var.shape, ".Flex") ? [1] : []
    content {
      ocpus         = var.ocpus
      memory_in_gbs = var.memory_in_gbs
    }
  }
  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = false
    private_ip       = var.private_ip
    nsg_ids          = var.nsg_ids
  }
  source_details {
    source_type = "bootVolume"
    source_id   = oci_core_boot_volume.restored[0].id
  }
  # Preserve separate restored boot volume when the test server is terminated.
  preserve_boot_volume = true
  freeform_tags        = var.freeform_tags
  lifecycle {
    prevent_destroy = true
    precondition {
      condition     = var.create_backup && var.create_restore && trimspace(var.subnet_id) != ""
      error_message = "Server launch requires create_backup=true, create_restore=true and subnet_id set."
    }
  }
}
