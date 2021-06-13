resource "datadog_monitor" "k8s_cpu_high_usage_node_monitor" {

  name                = "Kubernetes -  CPU Total Usage is high on Node"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
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
    critical          = 300000000
    warning           = 250000000
    critical_recovery = 240000000
  }
  priority = 2
}