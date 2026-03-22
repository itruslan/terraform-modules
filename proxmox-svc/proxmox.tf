resource "random_password" "password" {
  for_each = { for user in var.users : user.name => user }

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "proxmox_virtual_environment_role" "role" {
  for_each = { for role in var.roles : role.name => role }

  role_id    = each.value.name
  privileges = each.value.privileges
}

resource "proxmox_virtual_environment_user" "user" {
  for_each = { for user in var.users : user.name => user }

  comment  = "Managed by Terraform"
  password = random_password.password[each.key].result
  user_id  = "${each.value.name}@pve"

  acl {
    path      = "/"
    propagate = true
    role_id   = each.value.role
  }
}

resource "proxmox_virtual_environment_user_token" "token" {
  for_each = { for user in var.users : user.name => user }

  comment               = "Managed by Terraform"
  token_name            = each.value.token_name != null ? each.value.token_name : each.value.name
  user_id               = proxmox_virtual_environment_user.user[each.key].user_id
  privileges_separation = false
}
