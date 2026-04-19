# yc-cm

Creates a certificate in **Yandex Certificate Manager** and completes ACME **DNS** validation by creating temporary challenge records in **Cloudflare**.

Typical use: wildcard for Teleport Application Access (`*.teleport.example.com`) or other managed TLS in YC CM consumed via External Secrets (`yandexcertificatemanager` provider).

## Prerequisites

- Yandex Cloud CLI auth: `YC_TOKEN` (or IAM key), folder with Certificate Manager enabled.
- Cloudflare API token with DNS edit on the zone (or pass `api_token`; otherwise `CLOUDFLARE_API_TOKEN`).
- Cloudflare **zone ID** for the apex domain (e.g. `itruslan.ru`), not the subdomain-only zone.

## Example: `*.teleport.itruslan.ru`

Teleport serves apps at `<app>.teleport.<cluster>`; with `clusterName: teleport.itruslan.ru` you need TLS for names like `kvm.teleport.itruslan.ru`. Issue a dedicated wildcard in Yandex CM:

```hcl
inputs = {
  folder_id = "b1gxxxxxxxxxxxxxxxx"
  zone_id   = "<cloudflare_zone_id_for_itruslan_ru>"
  name      = "homelab-teleport-apps-wildcard"
  domains   = ["*.teleport.itruslan.ru"]
}
```

Then wire `cert_id` from Terraform outputs into External Secrets (`remoteRef.key` for Yandex CM) or reference the certificate ID in Kubernetes integrations.

## Terragrunt

See [`terragrunt.example.hcl`](./terragrunt.example.hcl).

```hcl
terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//yc-cm?ref=main"
}
```

## Inputs (summary)

| Name | Description |
|------|-------------|
| `folder_id` | Yandex folder ID |
| `name` | Certificate name in Yandex CM |
| `domains` | List of FQDNs (e.g. wildcard) |
| `zone_id` | Cloudflare zone ID |
| `challenge_count` | ACME challenges (default `1`) |
| `api_token` | Optional; else env `CLOUDFLARE_API_TOKEN` |
| `protection` | Yandex CM deletion protection (default `true`) |

## Outputs

| Name | Description |
|------|-------------|
| `cert_id` | Certificate ID in Yandex CM |
| `cert_name` | Resource name |
| `domains` | Domain list on the certificate |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.191.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.18.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.191.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.dns_record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [yandex_cm_certificate.cert](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cm_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | Cloudflare API token. If empty, the provider uses the CLOUDFLARE\_API\_TOKEN environment variable. | `string` | `""` | no |
| <a name="input_challenge_count"></a> [challenge\_count](#input\_challenge\_count) | Number of ACME DNS challenges (Yandex CM). Wildcard often uses 1; increase if validation requires more. | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | Description on the Yandex CM certificate. | `string` | `"Managed by Terraform (terraform-modules/yc-cm)"` | no |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | TTL (seconds) for ACME challenge DNS records in Cloudflare. | `number` | `60` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of FQDNs to include (e.g. ["*.teleport.itruslan.ru"] for Teleport app subdomains). | `list(string)` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex Cloud folder ID (used for the certificate and the Yandex provider). | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the certificate in Yandex Certificate Manager. | `string` | n/a | yes |
| <a name="input_protection"></a> [protection](#input\_protection) | Enable deletion protection on the Yandex CM certificate. | `bool` | `true` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Cloudflare zone ID where ACME challenge records are created (e.g. zone for itruslan.ru). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_id"></a> [cert\_id](#output\_cert\_id) | Yandex Certificate Manager certificate ID (e.g. for external-secrets yandexcertificatemanager remoteRef key / ESO). |
| <a name="output_cert_name"></a> [cert\_name](#output\_cert\_name) | Certificate name in Yandex CM. |
| <a name="output_domains"></a> [domains](#output\_domains) | Domain list on the issued certificate. |
<!-- END_TF_DOCS -->
