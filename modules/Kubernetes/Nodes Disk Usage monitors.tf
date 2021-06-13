resource "datadog_monitor" "Nodes_DiskUsage" {
  for_each           = var.diskUsage_services
  name               = "Terraform - Kubernetes Nodes - Disk Usage has been exceeded"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_30m):avg:kubernetes.${each.value["framework"]}.usage_pct{*} > ${each.value["kubernetes_diskUsage_critical"]}"


  thresholds = {
    warning           = each.value["kubernetes_diskUsage_warning"]
    critical          = each.value["kubernetes_diskUsage_critical"]
    critical_recovery = each.value["kubernetes_diskUsage_recovery"]
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