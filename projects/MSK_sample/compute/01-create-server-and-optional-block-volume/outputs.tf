output "instance_id" { value = module.server.instance_id }
output "private_ip" { value = module.server.private_ip }
output "boot_volume_id" { value = module.server.boot_volume_id }
output "data_volume_id" { value = var.create_data_volume ? module.data_volume[0].volume_id : null }
