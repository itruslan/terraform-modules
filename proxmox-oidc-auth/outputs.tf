output "realm" {
  description = "Proxmox realm ID"
  value       = null_resource.realm.triggers.realm
}
