resource "datadog_monitor" "alb_response_time_monitor" {

  name                = "Terraform - AWS ALB - Average Response Time is High per API Resource"
  type                = "metric alert"
  query               = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
  message             = <<EOF
@slack-cloud-alerts-dev-test
Priority:P1
@webhook-XiteIt 

Summary:P2 - Average Response Time is {{value}} on {{ingress.k8s.aws/resource}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Average Response Time per API Resource
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
  include_tags        = true
  monitor_thresholds {
    critical = 0.5
    warning  = 0.3
  }
  priority = 2
}