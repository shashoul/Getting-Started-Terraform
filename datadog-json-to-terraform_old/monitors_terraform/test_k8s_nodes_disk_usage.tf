resource "datadog_monitor" "k8s_nodes_disk_usage_monitor" {

  name                = "Shady Terraform Test... - Kubernetes Nodes - Disk Usage has been exceeded"
  type                = "query alert"
  query               = "avg(last_30m):avg:kubernetes.filesystem.usage_pct{*} > 0.00053"
  message             = "@slack-cloud-alerts-dev-test"
  tags                = []
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.00053
    warning           = 0.0005
    critical_recovery = 0.00049
  }
  priority = null
}