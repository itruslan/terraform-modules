terraform {
  required_version = "~> 1.9"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.191.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
}

provider "cloudflare" {
  api_token = length(var.api_token) > 0 ? var.api_token : null
}
