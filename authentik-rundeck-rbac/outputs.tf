output "groups" {
  description = "Map of created Authentik groups. Key = group name."
  value = {
    for k, v in authentik_group.groups : k => {
      id   = v.id
      name = v.name
    }
  }
}
