######### All CPU Resources ###########
resource "datadog_monitor" "NODES_CPU_Usage" {
  for_each           = var.nodesCPU_services
  name               = "Terraform - Kubernetes Nodes - CPU Total Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_1h):avg:kubernetes.${each.value["framework"]}.usage.total{*} > ${each.value["kubernetes_cpu_usage_critical"]}"


  thresholds = {
    warning           = each.value["kubernetes_cpu_usage_warning"]
    critical          = each.value["kubernetes_cpu_usage_critical"]
    critical_recovery = each.value["kubernetes_cpu_usage_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false  
}
