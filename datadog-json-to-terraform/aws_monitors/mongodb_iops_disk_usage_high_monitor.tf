resource "datadog_monitor" "mongodb_iops_disk_usage_high_monitor" {

  name                = "MongoDB - Avg of IOPS Disk Usage is High"
  type                = "query alert"
  query               = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
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
    critical = 50
    warning  = 30
  }
  priority = 3
}