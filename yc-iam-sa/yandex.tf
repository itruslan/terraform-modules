resource "yandex_iam_service_account" "this" {
  name        = var.sa_name
  description = var.description
  folder_id   = var.folder_id
  labels      = var.labels
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  for_each  = toset(var.roles)
  folder_id = var.folder_id
  role      = each.value
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_iam_service_account_key" "this" {
  service_account_id = yandex_iam_service_account.this.id
  key_algorithm      = "RSA_2048"
}
