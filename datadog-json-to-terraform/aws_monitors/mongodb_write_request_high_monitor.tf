resource "datadog_monitor" "mongodb_write_request_high_monitor" {

  name                = "MongoDB - Number of Write Requests is High"
  type                = "query alert"
  query               = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
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
    critical = 2000
    warning  = 1500
  }
  priority = 2
}