terraform {
  required_version = "~> 1.4"
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2025.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
  }
}

provider "authentik" {}

provider "vault" {
  address = var.vault_address
}
