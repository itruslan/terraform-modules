resource "proxmox_virtual_environment_group" "this" {
  for_each = var.groups

  group_id = each.key
  comment  = each.value.comment
}

resource "proxmox_virtual_environment_acl" "this" {
  for_each = {
    for item in flatten([
      for group_id, group in var.groups : [
        for acl in group.acls : {
          key       = "${group_id}:${acl.path}"
          group_id  = group_id
          path      = acl.path
          role_id   = acl.role
          propagate = acl.propagate
        }
      ]
    ]) : item.key => item
  }

  group_id  = each.value.group_id
  path      = each.value.path
  role_id   = each.value.role_id
  propagate = each.value.propagate

  depends_on = [proxmox_virtual_environment_group.this]
}

resource "proxmox_virtual_environment_user" "this" {
  for_each = var.users

  user_id = "${each.key}@${each.value.realm}"
  comment = each.value.comment
  enabled = each.value.enabled
  groups  = [for g in each.value.groups : proxmox_virtual_environment_group.this[g].group_id]

  depends_on = [proxmox_virtual_environment_group.this]
}
