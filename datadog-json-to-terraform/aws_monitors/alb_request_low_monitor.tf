resource "datadog_monitor" "alb_request_low_monitor" {

  name                = "Terraform - AWS ALB - Number of Requests is Low"
  type                = "query alert"
  query               = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 
Priority:P2

Summary:P2 - Number of ALB total Requests is {{value}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Requests is Low
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
  evaluation_delay    = 900
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 20
    warning  = 25
  }
  priority = 2
}