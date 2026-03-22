output "entity_ids" {
  description = "Map of username to Vault identity entity ID"
  value       = { for k, v in vault_identity_entity.this : k => v.id }
}

output "policy_names" {
  description = "List of created Vault policy names"
  value       = [for k in vault_policy.this : k.name]
}
