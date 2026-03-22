locals {
  users = toset([
    for f in fileset(var.policies_dir, "*.hcl") : trimsuffix(basename(f), ".hcl")
  ])
}

data "vault_auth_backend" "oidc" {
  path = var.auth_path
}

resource "vault_policy" "this" {
  for_each = local.users

  name   = each.key
  policy = file("${var.policies_dir}/${each.key}.hcl")
}

resource "vault_identity_entity" "this" {
  for_each = local.users

  name     = each.key
  policies = [each.key]
}

resource "vault_identity_entity_alias" "this" {
  for_each = local.users

  name           = each.key
  mount_accessor = data.vault_auth_backend.oidc.accessor
  canonical_id   = vault_identity_entity.this[each.key].id
}
