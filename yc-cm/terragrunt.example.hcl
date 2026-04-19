include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/itruslan/terraform-modules.git//yc-cm?ref=main"
}

# Example: wildcard TLS for Teleport Application Access subdomains (same cluster name as Teleport clusterName).
inputs = {
  folder_id = "b1gxxxxxxxxxxxxxxxx"
  zone_id   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  name    = "homelab-teleport-apps-wildcard"
  domains = ["*.teleport.itruslan.ru"]

  # Optional:
  # challenge_count = 1
  # protection      = true
  # dns_ttl         = 60
}
