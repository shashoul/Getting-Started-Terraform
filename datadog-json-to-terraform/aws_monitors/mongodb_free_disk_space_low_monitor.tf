resource "datadog_monitor" "mongodb_free_disk_space_low_monitor" {

  name                = "MongoDB - Free Disk Space is Low"
  type                = "query alert"
  query               = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
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
    critical = 70000000000
    warning  = 80000000000
  }
  priority = 1
}