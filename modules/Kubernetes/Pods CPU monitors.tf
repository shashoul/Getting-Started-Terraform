######### All CPU Resources ###########
resource "datadog_monitor" "PODS_CPU_Usage" {
  for_each           = var.podsCPU_services
  name               = "Terraform - Kubernetes Pods - CPU Total Usage is high on pod: {{pod_name.name}}"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_30m):avg:kubernetes.${each.value["framework"]}.usage.total{*} by {pod_name} > ${each.value["kubernetes_cpu_usage_critical"]}"


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