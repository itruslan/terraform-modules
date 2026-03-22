# vault-oidc-auth

Configures OIDC auth method in Vault. Accepts client credentials externally — use together with [authentik-oauth-apps](../authentik-oauth-apps).

## Requirements

```bash
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
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_jwt_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_redirect_uris"></a> [allowed\_redirect\_uris](#input\_allowed\_redirect\_uris) | Allowed redirect URIs for OIDC callback | `list(string)` | n/a | yes |
| <a name="input_auth_description"></a> [auth\_description](#input\_auth\_description) | Description for the OIDC auth backend | `string` | `"OIDC"` | no |
| <a name="input_auth_path"></a> [auth\_path](#input\_auth\_path) | OIDC auth backend mount path in Vault | `string` | `"oidc"` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | OIDC client ID | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | OIDC client secret | `string` | n/a | yes |
| <a name="input_groups_claim"></a> [groups\_claim](#input\_groups\_claim) | JWT claim to use for group membership | `string` | `"groups"` | no |
| <a name="input_issuer_url"></a> [issuer\_url](#input\_issuer\_url) | OIDC discovery URL | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | OIDC scopes to request | `list(string)` | <pre>[<br/>  "openid",<br/>  "profile",<br/>  "email",<br/>  "groups"<br/>]</pre> | no |
| <a name="input_token_max_ttl"></a> [token\_max\_ttl](#input\_token\_max\_ttl) | Max TTL for OIDC tokens (seconds) | `number` | `86400` | no |
| <a name="input_token_ttl"></a> [token\_ttl](#input\_token\_ttl) | Default TTL for OIDC tokens (seconds) | `number` | `3600` | no |
| <a name="input_user_claim"></a> [user\_claim](#input\_user\_claim) | JWT claim to use as the user identity | `string` | `"preferred_username"` | no |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault server address | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auth_backend_accessor"></a> [auth\_backend\_accessor](#output\_auth\_backend\_accessor) | OIDC auth backend accessor (used to link identity group aliases) |
| <a name="output_auth_backend_path"></a> [auth\_backend\_path](#output\_auth\_backend\_path) | OIDC auth backend mount path |
<!-- END_TF_DOCS -->
