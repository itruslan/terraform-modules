# vault-user-policies

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
| [vault_identity_entity.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_entity_alias.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity_alias) | resource |
| [vault_policy.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_auth_backend.oidc](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/auth_backend) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_path"></a> [auth\_path](#input\_auth\_path) | OIDC auth backend mount path in Vault | `string` | `"oidc"` | no |
| <a name="input_policies_dir"></a> [policies\_dir](#input\_policies\_dir) | Absolute path to directory with per-user policy files (.hcl). Filename (without extension) = username = policy name. | `string` | n/a | yes |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault server address | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_entity_ids"></a> [entity\_ids](#output\_entity\_ids) | Map of username to Vault identity entity ID |
| <a name="output_policy_names"></a> [policy\_names](#output\_policy\_names) | List of created Vault policy names |
<!-- END_TF_DOCS -->
