# authentik-oauth-apps

Creates OAuth2/OIDC providers and applications in Authentik. Generates client secrets and optionally stores them in Vault KV.

## Requirements

```bash
export AUTHENTIK_URL="https://auth.example.com"
export AUTHENTIK_TOKEN="<api-token>"
export VAULT_ADDR="https://vault.example.com"
export VAULT_TOKEN="<vault-token>"
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4 |
| <a name="requirement_authentik"></a> [authentik](#requirement\_authentik) | ~> 2025.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_authentik"></a> [authentik](#provider\_authentik) | 2025.12.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [authentik_application.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/application) | resource |
| [authentik_property_mapping_provider_scope.groups](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/property_mapping_provider_scope) | resource |
| [authentik_provider_oauth2.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/provider_oauth2) | resource |
| [random_password.client_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_kv_secret_v2.client_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [authentik_certificate_key_pair.signing](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/certificate_key_pair) | data source |
| [authentik_flow.authorization](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_flow.invalidation](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_property_mapping_provider_scope.oidc](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/property_mapping_provider_scope) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | Map of OAuth2 applications to create in Authentik. Key = application slug. client\_id defaults to slug. vault\_secret\_path — if set, writes clientSecret to Vault. | <pre>map(object({<br>    name                  = string<br>    allowed_redirect_uris = list(string)<br>    client_id             = optional(string)<br>    vault_secret_path     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_authentik_url"></a> [authentik\_url](#input\_authentik\_url) | Authentik base URL - Used to construct issuerUrl in Vault secrets. | `string` | `null` | no |
| <a name="input_authorization_flow_slug"></a> [authorization\_flow\_slug](#input\_authorization\_flow\_slug) | Slug of the Authentik authorization flow | `string` | `"default-provider-authorization-implicit-consent"` | no |
| <a name="input_invalidation_flow_slug"></a> [invalidation\_flow\_slug](#input\_invalidation\_flow\_slug) | Slug of the Authentik invalidation flow | `string` | `"default-provider-invalidation-flow"` | no |
| <a name="input_signing_key_name"></a> [signing\_key\_name](#input\_signing\_key\_name) | Name of the Authentik certificate key pair used for RS256 JWT signing | `string` | `"authentik Self-signed Certificate"` | no |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault server address | `string` | n/a | yes |
| <a name="input_vault_enabled"></a> [vault\_enabled](#input\_vault\_enabled) | Enable Vault integration for storing OAuth2 app secrets | `bool` | `false` | no |
| <a name="input_vault_mount_path"></a> [vault\_mount\_path](#input\_vault\_mount\_path) | Vault KV v2 mount point | `string` | `"secret"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apps"></a> [apps](#output\_apps) | Map of created apps with their OIDC metadata |
| <a name="output_client_secrets"></a> [client\_secrets](#output\_client\_secrets) | Map of client secrets per app slug (sensitive) |
| <a name="output_vault_secret_urls"></a> [vault\_secret\_urls](#output\_vault\_secret\_urls) | Vault UI URLs for app secrets (only for apps with vault\_secret\_path set) |
<!-- END_TF_DOCS -->
