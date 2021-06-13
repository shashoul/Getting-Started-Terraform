resource "datadog_monitor" "ses_opened_emails_monitor" {

  name                = "Terraform - AWS SES - Number of Opened Emails is Low"
  type                = "query alert"
  query               = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt
 
Summary:P3 - Number of Opened Emails is Low
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:Low Number of Opened Emails
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
  no_data_timeframe   = 60
  include_tags        = false
  monitor_thresholds {
    critical = 1
  }
  priority = 3
}