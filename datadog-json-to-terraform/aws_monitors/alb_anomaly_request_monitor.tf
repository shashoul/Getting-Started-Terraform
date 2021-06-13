resource "datadog_monitor" "alb_anomaly_request_monitor" {

  name                = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4
@webhook-XiteIt 

Summary:P4 - Requests Anomaly - Number of Weekly Requests is {{value}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Number of Requests (Weekly)
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
  include_tags        = false
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  threshold_windows = {
    trigger_window  = "last_30m"
    recovery_window = "last_1h"
  }
  priority = 4
}