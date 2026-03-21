# terraform-modules

Reusable Terraform modules for homelab infrastructure.

## Modules

| Module | Provider | Description |
|--------|----------|-------------|
| [yc-folder](./yc-folder) | Yandex Cloud | Create a resource manager folder |

## Usage

Modules are referenced via Terragrunt:

```hcl
terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//yc-folder?ref=main"
}
```

See `terragrunt.example.hcl` in each module for a full example.

## Requirements

- Terraform `~> 1.9`
- Terragrunt `~> 0.99`
