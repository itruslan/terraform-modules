variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Kubeconfig context to use"
  type        = string
  default     = null
}

variable "namespace" {
  description = "ArgoCD namespace"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "ArgoCD Helm chart version"
  type        = string
}

variable "values" {
  description = "Helm chart values (list of YAML strings)"
  type        = list(string)
  default     = []
}

variable "root_app" {
  description = "Root Application pointing to bootstrap/ in gitops repo"
  type = object({
    repo_url        = string
    bootstrap_path  = optional(string, "bootstrap")
    target_revision = optional(string, "HEAD")
    project         = optional(string, "default")
  })
  default = null
}

variable "app_projects" {
  description = "List of ArgoCD AppProjects to create"
  type = list(object({
    name        = string
    description = optional(string, "")
    extra_destinations = optional(list(object({
      name      = optional(string)
      server    = optional(string)
      namespace = optional(string, "*")
    })), [])
  }))
  default = []
}
