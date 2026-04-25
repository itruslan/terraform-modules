locals {
  all_usernames = toset(flatten([
    for group in values(var.groups) : group.users
  ]))
}

data "authentik_user" "users" {
  for_each = local.all_usernames
  username = each.key
}

resource "authentik_group" "groups" {
  for_each = var.groups
  name     = each.key
  users = [
    for u in each.value.users : data.authentik_user.users[u].id
  ]
}
