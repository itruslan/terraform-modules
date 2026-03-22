variable "vault_address" {
  description = "Vault server address"
  type        = string
}

variable "policies_dir" {
  description = "Absolute path to directory with per-user policy files (.hcl). Filename (without extension) = username = policy name."
  type        = string
}

variable "auth_path" {
  description = "OIDC auth backend mount path in Vault"
  type        = string
  default     = "oidc"
}
