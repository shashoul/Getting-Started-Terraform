resource "datadog_monitor" "alb_4xx_target_monitor_monitor" {

  name                = "Terraform - AWS ALB - Target 4XX Error Rate is High"
  type                = "query alert"
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Summary:P1 - 4XX Error Rate is {{value}} on {{targetgroup}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["targetgroup", ]
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
  include_tags        = true
  monitor_thresholds {
    critical = 10
    warning  = 6
  }
  priority = 1
}