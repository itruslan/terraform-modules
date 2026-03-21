include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/rgadzhiev/terraform-modules.git//k8s-argocd?ref=main"
}

inputs = {
  chart_version = "7.8.26"

  values = [
    <<-EOT
      server:
        service:
          type: ClusterIP
        ingress:
          enabled: false
    EOT
  ]
}
