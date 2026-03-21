terraform {
  required_version = "~> 1.9"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "proxmox" {
  endpoint = length(var.proxmox_endpoint) > 0 ? var.proxmox_endpoint : null
  ssh {
    agent = true
  }
}
