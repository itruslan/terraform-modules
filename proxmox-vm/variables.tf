variable "proxmox_endpoint" {
  description = "Proxmox endpoint"
  default     = ""
  type        = string
}

variable "name" {
  description = "Virtual machine name"
  type        = string
}

variable "vm_list" {
  description = "List of virtual machines"
  default     = []
  type = list(object({
    name_suffix  = string
    node_name    = string
    vm_id        = number
    ipv4_address = optional(string)
  }))
}

variable "cpu" {
  description = "Number of CPU cores"
  default     = 1
  type        = number
}

variable "cpu_config" {
  description = "Detailed CPU configuration"
  default     = {}
  type = object({
    architecture = optional(string)
    flags        = optional(list(string))
    hotplugged   = optional(number)
    limit        = optional(number)
    numa         = optional(bool)
    sockets      = optional(number)
    type         = optional(string)
    units        = optional(number)
    affinity     = optional(string)
  })
}

variable "memory" {
  description = "Amount of memory in GB"
  default     = 2
  type        = number
}

variable "memory_config" {
  description = "Detailed memory configuration"
  default     = {}
  type = object({
    floating       = optional(number)
    shared         = optional(number)
    hugepages      = optional(string)
    keep_hugepages = optional(bool)
  })
}

variable "main_disk_storage" {
  description = "Storage for the main disk"
  default     = "local-lvm"
  type        = string
}

variable "main_disk_size" {
  description = "Size of the main disk in GB"
  default     = 20
  type        = number
}

variable "image_file" {
  description = "The file for a disk image"
  default     = null
  type        = string
}

variable "main_disk_config" {
  description = "Config for main disk"
  default     = {}
  type = object({
    interface   = optional(string, "scsi0")
    file_format = optional(string, "raw")
    ssd         = optional(bool)
    replicate   = optional(bool)
    iothread    = optional(bool)
    speed = optional(object({
      iops_read            = optional(number)
      iops_read_burstable  = optional(number)
      iops_write           = optional(number)
      iops_write_burstable = optional(number)
      read                 = optional(number)
      read_burstable       = optional(number)
      write                = optional(number)
      write_burstable      = optional(number)
    }))
    discard = optional(string)
    cache   = optional(string)
    backup  = optional(string)
  })
}

variable "secondary_disks" {
  description = "List of secondary disks"
  default     = []
  type = list(object({
    size        = number
    interface   = optional(string, "scsi1")
    storage     = optional(string, "local-lvm")
    file_format = optional(string, "raw")
    ssd         = optional(bool)
    replicate   = optional(bool)
    iothread    = optional(bool)
    speed = optional(object({
      iops_read            = optional(number)
      iops_read_burstable  = optional(number)
      iops_write           = optional(number)
      iops_write_burstable = optional(number)
      read                 = optional(number)
      read_burstable       = optional(number)
      write                = optional(number)
      write_burstable      = optional(number)
    }))
    discard = optional(string)
    cache   = optional(string)
    backup  = optional(string)
  }))
}

variable "acpi" {
  description = "Whether to enable ACPI"
  default     = null
  type        = bool
}

variable "agent_enabled" {
  description = "Whether to enable QEMU agent"
  default     = null
  type        = bool
}

variable "agent_config" {
  description = "The QEMU agent configuration"
  default     = null
  type = object({
    timeout = optional(string)
    trim    = optional(bool)
    type    = optional(string)
  })
}

variable "bios" {
  description = "The BIOS implementation"
  default     = null
  type        = string
}

variable "boot_order" {
  description = "Specify a list of devices to boot from in the order they appear in the list"
  default     = null
  type        = list(string)
}

variable "cdrom" {
  description = "The CDROM configuration"
  default     = null
  type = object({
    enabled   = optional(bool)
    file_id   = optional(string)
    interface = optional(string)
  })
}

variable "clone" {
  description = "The cloning configuration"
  default     = null
  type = object({
    vm_id        = number
    datastore_id = optional(string)
    node_name    = optional(string)
    retries      = optional(number)
    full         = optional(bool)
  })
}

variable "description" {
  description = "The description of the VM"
  default     = "Managed by Terraform"
  type        = string
}

variable "efi_disk" {
  description = "The EFI disk configuration"
  default     = null
  type = object({
    datastore_id      = optional(string)
    file_format       = optional(string)
    type              = optional(string)
    pre_enrolled_keys = optional(bool)
  })
}

variable "tpm_state" {
  description = "The TPM state device configuration"
  default     = null
  type = object({
    datastore_id = optional(string)
    version      = optional(string)
  })
}

variable "hostpci" {
  description = "A host PCI device mapping (multiple blocks supported)"
  default     = []
  type = list(object({
    device   = string
    id       = optional(string)
    mapping  = optional(string)
    mdev     = optional(string)
    pcie     = optional(bool)
    rombar   = optional(bool)
    rom_file = optional(string)
    xvga     = optional(bool)
  }))
}

variable "usb" {
  description = "A host USB device mapping (multiple blocks supported)"
  default     = []
  type = list(object({
    host    = optional(string)
    mapping = optional(string)
    usb3    = optional(bool)
  }))
}

