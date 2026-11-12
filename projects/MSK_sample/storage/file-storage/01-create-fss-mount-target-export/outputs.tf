output "file_system_id" { value = module.file_system.file_system_id }
output "mount_target_id" { value = module.mount_target.mount_target_id }
output "mount_target_private_ip_ids" { value = module.mount_target.private_ip_ids }
output "export_set_id" { value = module.mount_target.export_set_id }
output "export_id" { value = module.export.export_id }
output "export_path" { value = module.export.export_path }
