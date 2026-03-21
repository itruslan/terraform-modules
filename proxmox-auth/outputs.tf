output "proxmox_users" {
  description = "Credentials for Proxmox users"
  sensitive   = true
  value = { for user, resource in proxmox_virtual_environment_user.user :
    user => {
      user_id  = resource.user_id
      password = resource.password
      token_id = proxmox_virtual_environment_user_token.token[user].id
      token    = replace(proxmox_virtual_environment_user_token.token[user].value, "${proxmox_virtual_environment_user_token.token[user].id}=", "")
    }
  }
}
