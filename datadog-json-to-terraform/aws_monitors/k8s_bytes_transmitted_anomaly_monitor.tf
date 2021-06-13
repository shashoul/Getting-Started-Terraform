resource "datadog_monitor" "k8s_bytes_transmitted_anomaly_monitor" {

  name                = "Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
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
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  priority = 4
}