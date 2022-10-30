<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.external_dns_psp](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.external_dns_psp](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.external_dns_viewer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_deployment.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_pod_security_policy.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy) | resource |
| [kubernetes_service_account.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The DNS name associated to your dns zone. | `string` | n/a | yes |
| <a name="input_external_dns_additional_args"></a> [external\_dns\_additional\_args](#input\_external\_dns\_additional\_args) | Additionals external DNS arguments. | `list(string)` | `[]` | no |
| <a name="input_external_dns_image"></a> [external\_dns\_image](#input\_external\_dns\_image) | Docker image to use | `string` | n/a | yes |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | namespace where the external-dns will be deployed. | `string` | n/a | yes |
| <a name="input_external_dns_sa_annotations"></a> [external\_dns\_sa\_annotations](#input\_external\_dns\_sa\_annotations) | A map of string to add as annotations. | `map(string)` | `{}` | no |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | Kubernetes cluster name | `string` | n/a | yes |
| <a name="input_kubernetes_node_selector"></a> [kubernetes\_node\_selector](#input\_kubernetes\_node\_selector) | Node selector config to restrict where pod should be deployed | `map(string)` | n/a | yes |
| <a name="input_watch_istio"></a> [watch\_istio](#input\_watch\_istio) | Whether or not external dns will also watch istio resources. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->