######### All Memory Resources ###########
resource "datadog_monitor" "PODS_Memory_Usage" {
  for_each           = var.podsMemory_services
  name               = "Terraform - Kubernetes Pods - Memory Usage is high on pod: {{pod_name.name}}"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_4h):anomalies(avg:kubernetes.${each.value["framework"]}.usage{*} by {pod_name}, 'agile', 4, direction='both', alert_window='last_30m', interval=60, count_default_zero='true', seasonality='weekly') >= ${each.value["kubernetes_memory_usage_critical"]}"
  
  thresholds = {
    critical          = each.value["kubernetes_memory_usage_critical"]
    warning           = each.value["kubernetes_memory_usage_warning"]
    critical_recovery = each.value["kubernetes_memory_usage_recovery"]
  }
  
  threshold_windows = {
    recovery_window = "last_30m"
    trigger_window = "last_30m"
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

resource "datadog_monitor" "PODS_FreeMemory_Capacity" {
  for_each           = var.podsMemory_services
  name               = "Terraform - Kubernetes Pods - Free Memory Capacity has been exceeded"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_30m):avg:kubernetes.${each.value["framework"]}.capacity{*} - avg:kubernetes.${each.value["framework"]}.usage{*} > ${each.value["kubernetes_freeMemory_capacity_critical"]}"


  thresholds = {
    warning           = each.value["kubernetes_freeMemory_capacity_warning"]
    critical          = each.value["kubernetes_freeMemory_capacity_critical"]
    critical_recovery = each.value["kubernetes_freeMemory_capacity_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 60
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}