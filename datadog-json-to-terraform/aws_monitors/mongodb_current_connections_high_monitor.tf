resource "datadog_monitor" "mongodb_current_connections_high_monitor" {

  name                = "MongoDB - Number of Current Connections is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
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
  include_tags        = false
  monitor_thresholds {
    critical = 75
    warning  = 65
  }
  priority = 3
}