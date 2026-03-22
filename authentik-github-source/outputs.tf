output "source_slug" {
  description = "Authentik GitHub source slug"
  value       = authentik_source_oauth.github.slug
}

output "source_uuid" {
  description = "Authentik GitHub source UUID"
  value       = authentik_source_oauth.github.uuid
}

output "callback_url" {
  description = "GitHub OAuth App callback URL — add this to your GitHub OAuth App settings"
  value       = "${var.authentik_url}/source/oauth/callback/github/"
}
