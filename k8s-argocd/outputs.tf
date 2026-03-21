output "namespace" {
  description = "ArgoCD namespace"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "chart_version" {
  description = "Deployed ArgoCD Helm chart version"
  value       = helm_release.argocd.version
}

output "initial_admin_password" {
  description = "ArgoCD initial admin password"
  value       = data.kubernetes_secret.initial_admin.data["password"]
  sensitive   = true
}
