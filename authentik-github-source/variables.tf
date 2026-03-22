variable "vault_address" {
  description = "Vault server address"
  type        = string
}

variable "vault_secret_path" {
  description = "Vault KV v2 path where GitHub OAuth credentials are stored"
  type        = string
  default     = "authentik/github-source"
}

variable "vault_mount_path" {
  description = "Vault KV v2 mount point"
  type        = string
  default     = "secret"
}

variable "authentik_url" {
  description = "Authentik base URL — used to construct the callback URL output"
  type        = string
  default     = null
}

variable "github_allowed_orgs" {
  description = "List of GitHub organizations to restrict login to. Empty = allow all GitHub users."
  type        = list(string)
  default     = []
}

variable "admin_github_usernames" {
  description = "GitHub usernames automatically assigned to authentik Admins group on enrollment"
  type        = list(string)
  default     = []
}

variable "authentication_flow_slug" {
  description = "Slug of the Authentik flow used by the OAuth source (post-auth)"
  type        = string
  default     = "default-source-authentication"
}

variable "login_flow_slug" {
  description = "Slug of the main login flow (used in after_hook to patch identification stage)"
  type        = string
  default     = "default-authentication-flow"
}

variable "enrollment_flow_slug" {
  description = "Slug of the Authentik enrollment flow"
  type        = string
  default     = "default-source-enrollment"
}
