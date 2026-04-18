# yc-iam-sa

Creates a Yandex Cloud service account, assigns folder-level IAM roles, and generates an authorized key.

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
| [yandex_iam_service_account.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account_key.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_key) | resource |
| [yandex_resourcemanager_folder_iam_member.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Service account description. | `string` | `""` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex Cloud folder ID where the service account will be created. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Resource labels as key-value pairs. | `map(string)` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | List of folder-level IAM roles to assign to the service account. | `list(string)` | `[]` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | Service account name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sa_id"></a> [sa\_id](#output\_sa\_id) | Service account ID. |
| <a name="output_sa_key_id"></a> [sa\_key\_id](#output\_sa\_key\_id) | Service account authorized key ID. |
| <a name="output_sa_key_json"></a> [sa\_key\_json](#output\_sa\_key\_json) | Service account authorized key in JSON format (for YC SDK/CLI). |
| <a name="output_sa_name"></a> [sa\_name](#output\_sa\_name) | Service account name. |
<!-- END_TF_DOCS -->
