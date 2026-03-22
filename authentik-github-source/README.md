# authentik-github-source

Configures GitHub OAuth source in Authentik. Creates OAuth source, binds GitHub button to login flow, sets enrollment to internal users, auto-assigns admin group to specified GitHub usernames.

## Requirements

```bash
export AUTHENTIK_URL="https://auth.example.com"
export AUTHENTIK_TOKEN="<api-token>"
export VAULT_ADDR="https://vault.example.com"
export VAULT_TOKEN="<vault-token>"
```

GitHub OAuth App credentials must be stored in Vault:
```bash
vault kv put secret/authentik/github-source client-id=<id> client-secret=<secret>
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4 |
| <a name="requirement_authentik"></a> [authentik](#requirement\_authentik) | ~> 2025.2 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_authentik"></a> [authentik](#provider\_authentik) | 2025.12.1 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [authentik_flow_stage_binding.admin_assignment](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.identification](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/flow_stage_binding) | resource |
| [authentik_policy_binding.github_admin_assignment](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/policy_binding) | resource |
| [authentik_policy_expression.github_admin_assignment](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/policy_expression) | resource |
| [authentik_source_oauth.github](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/source_oauth) | resource |
| [authentik_stage_dummy.admin_assignment](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/stage_dummy) | resource |
| [authentik_stage_identification.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/stage_identification) | resource |
| [authentik_flow.authentication](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_flow.enrollment](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_flow.login](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [vault_kv_secret_v2.github](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_github_usernames"></a> [admin\_github\_usernames](#input\_admin\_github\_usernames) | GitHub usernames automatically assigned to authentik Admins group on enrollment | `list(string)` | `[]` | no |
| <a name="input_authentication_flow_slug"></a> [authentication\_flow\_slug](#input\_authentication\_flow\_slug) | Slug of the Authentik flow used by the OAuth source (post-auth) | `string` | `"default-source-authentication"` | no |
| <a name="input_authentik_url"></a> [authentik\_url](#input\_authentik\_url) | Authentik base URL — used to construct the callback URL output | `string` | `null` | no |
| <a name="input_enrollment_flow_slug"></a> [enrollment\_flow\_slug](#input\_enrollment\_flow\_slug) | Slug of the Authentik enrollment flow | `string` | `"default-source-enrollment"` | no |
| <a name="input_github_allowed_orgs"></a> [github\_allowed\_orgs](#input\_github\_allowed\_orgs) | List of GitHub organizations to restrict login to. Empty = allow all GitHub users. | `list(string)` | `[]` | no |
| <a name="input_login_flow_slug"></a> [login\_flow\_slug](#input\_login\_flow\_slug) | Slug of the main login flow (used in after\_hook to patch identification stage) | `string` | `"default-authentication-flow"` | no |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault server address | `string` | n/a | yes |
| <a name="input_vault_mount_path"></a> [vault\_mount\_path](#input\_vault\_mount\_path) | Vault KV v2 mount point | `string` | `"secret"` | no |
| <a name="input_vault_secret_path"></a> [vault\_secret\_path](#input\_vault\_secret\_path) | Vault KV v2 path where GitHub OAuth credentials are stored | `string` | `"authentik/github-source"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_callback_url"></a> [callback\_url](#output\_callback\_url) | GitHub OAuth App callback URL — add this to your GitHub OAuth App settings |
| <a name="output_source_slug"></a> [source\_slug](#output\_source\_slug) | Authentik GitHub source slug |
| <a name="output_source_uuid"></a> [source\_uuid](#output\_source\_uuid) | Authentik GitHub source UUID |
<!-- END_TF_DOCS -->
