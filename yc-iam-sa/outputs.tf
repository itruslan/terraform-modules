output "sa_id" {
  description = "Service account ID."
  value       = yandex_iam_service_account.this.id
}

output "sa_name" {
  description = "Service account name."
  value       = yandex_iam_service_account.this.name
}

output "sa_key_id" {
  description = "Service account authorized key ID."
  value       = yandex_iam_service_account_key.this.id
}

output "sa_key_json" {
  description = "Service account authorized key in JSON format (for YC SDK/CLI)."
  sensitive   = true
  value = jsonencode({
    id                 = yandex_iam_service_account_key.this.id
    service_account_id = yandex_iam_service_account.this.id
    created_at         = yandex_iam_service_account_key.this.created_at
    key_algorithm      = yandex_iam_service_account_key.this.key_algorithm
    public_key         = yandex_iam_service_account_key.this.public_key
    private_key        = yandex_iam_service_account_key.this.private_key
  })
}
