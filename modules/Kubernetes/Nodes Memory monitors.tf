######### All Memory Resources ###########
resource "datadog_monitor" "NODES_MEM_Usage" {
  for_each           = var.nodesMemory_services
  name               = "Terraform - Kubernetes Nodes - Memory Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_30m):avg:kubernetes.${each.value["framework"]}.usage{*} > ${each.value["kubernetes_memory_usage_critical"]}"


  thresholds = {
    warning           = each.value["kubernetes_memory_usage_warning"]
    critical          = each.value["kubernetes_memory_usage_critical"]
    critical_recovery = each.value["kubernetes_memory_usage_recovery"]
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