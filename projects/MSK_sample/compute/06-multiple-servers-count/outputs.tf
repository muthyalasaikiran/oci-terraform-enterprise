output "server_ids" {
  value = [for server in module.servers : server.instance_id]
}
output "server_private_ips" {
  value = [for server in module.servers : server.private_ip]
}
