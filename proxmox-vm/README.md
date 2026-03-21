# proxmox-vm

Terraform module for creating Proxmox VMs (supports multiple VMs per call).

## Requirements

```bash
export PROXMOX_VE_ENDPOINT=https://pve-1.home.lab:8006
export PROXMOX_VE_API_TOKEN=terraform@pve!terraform=<token>
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.98.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acpi"></a> [acpi](#input\_acpi) | Whether to enable ACPI | `bool` | `null` | no |
| <a name="input_agent_config"></a> [agent\_config](#input\_agent\_config) | The QEMU agent configuration | <pre>object({<br/>    timeout = optional(string)<br/>    trim    = optional(bool)<br/>    type    = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_agent_enabled"></a> [agent\_enabled](#input\_agent\_enabled) | Whether to enable QEMU agent | `bool` | `null` | no |
| <a name="input_bios"></a> [bios](#input\_bios) | The BIOS implementation | `string` | `null` | no |
| <a name="input_boot_order"></a> [boot\_order](#input\_boot\_order) | Specify a list of devices to boot from in the order they appear in the list | `list(string)` | `null` | no |
| <a name="input_cdrom"></a> [cdrom](#input\_cdrom) | The CDROM configuration | <pre>object({<br/>    enabled   = optional(bool)<br/>    file_id   = optional(string)<br/>    interface = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_clone"></a> [clone](#input\_clone) | The cloning configuration | <pre>object({<br/>    vm_id        = number<br/>    datastore_id = optional(string)<br/>    node_name    = optional(string)<br/>    retries      = optional(number)<br/>    full         = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPU cores | `number` | `1` | no |
| <a name="input_cpu_config"></a> [cpu\_config](#input\_cpu\_config) | Detailed CPU configuration | <pre>object({<br/>    architecture = optional(string)<br/>    flags        = optional(list(string))<br/>    hotplugged   = optional(number)<br/>    limit        = optional(number)<br/>    numa         = optional(bool)<br/>    sockets      = optional(number)<br/>    type         = optional(string)<br/>    units        = optional(number)<br/>    affinity     = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the VM | `string` | `"Managed by Terraform"` | no |
| <a name="input_efi_disk"></a> [efi\_disk](#input\_efi\_disk) | The EFI disk configuration | <pre>object({<br/>    datastore_id      = optional(string)<br/>    file_format       = optional(string)<br/>    type              = optional(string)<br/>    pre_enrolled_keys = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_hook_script_file_id"></a> [hook\_script\_file\_id](#input\_hook\_script\_file\_id) | The identifier for a file containing a hook script | `string` | `null` | no |
| <a name="input_hostpci"></a> [hostpci](#input\_hostpci) | A host PCI device mapping (multiple blocks supported) | <pre>list(object({<br/>    device   = string<br/>    id       = optional(string)<br/>    mapping  = optional(string)<br/>    mdev     = optional(string)<br/>    pcie     = optional(bool)<br/>    rombar   = optional(bool)<br/>    rom_file = optional(string)<br/>    xvga     = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_image_file"></a> [image\_file](#input\_image\_file) | The file for a disk image | `string` | `null` | no |
| <a name="input_initialization"></a> [initialization](#input\_initialization) | The cloud-init configuration | <pre>object({<br/>    datastore_id         = optional(string)<br/>    interface            = optional(string)<br/>    dns_domain           = optional(string)<br/>    dns_servers          = optional(list(string))<br/>    ipv4_gateway         = optional(string)<br/>    ssh_keys             = optional(list(string))<br/>    password_enabled     = optional(bool, false)<br/>    username             = optional(string)<br/>    network_data_file_id = optional(string)<br/>    user_data_file_id    = optional(string)<br/>    vendor_data_file_id  = optional(string)<br/>    meta_data_file_id    = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_keyboard_layout"></a> [keyboard\_layout](#input\_keyboard\_layout) | The keyboard layout | `string` | `"en-us"` | no |
| <a name="input_kvm_arguments"></a> [kvm\_arguments](#input\_kvm\_arguments) | Arbitrary arguments passed to KVM | `string` | `null` | no |
| <a name="input_machine"></a> [machine](#input\_machine) | The VM machine type | `string` | `null` | no |
| <a name="input_main_disk_config"></a> [main\_disk\_config](#input\_main\_disk\_config) | Config for main disk | <pre>object({<br/>    interface   = optional(string, "scsi0")<br/>    file_format = optional(string, "raw")<br/>    ssd         = optional(bool)<br/>    replicate   = optional(bool)<br/>    iothread    = optional(bool)<br/>    speed = optional(object({<br/>      iops_read            = optional(number)<br/>      iops_read_burstable  = optional(number)<br/>      iops_write           = optional(number)<br/>      iops_write_burstable = optional(number)<br/>      read                 = optional(number)<br/>      read_burstable       = optional(number)<br/>      write                = optional(number)<br/>      write_burstable      = optional(number)<br/>    }))<br/>    discard = optional(string)<br/>    cache   = optional(string)<br/>    backup  = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_main_disk_size"></a> [main\_disk\_size](#input\_main\_disk\_size) | Size of the main disk in GB | `number` | `20` | no |
| <a name="input_main_disk_storage"></a> [main\_disk\_storage](#input\_main\_disk\_storage) | Storage for the main disk | `string` | `"local-lvm"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory in GB | `number` | `2` | no |
| <a name="input_memory_config"></a> [memory\_config](#input\_memory\_config) | Detailed memory configuration | <pre>object({<br/>    floating       = optional(number)<br/>    shared         = optional(number)<br/>    hugepages      = optional(string)<br/>    keep_hugepages = optional(bool)<br/>  })</pre> | `{}` | no |
| <a name="input_migrate"></a> [migrate](#input\_migrate) | Migrate the VM on node change instead of re-creating it | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Virtual machine name | `string` | n/a | yes |
| <a name="input_network_device"></a> [network\_device](#input\_network\_device) | A config for network device (multiple blocks supported) | <pre>list(object({<br/>    bridge       = optional(string, "vmbr0")<br/>    disconnected = optional(bool)<br/>    enabled      = optional(bool)<br/>    firewall     = optional(bool)<br/>    mac_address  = optional(string)<br/>    model        = optional(string)<br/>    mtu          = optional(string)<br/>    queues       = optional(string)<br/>    rate_limit   = optional(string)<br/>    vlan_id      = optional(string)<br/>    trunks       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_numa"></a> [numa](#input\_numa) | The NUMA configuration | <pre>object({<br/>    device    = string<br/>    cpus      = string<br/>    memory    = number<br/>    hostnodes = optional(list(string))<br/>    policy    = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_on_boot"></a> [on\_boot](#input\_on\_boot) | Specifies whether a VM will be started during system boot | `bool` | `null` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The Operating System configuration | <pre>object({<br/>    type = optional(string, "l26")<br/>  })</pre> | `{}` | no |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | The identifier for a pool to assign the virtual machine to | `string` | `null` | no |
| <a name="input_protection"></a> [protection](#input\_protection) | Sets the protection flag of the VM | `bool` | `null` | no |
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Proxmox endpoint | `string` | `""` | no |
| <a name="input_reboot"></a> [reboot](#input\_reboot) | Reboot the VM after initial creation | `bool` | `null` | no |
| <a name="input_scsi_hardware"></a> [scsi\_hardware](#input\_scsi\_hardware) | The SCSI hardware type | `string` | `null` | no |
| <a name="input_secondary_disks"></a> [secondary\_disks](#input\_secondary\_disks) | List of secondary disks | <pre>list(object({<br/>    size        = number<br/>    interface   = optional(string, "scsi1")<br/>    storage     = optional(string, "local-lvm")<br/>    file_format = optional(string, "raw")<br/>    ssd         = optional(bool)<br/>    replicate   = optional(bool)<br/>    iothread    = optional(bool)<br/>    speed = optional(object({<br/>      iops_read            = optional(number)<br/>      iops_read_burstable  = optional(number)<br/>      iops_write           = optional(number)<br/>      iops_write_burstable = optional(number)<br/>      read                 = optional(number)<br/>      read_burstable       = optional(number)<br/>      write                = optional(number)<br/>      write_burstable      = optional(number)<br/>    }))<br/>    discard = optional(string)<br/>    cache   = optional(string)<br/>    backup  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_serial_device"></a> [serial\_device](#input\_serial\_device) | A serial device (multiple blocks supported) | <pre>list(object({<br/>    device = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_smbios"></a> [smbios](#input\_smbios) | The SMBIOS (type1) settings for the VM | <pre>object({<br/>    family       = optional(string)<br/>    manufacturer = optional(string)<br/>    product      = optional(string)<br/>    serial       = optional(string)<br/>    sku          = optional(string)<br/>    uuid         = optional(string)<br/>    version      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_started"></a> [started](#input\_started) | Whether to start the virtual machine | `bool` | `true` | no |
| <a name="input_startup"></a> [startup](#input\_startup) | Defines startup and shutdown behavior of the VM | <pre>object({<br/>    order      = number<br/>    up_delay   = optional(number)<br/>    down_delay = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_stop_on_destroy"></a> [stop\_on\_destroy](#input\_stop\_on\_destroy) | Whether to stop rather than shutdown on VM destroy | `bool` | `true` | no |
| <a name="input_tablet_device"></a> [tablet\_device](#input\_tablet\_device) | Whether to enable the USB tablet device | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags of the VM | `list(string)` | `[]` | no |
| <a name="input_template"></a> [template](#input\_template) | Whether to create a template | `bool` | `null` | no |
| <a name="input_timeout_clone"></a> [timeout\_clone](#input\_timeout\_clone) | Timeout for cloning a VM in seconds | `number` | `null` | no |
| <a name="input_timeout_create"></a> [timeout\_create](#input\_timeout\_create) | Timeout for creating a VM in seconds | `number` | `null` | no |
| <a name="input_timeout_migrate"></a> [timeout\_migrate](#input\_timeout\_migrate) | Timeout for migrating the VM | `number` | `null` | no |
| <a name="input_timeout_reboot"></a> [timeout\_reboot](#input\_timeout\_reboot) | Timeout for rebooting a VM in seconds | `number` | `null` | no |
| <a name="input_timeout_shutdown_vm"></a> [timeout\_shutdown\_vm](#input\_timeout\_shutdown\_vm) | Timeout for shutting down a VM in seconds | `number` | `null` | no |
| <a name="input_timeout_start_vm"></a> [timeout\_start\_vm](#input\_timeout\_start\_vm) | Timeout for starting a VM in seconds | `number` | `null` | no |
| <a name="input_timeout_stop_vm"></a> [timeout\_stop\_vm](#input\_timeout\_stop\_vm) | Timeout for stopping a VM in seconds | `number` | `null` | no |
| <a name="input_tpm_state"></a> [tpm\_state](#input\_tpm\_state) | The TPM state device configuration | <pre>object({<br/>    datastore_id = optional(string)<br/>    version      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_usb"></a> [usb](#input\_usb) | A host USB device mapping (multiple blocks supported) | <pre>list(object({<br/>    host    = optional(string)<br/>    mapping = optional(string)<br/>    usb3    = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_vga"></a> [vga](#input\_vga) | The VGA configuration | <pre>object({<br/>    memory    = optional(number, 16)<br/>    type      = optional(string, "std")<br/>    clipboard = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_vm_list"></a> [vm\_list](#input\_vm\_list) | List of virtual machines | <pre>list(object({<br/>    name_suffix  = string<br/>    node_name    = string<br/>    vm_id        = number<br/>    ipv4_address = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_watchdog"></a> [watchdog](#input\_watchdog) | The watchdog configuration | <pre>object({<br/>    enabled = optional(bool, false)<br/>    model   = optional(string, "i6300esb")<br/>    action  = optional(string, "none")<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_machines"></a> [virtual\_machines](#output\_virtual\_machines) | List of Virtual Machines |
<!-- END_TF_DOCS -->