variable "initialization" {
  description = "The cloud-init configuration"
  default     = null
  type = object({
    datastore_id         = optional(string)
    interface            = optional(string)
    dns_domain           = optional(string)
    dns_servers          = optional(list(string))
    ipv4_gateway         = optional(string)
    ssh_keys             = optional(list(string))
    password_enabled     = optional(bool, false)
    username             = optional(string)
    network_data_file_id = optional(string)
    user_data_file_id    = optional(string)
    vendor_data_file_id  = optional(string)
    meta_data_file_id    = optional(string)
  })
}

variable "keyboard_layout" {
  description = "The keyboard layout"
  default     = "en-us"
  type        = string
}

variable "kvm_arguments" {
  description = "Arbitrary arguments passed to KVM"
  default     = null
  type        = string
}

variable "machine" {
  description = "The VM machine type"
  default     = null
  type        = string
}

variable "migrate" {
  description = "Migrate the VM on node change instead of re-creating it"
  default     = false
  type        = bool
}

variable "network_device" {
  description = "A config for network device (multiple blocks supported)"
  default     = []
  type = list(object({
    bridge       = optional(string, "vmbr0")
    disconnected = optional(bool)
    enabled      = optional(bool)
    firewall     = optional(bool)
    mac_address  = optional(string)
    model        = optional(string)
    mtu          = optional(string)
    queues       = optional(string)
    rate_limit   = optional(string)
    vlan_id      = optional(string)
    trunks       = optional(string)
  }))
}

variable "numa" {
  description = "The NUMA configuration"
  default     = null
  type = object({
    device    = string
    cpus      = string
    memory    = number
    hostnodes = optional(list(string))
    policy    = optional(string)
  })
}

variable "on_boot" {
  description = "Specifies whether a VM will be started during system boot"
  default     = null
  type        = bool
}

variable "operating_system" {
  description = "The Operating System configuration"
  default     = {}
  type = object({
    type = optional(string, "l26")
  })
}

variable "pool_id" {
  description = "The identifier for a pool to assign the virtual machine to"
  default     = null
  type        = string
}

variable "protection" {
  description = "Sets the protection flag of the VM"
  default     = null
  type        = bool
}

variable "reboot" {
  description = "Reboot the VM after initial creation"
  default     = null
  type        = bool
}

variable "serial_device" {
  description = "A serial device (multiple blocks supported)"
  default     = []
  type = list(object({
    device = optional(string)
  }))
}

variable "scsi_hardware" {
  description = "The SCSI hardware type"
  default     = null
  type        = string
}

variable "smbios" {
  description = "The SMBIOS (type1) settings for the VM"
  default     = null
  type = object({
    family       = optional(string)
    manufacturer = optional(string)
    product      = optional(string)
    serial       = optional(string)
    sku          = optional(string)
    uuid         = optional(string)
    version      = optional(string)
  })
}

variable "started" {
  description = "Whether to start the virtual machine"
  default     = true
  type        = bool
}

variable "startup" {
  description = "Defines startup and shutdown behavior of the VM"
  default     = null
  type = object({
    order      = number
    up_delay   = optional(number)
    down_delay = optional(number)
  })
}

variable "tablet_device" {
  description = "Whether to enable the USB tablet device"
  default     = null
  type        = bool
}

variable "tags" {
  description = "A list of tags of the VM"
  default     = []
  type        = list(string)
}

variable "template" {
  description = "Whether to create a template"
  default     = null
  type        = bool
}

variable "stop_on_destroy" {
  description = "Whether to stop rather than shutdown on VM destroy"
  default     = true
  type        = bool
}

variable "timeout_clone" {
  description = "Timeout for cloning a VM in seconds"
  default     = null
  type        = number
}

variable "timeout_create" {
  description = "Timeout for creating a VM in seconds"
  default     = null
  type        = number
}

variable "timeout_migrate" {
  description = "Timeout for migrating the VM"
  default     = null
  type        = number
}

variable "timeout_reboot" {
  description = "Timeout for rebooting a VM in seconds"
  default     = null
  type        = number
}

variable "timeout_shutdown_vm" {
  description = "Timeout for shutting down a VM in seconds"
  default     = null
  type        = number
}

variable "timeout_start_vm" {
  description = "Timeout for starting a VM in seconds"
  default     = null
  type        = number
}

variable "timeout_stop_vm" {
  description = "Timeout for stopping a VM in seconds"
  default     = null
  type        = number
}

variable "vga" {
  description = "The VGA configuration"
  default     = {}
  type = object({
    memory    = optional(number, 16)
    type      = optional(string, "std")
    clipboard = optional(string)
  })
}

variable "hook_script_file_id" {
  description = "The identifier for a file containing a hook script"
  default     = null
  type        = string
}

variable "watchdog" {
  description = "The watchdog configuration"
  default     = null
  type = object({
    enabled = optional(bool, false)
    model   = optional(string, "i6300esb")
    action  = optional(string, "none")
  })
}
