resource "datadog_monitor" "alb_3xx_monitor_monitor" {

  name                = "Terraform - AWS ALB - 3XX Error Rate is High"
  type                = "query alert"
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
  message             = <<EOF
Inactive
@webhook-XiteIt 

Summary:P1 - 3XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:3XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 9
    warning  = 7
  }
  priority       = 1
  classification = "integration"
}