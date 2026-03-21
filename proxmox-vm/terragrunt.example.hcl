include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//proxmox-vm?ref=main"
}

inputs = {
  name = "k8s"

  vm_list = [
    {
      name_suffix  = "master-1"
      node_name    = "pve-1"
      vm_id        = 201
      ipv4_address = "192.168.10.201/24"
    },
    {
      name_suffix  = "worker-1"
      node_name    = "pve-2"
      vm_id        = 211
      ipv4_address = "192.168.10.211/24"
    },
  ]

  cpu    = 4
  memory = 8

  main_disk_storage = "local-lvm"
  main_disk_size    = 50

  clone = {
    vm_id     = 9001
    node_name = "pve-1"
  }

  initialization = {
    username     = "ubuntu"
    ssh_keys     = ["ssh-ed25519 AAAA... user@host"]
    ipv4_gateway = "192.168.10.1"
    dns_servers  = ["192.168.99.1", "8.8.8.8"]
    dns_domain   = "home.lab"
  }

  tags = ["k8s", "homelab"]
}
