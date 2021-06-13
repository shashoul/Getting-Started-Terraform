resource "datadog_monitor" "mongodb_inefficient_queries_high_monitor" {

  name                = "MongoDB - Number of Inefficient Queries is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
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
    critical = 1.5
    warning  = 1.2
  }
  priority = 2
}