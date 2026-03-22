output "groups" {
  description = "Created group IDs"
  value       = { for k, v in proxmox_virtual_environment_group.this : k => v.group_id }
}

output "users" {
  description = "Created user IDs"
  value       = { for k, v in proxmox_virtual_environment_user.this : k => v.user_id }
}
