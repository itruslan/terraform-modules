variable "vault_address" {
  description = "Vault server address"
  type        = string
}

variable "issuer_url" {
  description = "OIDC discovery URL"
  type        = string
}

variable "client_id" {
  description = "OIDC client ID"
  type        = string
}

variable "client_secret" {
  description = "OIDC client secret"
  type        = string
  sensitive   = true
}

variable "allowed_redirect_uris" {
  description = "Allowed redirect URIs for OIDC callback"
  type        = list(string)
}

variable "auth_path" {
  description = "OIDC auth backend mount path in Vault"
  type        = string
  default     = "oidc"
}

variable "auth_description" {
  description = "Description for the OIDC auth backend"
  type        = string
  default     = "OIDC"
}

variable "scopes" {
  description = "OIDC scopes to request"
  type        = list(string)
  default     = ["openid", "profile", "email", "groups"]
}

variable "user_claim" {
  description = "JWT claim to use as the user identity"
  type        = string
  default     = "preferred_username"
}

variable "groups_claim" {
  description = "JWT claim to use for group membership"
  type        = string
  default     = "groups"
}

variable "token_ttl" {
  description = "Default TTL for OIDC tokens (seconds)"
  type        = number
  default     = 3600
}

variable "token_max_ttl" {
  description = "Max TTL for OIDC tokens (seconds)"
  type        = number
  default     = 86400
}
