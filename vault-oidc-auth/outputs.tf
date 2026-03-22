output "auth_backend_path" {
  description = "OIDC auth backend mount path"
  value       = vault_jwt_auth_backend.this.path
}

output "auth_backend_accessor" {
  description = "OIDC auth backend accessor (used to link identity group aliases)"
  value       = vault_jwt_auth_backend.this.accessor
}
