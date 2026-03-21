resource "yandex_resourcemanager_folder" "folder" {
  cloud_id    = var.cloud_id
  name        = var.name
  description = var.description
  labels      = var.labels
}
