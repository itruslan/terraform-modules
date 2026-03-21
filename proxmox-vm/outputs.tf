output "virtual_machines" {
  description = "List of Virtual Machines"
  value = { for vm, resource in proxmox_virtual_environment_vm.vm :
    resource.name => {
      hostname   = "${resource.name}.${try(resource.initialization[0].dns[0].domain, "local")}"
      vm_id      = resource.vm_id
      ip_address = split("/", try(resource.initialization[0].ip_config[0].ipv4[0].address, "127.0.0.1/32"))[0]
      pve_node   = resource.node_name
    }
  }
}
