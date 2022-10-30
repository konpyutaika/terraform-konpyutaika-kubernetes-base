locals {
  external_dns_args_default = concat(var.external_dns_additional_args,[
    "--source=service",
    "--source=ingress",
    "--domain-filter=${var.dns_name}",
    "--registry=txt",
    "--namespace=${kubernetes_service_account.external_dns.metadata[0].namespace}",
    "--fqdn-template={{.Name}}.${var.dns_name}",
    "--log-level=trace",
    "--txt-owner-id=gke-${var.kubernetes_cluster_name}-${kubernetes_service_account.external_dns.metadata[0].namespace}",
  ])
  external_dns_args_additional = var.watch_istio ? ["--source=istio-gateway", "--source=istio-virtualservice"] : []

  external_dns_args = concat(local.external_dns_args_default, local.external_dns_args_additional)

  cluster_role_rules_default = [
    {
      api_groups = ["", ]
      resources  = ["services", "endpoints", "pods", "nodes"]
      verbs      = ["get", "watch", "list", ]
    },
    {
      api_groups = ["extensions", ]
      resources  = ["ingresses", ]
      verbs      = ["get", "watch", "list", ]
    }
  ]

  cluster_role_rules_additional = var.watch_istio ? [
    {
      api_groups = ["networking", "extensions", "networking.k8s.io"]
      resources  = ["ingresses", ]
      verbs      = ["get", "watch", "list", ]
    },
    {
      api_groups = ["networking.istio.io"]
      resources  = ["gateways", "virtualservices"]
      verbs      = ["get", "watch", "list", ]
    }
  ] : []

  cluster_role_rules = concat(local.cluster_role_rules_default, local.cluster_role_rules_additional)
}

# Cluster role with permissions required for external dns.
resource "kubernetes_cluster_role" "external_dns" {
  metadata {
    name = "external-dns-${var.external_dns_namespace}"
  }

  dynamic "rule" {
    for_each = local.cluster_role_rules
    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}

# Create service account for external-dns
resource "kubernetes_service_account" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = var.external_dns_namespace
    annotations = var.external_dns_sa_annotations
  }
  automount_service_account_token = true
}

# Binding external-dns cluster role, with the external-dns Service account.
resource "kubernetes_cluster_role_binding" "external_dns_viewer" {
  metadata {
    name = "external-dns-viewer-${var.external_dns_namespace}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.external_dns.metadata[0].name
#    name      = kubernetes_cluster_role.external_dns.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.external_dns.metadata[0].name
    namespace = kubernetes_service_account.external_dns.metadata[0].namespace
  }
}

# Create deployment
resource "kubernetes_deployment" "external_dns" {
  metadata {
    annotations = {}
    labels = {
      "app" = "external-dns"
    }
    name      = "external-dns"
    namespace = kubernetes_service_account.external_dns.metadata[0].namespace
  }

  spec {
    selector {
      match_labels = {
        "app" = "external-dns"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        annotations = {}
        labels = {
          "app" = "external-dns"
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.external_dns.metadata[0].name
        automount_service_account_token = true
        container {
          args    = local.external_dns_args
          command = []
          image   = var.external_dns_image
          name    = "external-dns"
        }
        node_selector = var.kubernetes_node_selector
      }
    }
  }
}

resource "kubernetes_pod_security_policy" "external_dns" {
  metadata {
    name = "external-dns-${var.external_dns_namespace}"
  }
  spec {
    privileged                 = false
    allow_privilege_escalation = false

    volumes = [
      "configMap",
      "emptyDir",
      "projected",
      "secret",
      "downwardAPI",
      "hostPath",
    ]
    host_network = false
    host_ipc     = false
    host_pid     = false


    run_as_user {
      rule = "MustRunAs"
      range {
        min = 1001
        max = 1001
      }
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "MustRunAs"
      range {
        min = 1001
        max = 1001
      }
    }

    fs_group {
      rule = "MustRunAs"
      range {
        min = 1001
        max = 1001
      }
    }
    #    read_only_root_filesystem = true
  }
}

resource "kubernetes_cluster_role" "external_dns_psp" {
  metadata {
    name = "external-dns-psp-${var.external_dns_namespace}"
  }

  rule {
    api_groups     = ["extensions", ]
    resources      = ["podsecuritypolicies", ]
    verbs          = ["use", ]
    resource_names = [kubernetes_pod_security_policy.external_dns.metadata[0].name]
  }
}

# Binding external-dns cluster role, with the external-dns Service account.
resource "kubernetes_cluster_role_binding" "external_dns_psp" {
  metadata {
    name = "external-dns-psp-${var.external_dns_namespace}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.external_dns_psp.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.external_dns.metadata[0].name
    namespace = kubernetes_service_account.external_dns.metadata[0].namespace
  }
}