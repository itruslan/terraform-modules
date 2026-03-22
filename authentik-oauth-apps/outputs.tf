output "apps" {
  description = "Map of created apps with their OIDC metadata"
  value = {
    for k in keys(authentik_provider_oauth2.this) : k => {
      client_id   = authentik_provider_oauth2.this[k].client_id
      issuer_path = "/application/o/${k}/"
      slug        = authentik_application.this[k].slug
    }
  }
}

output "client_secrets" {
  description = "Map of client secrets per app slug (sensitive)"
  sensitive   = true
  value = {
    for k in keys(random_password.client_secret) : k => random_password.client_secret[k].result
  }
}

output "vault_secret_urls" {
  description = "Vault UI URLs for app secrets (only for apps with vault_secret_path set)"
  value = var.vault_enabled ? {
    for k, v in var.apps : k =>
    "${var.vault_address}/ui/vault/secrets/${var.vault_mount_path}/kv/${urlencode(v.vault_secret_path)}"
    if v.vault_secret_path != null
  } : {}
}
