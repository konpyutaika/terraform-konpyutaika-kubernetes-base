locals {
  dirs = distinct([for dir in fileset(var.grafana_dashboards_folder_path, "*/*") : dirname(dir)])

  configmaps = {
    for dir in local.dirs : dir => {
      for f in fileset("${var.grafana_dashboards_folder_path}/${dir}", "*") : f => file("${var.grafana_dashboards_folder_path}/${dir}/${f}")
    }
  }

  prometheus_release_name = "prometheus"
}


resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    annotations = {
      name  = var.monitoring_system_namespace
    }
    labels = {
      istio-injection = "disabled"
      istio-operator-managed = "Reconcile"
    }
    name = var.monitoring_system_namespace
  }
}

resource "kubernetes_config_map" "grafana" {
  for_each = local.configmaps
  metadata {
    name      = each.key
    namespace = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }
  data = tomap(each.value)

  depends_on = [
    kubernetes_namespace.monitoring_namespace
  ]
}


module "monitoring" {
  source                      = "../../prometheus-grafana"
  monitoring_namespace        = kubernetes_namespace.monitoring_namespace.metadata[0].name
  create_monitoring_namespace = false

  grafana_svc_annotations = {
    "cloud.google.com/load-balancer-type" = "Internal"
  }

  grafana_service_type = "LoadBalancer"
  grafana_svc_port     = 80
  grafana_configmaps   = local.configmaps

  pod_monitor_match_label_selector = {
    release = local.prometheus_release_name
  }
  prometheus_operator_release_name       = local.prometheus_release_name
  prometheus_resource_log_level          = "debug"
  prometheus_operator_log_level          = "debug"
  prometheus_operator_watched_namespaces = [kubernetes_namespace.system.metadata[0].name, kubernetes_namespace.instances.metadata[0].name]
#  prometheus_stack_config = {
#    "prometheus.prometheusSpec.nodeSelector.node_pool" = "nifi-common-pool"
#    "prometheusOperator.nodeSelector.node_pool"        = "nifi-common-pool"
#    "nodeExporter.nodeSelector.node_pool"              = "nifi-common-pool"
#    "prometheus-node-exporter.nodeSelector.node_pool"  = "nifi-common-pool"
#  }

  service_monitor_match_label_selector = {
    app = "flow-manager"
  }

#  kubernetes_node_selector = {
#    node_pool = "nifi-common-pool"
#  }

  depends_on = [
    kubernetes_namespace.monitoring_namespace
  ]
}
