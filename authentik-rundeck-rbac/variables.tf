variable "groups" {
  description = "Map of Authentik groups to create for Rundeck RBAC. Key = group name. users = list of Authentik usernames to assign."
  type = map(object({
    users = optional(list(string), [])
  }))
  default = {}
}
