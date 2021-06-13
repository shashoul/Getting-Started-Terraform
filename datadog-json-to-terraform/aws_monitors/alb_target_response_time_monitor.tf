resource "datadog_monitor" "alb_target_response_time_monitor" {

  name                = "Terraform - AWS ALB - Target Respone Time is too High"
  type                = "query alert"
  query               = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:P1 - Response Time is {{value}} on {{targetgroup}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Respone Time per Target Group
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
  no_data_timeframe   = 120
  include_tags        = true
  monitor_thresholds {
    critical = 3
    warning  = 2
  }
  priority = 1
}