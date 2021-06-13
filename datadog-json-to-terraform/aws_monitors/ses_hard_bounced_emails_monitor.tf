resource "datadog_monitor" "ses_hard_bounced_emails_monitor" {

  name                = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
  type                = "query alert"
  query               = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt
 
Summary:P3 - {{value}} Hard Bounced Emails 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Hard Bounced Emails
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
    critical = 5
  }
  priority = 3
}