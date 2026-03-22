# Сохраняет client_secret в Vault для каждого приложения у которого задан vault_secret_path
resource "vault_kv_secret_v2" "client_secret" {
  for_each = var.vault_enabled ? { for k, v in var.apps : k => v if v.vault_secret_path != null } : {}

  mount               = var.vault_mount_path
  name                = each.value.vault_secret_path
  delete_all_versions = true

  data_json = jsonencode({
    clientSecret = random_password.client_secret[each.key].result
    clientId     = authentik_provider_oauth2.this[each.key].client_id
    issuerUrl    = var.authentik_url != null ? "${var.authentik_url}/application/o/${each.key}/" : "/application/o/${each.key}/"
  })
}
