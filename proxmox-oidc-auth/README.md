# proxmox-oidc-auth

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.realm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autocreate"></a> [autocreate](#input\_autocreate) | Auto-create Proxmox users on first OIDC login | `bool` | `false` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | OAuth2 client ID | `string` | n/a | yes |
| <a name="input_client_key"></a> [client\_key](#input\_client\_key) | OAuth2 client secret | `string` | n/a | yes |
| <a name="input_comment"></a> [comment](#input\_comment) | Human-readable description of the realm | `string` | `"Authentik OIDC"` | no |
| <a name="input_default_realm"></a> [default\_realm](#input\_default\_realm) | Make this the default realm on the login page | `bool` | `false` | no |
| <a name="input_issuer_url"></a> [issuer\_url](#input\_issuer\_url) | OIDC issuer URL (e.g. https://auth.example.com/application/o/proxmox/) | `string` | n/a | yes |
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Proxmox VE API endpoint | `string` | n/a | yes |
| <a name="input_realm"></a> [realm](#input\_realm) | Proxmox realm ID (short name used at login prompt) | `string` | `"authentik"` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | Space-separated list of OIDC scopes to request | `string` | `"openid profile email"` | no |
| <a name="input_username_claim"></a> [username\_claim](#input\_username\_claim) | JWT claim to use as Proxmox username | `string` | `"preferred_username"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_realm"></a> [realm](#output\_realm) | Proxmox realm ID |
<!-- END_TF_DOCS -->
