variable "folder_id" {
  description = "Yandex Cloud folder ID (used for the certificate and the Yandex provider)."
  type        = string
}

variable "name" {
  description = "Name of the certificate in Yandex Certificate Manager."
  type        = string
}

variable "domains" {
  description = "List of FQDNs to include (e.g. [\"*.teleport.itruslan.ru\"] for Teleport app subdomains)."
  type        = list(string)
}

variable "description" {
  description = "Description on the Yandex CM certificate."
  type        = string
  default     = "Managed by Terraform (terraform-modules/yc-cm)"
}

variable "protection" {
  description = "Enable deletion protection on the Yandex CM certificate."
  type        = bool
  default     = true
}

variable "challenge_count" {
  description = "Number of ACME DNS challenges (Yandex CM). Wildcard often uses 1; increase if validation requires more."
  type        = number
  default     = 1
}

variable "zone_id" {
  description = "Cloudflare zone ID where ACME challenge records are created (e.g. zone for itruslan.ru)."
  type        = string
}

variable "api_token" {
  description = "Cloudflare API token. If empty, the provider uses the CLOUDFLARE_API_TOKEN environment variable."
  type        = string
  default     = ""
  sensitive   = true
}

variable "dns_ttl" {
  description = "TTL (seconds) for ACME challenge DNS records in Cloudflare."
  type        = number
  default     = 60
}
