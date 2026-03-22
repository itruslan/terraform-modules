# proxmox-users

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_acl.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_acl) | resource |
| [proxmox_virtual_environment_group.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_group) | resource |
| [proxmox_virtual_environment_user.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Map of groups to create. Key = group ID. | <pre>map(object({<br/>    comment = optional(string)<br/>    acls = optional(list(object({<br/>      path      = string<br/>      role      = string<br/>      propagate = optional(bool, true)<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Proxmox VE API endpoint | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Map of users to pre-create. Key = username (without realm). Realm must match the OIDC realm ID. | <pre>map(object({<br/>    realm   = string<br/>    groups  = optional(list(string), [])<br/>    comment = optional(string)<br/>    enabled = optional(bool, true)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | Created group IDs |
| <a name="output_users"></a> [users](#output\_users) | Created user IDs |
<!-- END_TF_DOCS -->
