include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//authentik-rundeck-rbac?ref=main"
}

inputs = {
  groups = yamldecode(file("${get_original_terragrunt_dir()}/rbac.yaml")).groups
}
