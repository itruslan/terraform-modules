terraform {
  required_version = "~> 1.9"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.191.0"
    }
  }
}

provider "yandex" {
  cloud_id = length(var.cloud_id) > 0 ? var.cloud_id : null
}
