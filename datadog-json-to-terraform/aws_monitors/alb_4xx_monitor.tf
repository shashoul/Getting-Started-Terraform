resource "datadog_monitor" "alb_4xx_monitor_monitor" {

  name                = "Terraform - AWS ALB - 4XX Error Rate is High"
  type                = "query alert"
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
  message             = <<EOF
Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
  tags                = ["Ring1", ]
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
    critical = 50
    warning  = 30
  }
  priority = 1
}