output "cert_id" {
  description = "Yandex Certificate Manager certificate ID (e.g. for external-secrets yandexcertificatemanager remoteRef key / ESO)."
  value       = yandex_cm_certificate.cert.id
}

output "cert_name" {
  description = "Certificate name in Yandex CM."
  value       = yandex_cm_certificate.cert.name
}

output "domains" {
  description = "Domain list on the issued certificate."
  value       = yandex_cm_certificate.cert.domains
}
