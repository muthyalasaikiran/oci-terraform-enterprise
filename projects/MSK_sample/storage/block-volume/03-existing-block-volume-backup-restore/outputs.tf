output "source_volume_id" {
  description = "Read-only input: existing source volume, NOT tracked as a managed resource"
  value       = var.existing_volume_id
}
output "backup_id" {
  value = try(oci_core_volume_backup.backup[0].id, null)
}
output "restored_volume_id" {
  value = try(oci_core_volume.restored[0].id, null)
}
