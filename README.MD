<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.21.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.21.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.11.0 |
| <a name="requirement_kubernetes-alpha"></a> [kubernetes-alpha](#requirement\_kubernetes-alpha) | 0.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_authservice-oidc"></a> [authservice-oidc](#module\_authservice-oidc) | ../../auth | n/a |
| <a name="module_instances_external_dns"></a> [instances\_external\_dns](#module\_instances\_external\_dns) | ../../external-dns | n/a |
| <a name="module_istio"></a> [istio](#module\_istio) | ../../istio | n/a |
| <a name="module_istio_system_external_dns"></a> [istio\_system\_external\_dns](#module\_istio\_system\_external\_dns) | ../../external-dns | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ../../prometheus-grafana | n/a |
| <a name="module_system_external_dns"></a> [system\_external\_dns](#module\_system\_external\_dns) | ../../external-dns | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.grafana](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/config_map) | resource |
| [kubernetes_namespace.front_office](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.instances](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.istio-system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.monitoring_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_secret.oidc](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/secret) | resource |
| [kubernetes_storage_class.ssd_wait](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/storage_class) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authservice_client_id"></a> [authservice\_client\_id](#input\_authservice\_client\_id) | oidc service client id | `string` | n/a | yes |
| <a name="input_authservice_client_secret"></a> [authservice\_client\_secret](#input\_authservice\_client\_secret) | oidc client secret | `string` | n/a | yes |
| <a name="input_authservice_issuer"></a> [authservice\_issuer](#input\_authservice\_issuer) | oidc issuer | `string` | n/a | yes |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The DNS name associated to your dns zone. | `string` | n/a | yes |
| <a name="input_external_dns_additional_args"></a> [external\_dns\_additional\_args](#input\_external\_dns\_additional\_args) | Additionals external DNS arguments. | `list(string)` | `[]` | no |
| <a name="input_external_dns_sa_annotations"></a> [external\_dns\_sa\_annotations](#input\_external\_dns\_sa\_annotations) | A map of string to add as annotations. | `map(string)` | `{}` | no |
| <a name="input_front_office_namespace"></a> [front\_office\_namespace](#input\_front\_office\_namespace) | flowmanager front office's namespace | `string` | `"flowmanager-fo"` | no |
| <a name="input_grafana_dashboards_folder_path"></a> [grafana\_dashboards\_folder\_path](#input\_grafana\_dashboards\_folder\_path) | Path to folder containing grafana dashboard json | `string` | n/a | yes |
| <a name="input_instances_namespace"></a> [instances\_namespace](#input\_instances\_namespace) | instance's namespace | `string` | `"instances"` | no |
| <a name="input_istio-system_namespace"></a> [istio-system\_namespace](#input\_istio-system\_namespace) | istio system's namespace | `string` | `"istio-system"` | no |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | Kubernetes cluster name | `string` | n/a | yes |
| <a name="input_monitoring_system_namespace"></a> [monitoring\_system\_namespace](#input\_monitoring\_system\_namespace) | Name of the namespace used to host monitoring tools (Grafana, Prometheus) | `string` | `"monitoring-system"` | no |
| <a name="input_oidc_secret_ref"></a> [oidc\_secret\_ref](#input\_oidc\_secret\_ref) | Kubernetes secret reference, for sensitives nifi properties | <pre>object({<br>    namespace = string<br>    name      = string<br>    data      = string<br>  })</pre> | <pre>{<br>  "data": "",<br>  "name": "",<br>  "namespace": ""<br>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | GCP project name | `string` | n/a | yes |
| <a name="input_ssd_storage_class_name"></a> [ssd\_storage\_class\_name](#input\_ssd\_storage\_class\_name) | ssd\_storage\_class\_name | `string` | `"ssd-wait"` | no |
| <a name="input_ssd_storage_provisioner"></a> [ssd\_storage\_provisioner](#input\_ssd\_storage\_provisioner) | ssd storage class provisioner | `string` | n/a | yes |
| <a name="input_system_namespace"></a> [system\_namespace](#input\_system\_namespace) | system's namespace | `string` | `"system"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_class_name"></a> [storage\_class\_name](#output\_storage\_class\_name) | SSD wait storage class name |
<!-- END_TF_DOCS -->