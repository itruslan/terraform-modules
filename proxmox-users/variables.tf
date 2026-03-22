variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint"
  type        = string
}

variable "groups" {
  description = "Map of groups to create. Key = group ID."
  type = map(object({
    comment = optional(string)
    acls = optional(list(object({
      path      = string
      role      = string
      propagate = optional(bool, true)
    })), [])
  }))
  default = {}
}

variable "users" {
  description = "Map of users to pre-create. Key = username (without realm). Realm must match the OIDC realm ID."
  type = map(object({
    realm   = string
    groups  = optional(list(string), [])
    comment = optional(string)
    enabled = optional(bool, true)
  }))
  default = {}
}
