variable "proxmox_endpoint" {
  description = "Proxmox endpoint"
  default     = ""
  type        = string
}

variable "roles" {
  description = "List of roles with privileges. Built-in roles are not allowed."
  default     = []
  type = list(object({
    name       = string
    privileges = list(string)
  }))

  validation {
    condition = alltrue([
      for role in var.roles : !contains([
        "Administrator", "NoAccess", "PVEAdmin", "PVEAuditor",
        "PVEDatastoreAdmin", "PVEDatastoreUser", "PVEMappingAdmin",
        "PVEMappingUser", "PVEPoolAdmin", "PVEPoolUser", "PVESDNAdmin",
        "PVESDNUser", "PVESysAdmin", "PVETemplateUser", "PVEUserAdmin",
        "PVEVMAdmin", "PVEVMUser"
      ], role.name)
    ])
    error_message = "Built-in Proxmox roles cannot be used as custom role names."
  }
}

variable "users" {
  description = "List of users to create with their role and optional token name"
  type = list(object({
    name       = string
    role       = string
    token_name = optional(string)
  }))
}
