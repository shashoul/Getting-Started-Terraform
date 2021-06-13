resource "datadog_monitor" "k8s_Monitor_Kubernetes_Pods_Restarting_monitor" {

  name                = "[kubernetes] Monitor Kubernetes Pods Restarting"
  type                = "query alert"
  query               = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
  message             = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["integration:kubernetes", ]
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 10
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 5
    warning  = 3
  }
  priority = null
}