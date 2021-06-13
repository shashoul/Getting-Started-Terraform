resource "datadog_monitor" "k8s_pod_monitor_test" {

  name                = "Shady Terraform Test ... Kubernetes -  Memory Usage is high on Pod"
  type                = "query alert"
  query               = "avg(last_1m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
  message             = "@slack-cloud-alerts-prd"
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3
    warning           = 2
    critical_recovery = 2
  }
  priority = 3
}