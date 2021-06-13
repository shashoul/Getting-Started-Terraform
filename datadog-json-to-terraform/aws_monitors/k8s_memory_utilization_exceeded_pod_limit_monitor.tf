resource "datadog_monitor" "k8s_memory_utilization_exceeded_pod_limit_monitor" {

  name                = "Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
  type                = "query alert"
  query               = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
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
    critical = 1
  }
  priority = 3
}