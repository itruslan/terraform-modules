resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [metadata[0].annotations]
  }
}

resource "helm_release" "argocd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  values     = var.values
  timeout    = 600
  wait       = true
}

resource "kubernetes_manifest" "root_app" {
  count = var.root_app != null ? 1 : 0

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "bootstrap"
      namespace = kubernetes_namespace.argocd.metadata[0].name
    }
    spec = {
      project = var.root_app.project
      source = {
        repoURL        = var.root_app.repo_url
        targetRevision = var.root_app.target_revision
        path           = var.root_app.bootstrap_path
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = kubernetes_namespace.argocd.metadata[0].name
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }

  depends_on = [helm_release.argocd]
}

resource "kubernetes_manifest" "app_project" {
  for_each = { for p in var.app_projects : p.name => p }

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"
    metadata = {
      name      = each.value.name
      namespace = kubernetes_namespace.argocd.metadata[0].name
    }
    spec = {
      description = each.value.description
      sourceRepos = ["*"]
      destinations = concat(
        [{ server = "https://kubernetes.default.svc", namespace = "*" }],
        each.value.extra_destinations
      )
      clusterResourceWhitelist = [
        { group = "*", kind = "*" }
      ]
    }
  }

  lifecycle {
    ignore_changes = [manifest]
  }

  depends_on = [helm_release.argocd]
}

data "kubernetes_secret" "initial_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  depends_on = [helm_release.argocd]
}
