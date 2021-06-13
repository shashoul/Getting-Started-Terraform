resource "datadog_monitor" "aws_alb_monitor" {

  name                = "Shady Terraform Test !!! - AWS ALB - High Avg Response time on Load Balancer (over 250ms)"
  type                = "query alert"
  query               = "avg(last_1h):avg:aws.applicationelb.target_response_time.average{*} > 0.35"
  message             = ""
  tags                = []
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.35
    warning           = 0.25
    critical_recovery = 0.21
  }
  priority = null
}