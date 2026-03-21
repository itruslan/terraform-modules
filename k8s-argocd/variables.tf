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
