variable "folder_id" {
  description = "Yandex Cloud folder ID where the service account will be created."
  type        = string
}

variable "sa_name" {
  description = "Service account name."
  type        = string
}

variable "description" {
  description = "Service account description."
  type        = string
  default     = ""
}

variable "roles" {
  description = "List of folder-level IAM roles to assign to the service account."
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Resource labels as key-value pairs."
  type        = map(string)
  default     = {}
}
