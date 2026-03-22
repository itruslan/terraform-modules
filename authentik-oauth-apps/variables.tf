variable "apps" {
  description = "Map of OAuth2 applications to create in Authentik. Key = application slug. client_id defaults to slug. vault_secret_path — if set, writes clientSecret to Vault."
  type = map(object({
    name                  = string
    allowed_redirect_uris = list(string)
    client_id             = optional(string)
    vault_secret_path     = optional(string)
  }))
}

variable "authentik_url" {
  description = "Authentik base URL - Used to construct issuerUrl in Vault secrets."
  type        = string
  default     = null
}

variable "vault_enabled" {
  description = "Enable Vault integration for storing OAuth2 app secrets"
  type        = bool
  default     = false
}

variable "vault_address" {
  description = "Vault server address"
  type        = string
}

variable "vault_mount_path" {
  description = "Vault KV v2 mount point"
  type        = string
  default     = "secret"
}

variable "signing_key_name" {
  description = "Name of the Authentik certificate key pair used for RS256 JWT signing"
  type        = string
  default     = "authentik Self-signed Certificate"
}

variable "authorization_flow_slug" {
  description = "Slug of the Authentik authorization flow"
  type        = string
  default     = "default-provider-authorization-implicit-consent"
}

variable "invalidation_flow_slug" {
  description = "Slug of the Authentik invalidation flow"
  type        = string
  default     = "default-provider-invalidation-flow"
}
