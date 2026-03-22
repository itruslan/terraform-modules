resource "vault_jwt_auth_backend" "this" {
  path               = var.auth_path
  type               = "oidc"
  description        = var.auth_description
  oidc_discovery_url = var.issuer_url
  oidc_client_id     = var.client_id
  oidc_client_secret = var.client_secret
  default_role       = "default"

  tune {
    listing_visibility = "unauth"
    default_lease_ttl  = "1h"
    max_lease_ttl      = "24h"
    token_type         = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "default" {
  backend   = vault_jwt_auth_backend.this.path
  role_name = "default"
  role_type = "oidc"

  token_policies = []

  oidc_scopes           = var.scopes
  user_claim            = var.user_claim
  groups_claim          = var.groups_claim
  allowed_redirect_uris = var.allowed_redirect_uris

  token_ttl     = var.token_ttl
  token_max_ttl = var.token_max_ttl
}
