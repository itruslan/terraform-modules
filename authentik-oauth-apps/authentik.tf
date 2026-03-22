# Lookup existing authorization and invalidation flows
data "authentik_flow" "authorization" {
  slug = var.authorization_flow_slug
}

data "authentik_flow" "invalidation" {
  slug = var.invalidation_flow_slug
}

# Lookup signing certificate (RS256) — authentik self-signed by default
data "authentik_certificate_key_pair" "signing" {
  name = var.signing_key_name
}

# Lookup built-in OIDC scope property mappings
data "authentik_property_mapping_provider_scope" "oidc" {
  managed_list = [
    "goauthentik.io/providers/oauth2/scope-openid",
    "goauthentik.io/providers/oauth2/scope-profile",
    "goauthentik.io/providers/oauth2/scope-email",
  ]
}

# Shared groups scope mapping for all apps
resource "authentik_property_mapping_provider_scope" "groups" {
  name       = "groups-oauth-apps"
  scope_name = "groups"
  expression = "return list(request.user.ak_groups.values_list('name', flat=True))"
}

# Generate OIDC client secret per app (stored in tfstate)
resource "random_password" "client_secret" {
  for_each = var.apps

  length  = 40
  special = false
}

# OAuth2/OIDC Provider per app
resource "authentik_provider_oauth2" "this" {
  for_each = var.apps

  name               = each.value.name
  client_id          = coalesce(each.value.client_id, each.key)
  client_secret      = random_password.client_secret[each.key].result
  authorization_flow = data.authentik_flow.authorization.id
  invalidation_flow  = data.authentik_flow.invalidation.id

  allowed_redirect_uris = [
    for uri in each.value.allowed_redirect_uris : {
      matching_mode = "strict"
      url           = uri
    }
  ]

  property_mappings = concat(
    data.authentik_property_mapping_provider_scope.oidc.ids,
    [authentik_property_mapping_provider_scope.groups.id],
  )
  signing_key = data.authentik_certificate_key_pair.signing.id
  sub_mode    = "user_username"
}

# Application per app
resource "authentik_application" "this" {
  for_each = var.apps

  name              = each.value.name
  slug              = each.key
  protocol_provider = authentik_provider_oauth2.this[each.key].id
}
