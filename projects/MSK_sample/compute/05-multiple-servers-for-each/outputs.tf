output "server_ids" {
  value = { for name, server in module.servers : name => server.instance_id }
}
output "server_private_ips" {
  value = { for name, server in module.servers : name => server.private_ip }
}
