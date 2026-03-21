include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/rgadzhiev/terraform-modules.git//yc-folder?ref=main"
}

inputs = {
  name        = "homelab"
  description = "Homelab infrastructure"
}
