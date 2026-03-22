include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  authentik_url = "https://auth.${include.root.locals.domain}"
}

terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//authentik-github-source?ref=main"

  after_hook "patch_default_stages" {
    commands     = ["apply"]
    execute      = ["${get_terragrunt_dir()}/patch-default-stages.sh"]
    run_on_error = false
  }
}

inputs = {
  vault_address     = "https://vault.${include.root.locals.domain}"
  vault_secret_path = "authentik/github-source"
  vault_mount_path  = "secret"

  authentik_url          = local.authentik_url
  admin_github_usernames = ["your-github-username"]
}
