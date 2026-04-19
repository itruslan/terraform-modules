resource "yandex_cm_certificate" "cert" {
  folder_id   = var.folder_id
  name        = var.name
  domains     = var.domains
  description = var.description

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = var.challenge_count
  }

  deletion_protection = var.protection
}

resource "cloudflare_dns_record" "dns_record" {
  count = yandex_cm_certificate.cert.managed[0].challenge_count

  comment = "Yandex CM ACME (Terraform yc-cm)"
  zone_id = var.zone_id
  name    = yandex_cm_certificate.cert.challenges[count.index].dns_name
  content = yandex_cm_certificate.cert.challenges[count.index].dns_value
  type    = yandex_cm_certificate.cert.challenges[count.index].dns_type
  ttl     = var.dns_ttl
}
