variable "cloud_id" {
  description = "Yandex Cloud ID. Falls back to YC_CLOUD_ID env var."
  type        = string
  default     = ""
}

variable "name" {
  description = "Folder name."
  type        = string
}

variable "description" {
  description = "Folder description."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Resource labels as key-value pairs."
  type        = map(string)
  default     = {}
}
