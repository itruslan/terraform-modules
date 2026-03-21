# proxmox-auth

Terraform module for creating Proxmox users, roles, and API tokens.

Bootstrap module — run once with `root@pam` credentials, then switch to the generated token.

## Requirements

```bash
export PROXMOX_VE_ENDPOINT=https://pve-1.home.lab:8006
export PROXMOX_VE_USERNAME=root@pam
export PROXMOX_VE_PASSWORD=<root password>
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

After apply, get the token:

```bash
tg output -json proxmox_users | jq -r '.terraform.token_id + "=" + .terraform.token'
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.70 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.98.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_role.role](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_role) | resource |
| [proxmox_virtual_environment_user.user](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_user) | resource |
| [proxmox_virtual_environment_user_token.token](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_user_token) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Proxmox endpoint | `string` | `""` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | List of roles with privileges. Built-in roles are not allowed. | <pre>list(object({<br/>    name       = string<br/>    privileges = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | List of users to create with their role and optional token name | <pre>list(object({<br/>    name       = string<br/>    role       = string<br/>    token_name = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_proxmox_users"></a> [proxmox\_users](#output\_proxmox\_users) | Credentials for Proxmox users |
<!-- END_TF_DOCS -->
