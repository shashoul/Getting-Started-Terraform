resource "datadog_monitor" "k8s_bytes_transmitted_low_monitor" {

  name                = "Kubernetes Nodes - Number of bytes Transmitted is Low"
  type                = "query alert"
  query               = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
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
    critical = 10000
    warning  = 15000
  }
  priority = 3
}