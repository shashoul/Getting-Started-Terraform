resource "datadog_monitor" "mongodb_write_operations_latency__high_monitor" {

  name                = "MongoDB - Write Operations Latency is High"
  type                = "query alert"
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
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
  evaluation_delay    = 900
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical          = 0.14
    warning           = 0.13
    critical_recovery = 0.13
  }
  priority = 2
}