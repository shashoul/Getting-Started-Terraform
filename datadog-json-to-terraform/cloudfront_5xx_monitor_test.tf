resource "datadog_monitor" "cloudfront_5xx_monitor_test" {

  name                = "Cloudfront - 5XX Error Rate is High"
  type                = "query alert"
  query               = "avg(last_1h):avg:aws.cloudfront.5xx_error_rate{*} > 50"
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