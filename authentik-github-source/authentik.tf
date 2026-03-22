data "authentik_flow" "authentication" {
  slug = var.authentication_flow_slug
}

data "authentik_flow" "login" {
  slug = var.login_flow_slug
}

# Identification stage managed by Terraform — bound to login flow
resource "authentik_stage_identification" "this" {
  name        = "github-identification"
  sources     = [authentik_source_oauth.github.uuid]
  user_fields = ["username", "email"]
}

resource "authentik_flow_stage_binding" "identification" {
  target = data.authentik_flow.login.id
  stage  = authentik_stage_identification.this.id
  order  = 10
}

data "authentik_flow" "enrollment" {
  slug = var.enrollment_flow_slug
}

# GitHub OAuth source
resource "authentik_source_oauth" "github" {
  name                = "GitHub"
  slug                = "github"
  authentication_flow = data.authentik_flow.authentication.id
  enrollment_flow     = data.authentik_flow.enrollment.id

  provider_type      = "github"
  promoted           = true
  user_matching_mode = "username_link"
  consumer_key       = data.vault_kv_secret_v2.github.data["client-id"]
  consumer_secret    = data.vault_kv_secret_v2.github.data["client-secret"]

  additional_scopes = length(var.github_allowed_orgs) > 0 ? "read:org" : ""

  lifecycle {
    ignore_changes = [oidc_jwks_url]
  }
}

# Policy: assign authentik Admins group to specified GitHub usernames on enrollment
resource "authentik_policy_expression" "github_admin_assignment" {
  count = length(var.admin_github_usernames) > 0 ? 1 : 0

  name       = "github-admin-assignment"
  expression = <<-EOT
    from authentik.core.models import Group
    admin_usernames = ${jsonencode(var.admin_github_usernames)}
    user = request.context.get("pending_user") or request.user
    if user and not user.is_anonymous and user.username in admin_usernames:
        admins = Group.objects.get(name="authentik Admins")
        user.ak_groups.add(admins)
    return True
  EOT
}

resource "authentik_stage_dummy" "admin_assignment" {
  count = length(var.admin_github_usernames) > 0 ? 1 : 0
  name  = "github-admin-assignment"
}

resource "authentik_flow_stage_binding" "admin_assignment" {
  count  = length(var.admin_github_usernames) > 0 ? 1 : 0
  target = data.authentik_flow.enrollment.id
  stage  = authentik_stage_dummy.admin_assignment[0].id
  order  = 3
}

resource "authentik_policy_binding" "github_admin_assignment" {
  count = length(var.admin_github_usernames) > 0 ? 1 : 0

  target  = authentik_flow_stage_binding.admin_assignment[0].id
  policy  = authentik_policy_expression.github_admin_assignment[0].id
  order   = 0
  enabled = true
}
