resource "datadog_monitor" "k8s_bytes_received_low_monitor" {

  name                = "Kubernetes Nodes - Number of bytes received is Low"
  type                = "query alert"
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 15000
    warning  = 20000
  }
  priority = 3
}