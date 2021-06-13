resource "datadog_monitor" "mongodb_process_memory_usage_high_monitor" {

  name                = "MongoDB - Process Memory Usage is high"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
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
    critical = 2050
    warning  = 1840
  }
  priority = 2
}