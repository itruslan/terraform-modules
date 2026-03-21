# k8s-argocd

Устанавливает ArgoCD в Kubernetes кластер через Helm.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 3.1.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.app_project](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.root_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.initial_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_projects"></a> [app\_projects](#input\_app\_projects) | List of ArgoCD AppProjects to create | <pre>list(object({<br/>    name        = string<br/>    description = optional(string, "")<br/>  }))</pre> | `[]` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | ArgoCD Helm chart version | `string` | n/a | yes |
| <a name="input_kubeconfig_context"></a> [kubeconfig\_context](#input\_kubeconfig\_context) | Kubeconfig context to use | `string` | `null` | no |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | Path to kubeconfig file | `string` | `"~/.kube/config"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ArgoCD namespace | `string` | `"argocd"` | no |
| <a name="input_root_app"></a> [root\_app](#input\_root\_app) | Root Application pointing to bootstrap/ in gitops repo | <pre>object({<br/>    repo_url        = string<br/>    bootstrap_path  = optional(string, "bootstrap")<br/>    target_revision = optional(string, "HEAD")<br/>    project         = optional(string, "default")<br/>  })</pre> | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | Helm chart values (list of YAML strings) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | Deployed ArgoCD Helm chart version |
| <a name="output_initial_admin_password"></a> [initial\_admin\_password](#output\_initial\_admin\_password) | ArgoCD initial admin password |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | ArgoCD namespace |
<!-- END_TF_DOCS -->
