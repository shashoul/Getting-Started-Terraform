resource "datadog_monitor" "k8s_memory_high_usage_pod_monitor" {

  name                = "Kubernetes -  Memory Usage is high on Pod"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
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
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3
    warning           = 2
    critical_recovery = 2
  }
  priority = 3
}