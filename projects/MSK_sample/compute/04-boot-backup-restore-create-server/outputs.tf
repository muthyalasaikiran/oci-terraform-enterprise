output "source_boot_volume_id" { value = var.source_boot_volume_id }
output "full_backup_id" { value = try(oci_core_boot_volume_backup.backup[0].id, null) }
output "full_backup_state" { value = try(oci_core_boot_volume_backup.backup[0].state, null) }
output "restored_boot_volume_id" { value = try(oci_core_boot_volume.restored[0].id, null) }
output "restored_boot_volume_state" { value = try(oci_core_boot_volume.restored[0].state, null) }
output "test_server_id" { value = try(oci_core_instance.test_server[0].id, null) }
output "test_server_state" { value = try(oci_core_instance.test_server[0].state, null) }
