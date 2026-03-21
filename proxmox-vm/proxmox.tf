locals {
  vm_tags_with_ip = {
    for vm in var.vm_list : vm.vm_id => (
      length(var.tags) > 0 ?
      concat(var.tags, ["vm", try(split("/", vm.ipv4_address)[0], "0.0.0.0")]) :
      [var.name, "vm", try(split("/", vm.ipv4_address)[0], "0.0.0.0")]
    )
  }
}

resource "random_password" "password" {
  count = var.initialization != null && try(var.initialization.password_enabled, false) ? 1 : 0

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = { for vm in var.vm_list : vm.vm_id => vm }

  node_name = each.value.node_name

  name  = "${var.name}-${each.value.name_suffix}"
  vm_id = each.value.vm_id
  tags  = local.vm_tags_with_ip[each.value.vm_id]

  acpi                = var.acpi
  bios                = var.bios
  boot_order          = var.boot_order
  description         = var.description
  hook_script_file_id = var.hook_script_file_id
  keyboard_layout     = var.keyboard_layout
  kvm_arguments       = var.kvm_arguments
  machine             = var.machine
  migrate             = var.migrate
  on_boot             = var.on_boot
  pool_id             = var.pool_id
  protection          = var.protection
  reboot              = var.reboot
  scsi_hardware       = var.scsi_hardware
  started             = var.started
  tablet_device       = var.tablet_device
  template            = var.template
  stop_on_destroy     = var.stop_on_destroy
  timeout_clone       = var.timeout_clone
  timeout_create      = var.timeout_create
  timeout_migrate     = var.timeout_migrate
  timeout_reboot      = var.timeout_reboot
  timeout_shutdown_vm = var.timeout_shutdown_vm
  timeout_start_vm    = var.timeout_start_vm
  timeout_stop_vm     = var.timeout_stop_vm

  dynamic "agent" {
    for_each = var.agent_enabled != null ? [var.agent_enabled] : []
    content {
      enabled = agent.value
      timeout = try(var.agent_config.timeout, null)
      trim    = try(var.agent_config.trim, null)
      type    = try(var.agent_config.type, null)
    }
  }

  dynamic "cdrom" {
    for_each = var.cdrom != null ? [var.cdrom] : []
    content {
      enabled   = cdrom.value.enabled
      file_id   = cdrom.value.file_id
      interface = cdrom.value.interface
    }
  }

  dynamic "clone" {
    for_each = var.clone != null ? [var.clone] : []
    content {
      datastore_id = clone.value.datastore_id
      node_name    = clone.value.node_name
      retries      = clone.value.retries
      vm_id        = clone.value.vm_id
      full         = clone.value.full
    }
  }

  cpu {
    cores        = var.cpu
    architecture = var.cpu_config.architecture
    flags        = var.cpu_config.flags
    hotplugged   = var.cpu_config.hotplugged
    limit        = var.cpu_config.limit
    numa         = var.cpu_config.numa
    sockets      = var.cpu_config.sockets
    type         = var.cpu_config.type
    units        = var.cpu_config.units
    affinity     = var.cpu_config.affinity
  }

  disk {
    datastore_id = var.main_disk_storage
    file_id      = var.image_file != null ? "local:iso/${var.image_file}" : null
    size         = var.main_disk_size
    interface    = var.main_disk_config.interface
    file_format  = var.main_disk_config.file_format
    ssd          = var.main_disk_config.ssd
    replicate    = var.main_disk_config.replicate
    iothread     = var.main_disk_config.iothread
    dynamic "speed" {
      for_each = var.main_disk_config.speed != null ? [var.main_disk_config.speed] : []
      content {
        iops_read            = speed.value.iops_read
        iops_read_burstable  = speed.value.iops_read_burstable
        iops_write           = speed.value.iops_write
        iops_write_burstable = speed.value.iops_write_burstable
        read                 = speed.value.read
        read_burstable       = speed.value.read_burstable
        write                = speed.value.write
        write_burstable      = speed.value.write_burstable
      }
    }
    discard = var.main_disk_config.discard
    cache   = var.main_disk_config.cache
    backup  = var.main_disk_config.backup
  }

  dynamic "disk" {
    for_each = var.secondary_disks
    content {
      datastore_id = disk.value.storage
      size         = disk.value.size
      interface    = disk.value.interface
      file_format  = disk.value.file_format
      ssd          = disk.value.ssd
      replicate    = disk.value.replicate
      iothread     = disk.value.iothread
      dynamic "speed" {
        for_each = disk.value.speed != null ? [disk.value.speed] : []
        content {
          iops_read            = speed.value.iops_read
          iops_read_burstable  = speed.value.iops_read_burstable
          iops_write           = speed.value.iops_write
          iops_write_burstable = speed.value.iops_write_burstable
          read                 = speed.value.read
          read_burstable       = speed.value.read_burstable
          write                = speed.value.write
          write_burstable      = speed.value.write_burstable
        }
      }
      discard = disk.value.discard
      cache   = disk.value.cache
      backup  = disk.value.backup
    }
  }

  dynamic "efi_disk" {
    for_each = var.efi_disk != null ? [var.efi_disk] : []
    content {
      datastore_id      = efi_disk.value.datastore_id
      file_format       = efi_disk.value.file_format
      type              = efi_disk.value.type
      pre_enrolled_keys = efi_disk.value.pre_enrolled_keys
    }
  }

  dynamic "tpm_state" {
    for_each = var.tpm_state != null ? [var.tpm_state] : []
    content {
      datastore_id = tpm_state.value.datastore_id
      version      = tpm_state.value.version
    }
  }

  dynamic "hostpci" {
    for_each = var.hostpci
    content {
      device   = hostpci.value.device
      id       = hostpci.value.id
      mapping  = hostpci.value.mapping
      mdev     = hostpci.value.mdev
      pcie     = hostpci.value.pcie
      rombar   = hostpci.value.rombar
      rom_file = hostpci.value.rom_file
      xvga     = hostpci.value.xvga
    }
  }

  dynamic "usb" {
    for_each = var.usb
    content {
      host    = usb.value.host
      mapping = usb.value.mapping
      usb3    = usb.value.usb3
    }
  }

  dynamic "initialization" {
    for_each = var.initialization != null ? [var.initialization] : []
    content {
      datastore_id = initialization.value.datastore_id
      interface    = initialization.value.interface

      dns {
        domain  = initialization.value.dns_domain
        servers = initialization.value.dns_servers
      }

      ip_config {
        ipv4 {
          address = each.value.ipv4_address
          gateway = initialization.value.ipv4_gateway
        }
      }

      user_account {
        keys     = initialization.value.ssh_keys
        password = var.initialization != null && var.initialization.password_enabled ? random_password.password[0].result : null
        username = initialization.value.username
      }

      network_data_file_id = initialization.value.network_data_file_id
      user_data_file_id    = initialization.value.user_data_file_id
      vendor_data_file_id  = initialization.value.vendor_data_file_id
      meta_data_file_id    = initialization.value.meta_data_file_id
    }
  }

  memory {
    dedicated      = var.memory * 1024
    floating       = var.memory_config.floating
    shared         = var.memory_config.shared
    hugepages      = var.memory_config.hugepages
    keep_hugepages = var.memory_config.keep_hugepages
  }

  dynamic "numa" {
    for_each = var.numa != null ? [var.numa] : []
    content {
      device    = numa.value.device
      cpus      = numa.value.cpus
      memory    = numa.value.memory
      hostnodes = numa.value.hostnodes
      policy    = numa.value.policy
    }
  }

  dynamic "network_device" {
    for_each = var.network_device
    content {
      bridge       = network_device.value.bridge
      disconnected = network_device.value.disconnected
      enabled      = network_device.value.enabled
      firewall     = network_device.value.firewall
      mac_address  = network_device.value.mac_address
      model        = network_device.value.model
      mtu          = network_device.value.mtu
      queues       = network_device.value.queues
      rate_limit   = network_device.value.rate_limit
      vlan_id      = network_device.value.vlan_id
      trunks       = network_device.value.trunks
    }
  }

  operating_system {
    type = var.operating_system.type
  }

  dynamic "serial_device" {
    for_each = var.serial_device
    content {
      device = serial_device.value.device
    }
  }

  dynamic "smbios" {
    for_each = var.smbios != null ? [var.smbios] : []
    content {
      family       = smbios.value.family
      manufacturer = smbios.value.manufacturer
      product      = smbios.value.product
      serial       = smbios.value.serial
      sku          = smbios.value.sku
      uuid         = smbios.value.uuid
      version      = smbios.value.version
    }
  }

  dynamic "startup" {
    for_each = var.startup != null ? [var.startup] : []
    content {
      order      = startup.value.order
      up_delay   = startup.value.up_delay
      down_delay = startup.value.down_delay
    }
  }

  dynamic "vga" {
    for_each = var.vga != null ? [var.vga] : []
    content {
      memory    = vga.value.memory
      type      = vga.value.type
      clipboard = vga.value.clipboard
    }
  }

  dynamic "watchdog" {
    for_each = var.watchdog != null ? [var.watchdog] : []
    content {
      enabled = watchdog.value.enabled
      model   = watchdog.value.model
      action  = watchdog.value.action
    }
  }

  lifecycle {
    ignore_changes = [
      network_device,
      initialization,
    ]
  }
}
