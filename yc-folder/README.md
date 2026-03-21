# yc-folder

Terraform module for creating a Yandex Cloud folder.

## Requirements

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=your_cloud_id
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

> **Bootstrap note:** This module provisions foundational infrastructure.
> Use local backend until your S3 state bucket exists.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.191.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.191.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_resourcemanager_folder.folder](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | Yandex Cloud ID. Falls back to YC\_CLOUD\_ID env var. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Folder description. | `string` | `""` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Resource labels as key-value pairs. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Folder name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Created folder ID. |
| <a name="output_folder_name"></a> [folder\_name](#output\_folder\_name) | Created folder name. |
<!-- END_TF_DOCS -->
