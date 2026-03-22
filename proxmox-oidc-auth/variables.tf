variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint"
  type        = string
}

variable "realm" {
  description = "Proxmox realm ID (short name used at login prompt)"
  type        = string
  default     = "authentik"
}

variable "comment" {
  description = "Human-readable description of the realm"
  type        = string
  default     = "Authentik OIDC"
}

variable "issuer_url" {
  description = "OIDC issuer URL (e.g. https://auth.example.com/application/o/proxmox/)"
  type        = string
}

variable "client_id" {
  description = "OAuth2 client ID"
  type        = string
}

variable "client_key" {
  description = "OAuth2 client secret"
  type        = string
  sensitive   = true
}

variable "username_claim" {
  description = "JWT claim to use as Proxmox username"
  type        = string
  default     = "preferred_username"
}

variable "scopes" {
  description = "Space-separated list of OIDC scopes to request"
  type        = string
  default     = "openid profile email"
}

variable "autocreate" {
  description = "Auto-create Proxmox users on first OIDC login"
  type        = bool
  default     = false
}

variable "default_realm" {
  description = "Make this the default realm on the login page"
  type        = bool
  default     = false
}
