resource "datadog_monitor" "cloudfront_4xx_monitor_test" {

  name                = "Shady Terraform Test ... Cloudfront - 4XX Error Rate is High"
  type                = "query alert"
  query               = "avg(last_1h):avg:aws.cloudfront.4xx_error_rate{environment:production} > 50"
  message             = "@slack-cloud-alerts-prd"
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 50
    warning  = 30
  }
  priority = 1
}