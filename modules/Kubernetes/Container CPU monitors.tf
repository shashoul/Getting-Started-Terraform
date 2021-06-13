######### All CPU Resources ###########
resource "datadog_monitor" "Containers_CPU_Usage" {
  for_each           = var.containerCPU_services
  name               = "Terraform - Kubernetes Containers - CPU Usage is high on container: {{kube_container_name.name}}"
  type               = "query alert"
  message            = "CPU Usage is high for the selected service!!! This can include all auth-control services ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_30m):avg:kubernetes.${each.value["framework"]}.usage.total{*} by {kube_container_name} > ${each.value["kubernetes_cpu_usage_critical"]}"


  thresholds = {
    warning           = each.value["kubernetes_cpu_usage_warning"]
    critical          = each.value["kubernetes_cpu_usage_critical"]
    critical_recovery = each.value["kubernetes_cpu_usage_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 60
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}