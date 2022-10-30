variable "monitoring_system_namespace" {
  description = "Name of the namespace used to host monitoring tools (Grafana, Prometheus)"
  type        = string
  default     = "monitoring-system"
}

variable "grafana_dashboards_folder_path" {
  description = "Path to folder containing grafana dashboard json"
  type        = string
}