# terraform-modules

Reusable Terraform modules for homelab infrastructure.

## Modules

| Module | Provider | Description |
|--------|----------|-------------|
| [yc-folder](./yc-folder) | Yandex Cloud | Create a resource manager folder |
| [mikrotik-auth](./mikrotik-auth) | MikroTik | Users and groups in RouterOS |

## Usage

Modules are referenced via Terragrunt:

```hcl
terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//mikrotik-auth?ref=v1.0.0"
}
```

See `terragrunt.example.hcl` in each module for a full example.

## Requirements

- Terraform `~> 1.9`
- Terragrunt `~> 0.99`
