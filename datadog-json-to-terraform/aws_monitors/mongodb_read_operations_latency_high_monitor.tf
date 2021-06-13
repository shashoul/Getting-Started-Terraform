resource "datadog_monitor" "mongodb_read_operations_latency_high_monitor" {

  name                = "MongoDB - Read Operations Latency is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 0.3
    warning  = 0.2
  }
  priority = 2
}