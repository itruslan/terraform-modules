# Reads GitHub OAuth credentials from Vault
data "vault_kv_secret_v2" "github" {
  mount = var.vault_mount_path
  name  = var.vault_secret_path
}
