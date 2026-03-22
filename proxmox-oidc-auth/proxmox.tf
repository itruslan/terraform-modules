locals {
  realm_params = join("&", [
    "realm=${urlencode(var.realm)}",
    "type=openid",
    "issuer-url=${urlencode(var.issuer_url)}",
    "client-id=${urlencode(var.client_id)}",
    "client-key=${urlencode(var.client_key)}",
    "username-claim=${urlencode(var.username_claim)}",
    "scopes=${urlencode(var.scopes)}",
    "autocreate=${var.autocreate ? 1 : 0}",
    "default=${var.default_realm ? 1 : 0}",
    "comment=${urlencode(var.comment)}",
  ])

  realm_update_params = join("&", [
    "issuer-url=${urlencode(var.issuer_url)}",
    "client-id=${urlencode(var.client_id)}",
    "client-key=${urlencode(var.client_key)}",
    "username-claim=${urlencode(var.username_claim)}",
    "scopes=${urlencode(var.scopes)}",
    "autocreate=${var.autocreate ? 1 : 0}",
    "default=${var.default_realm ? 1 : 0}",
    "comment=${urlencode(var.comment)}",
  ])
}

resource "null_resource" "realm" {
  triggers = {
    realm          = var.realm
    endpoint       = var.proxmox_endpoint
    issuer_url     = var.issuer_url
    client_id      = var.client_id
    client_key     = sha256(var.client_key)
    username_claim = var.username_claim
    scopes         = var.scopes
    autocreate     = tostring(var.autocreate)
    default_realm  = tostring(var.default_realm)
  }

  provisioner "local-exec" {
    command = <<-EOT
      STATUS=$(curl -sk -o /dev/null -w "%%{http_code}" \
        -H "Authorization: PVEAPIToken=$PROXMOX_VE_API_TOKEN" \
        "${var.proxmox_endpoint}/api2/json/access/domains/${var.realm}")

      if [ "$STATUS" = "200" ]; then
        curl -sf -k -X PUT \
          -H "Authorization: PVEAPIToken=$PROXMOX_VE_API_TOKEN" \
          -d "${local.realm_update_params}" \
          "${var.proxmox_endpoint}/api2/json/access/domains/${var.realm}"
      else
        curl -sf -k -X POST \
          -H "Authorization: PVEAPIToken=$PROXMOX_VE_API_TOKEN" \
          -d "${local.realm_params}" \
          "${var.proxmox_endpoint}/api2/json/access/domains"
      fi
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
      curl -sf -k -X DELETE \
        -H "Authorization: PVEAPIToken=$PROXMOX_VE_API_TOKEN" \
        "${self.triggers.endpoint}/api2/json/access/domains/${self.triggers.realm}"
    EOT
  }
}
