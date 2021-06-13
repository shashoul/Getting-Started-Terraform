resource "datadog_monitor" "ses_bounced_emails_monitor" {

  name                = "Terraform - AWS SES - Number of Bounced Emails is High"
  type                = "query alert"
  query               = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt 
Summary:P3 - {{value}} Bounced Emails on AWS SES
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:High number of Bounced Emails
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
    warning  = 3
  }
  priority = 3
}

resource "datadog_monitor" "ses_delivered_attempts_high_monitor" {

  name                = "Terraform - AWS SES - Number of Delivery Attempts is High"
  type                = "query alert"
  query               = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt 
Summary:P3 - Number of Delivery Attempts is High
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Delivery Attempts
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

resource "datadog_monitor" "ses_delivered_emails_low_monitor" {

  name                = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
  type                = "query alert"
  query               = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt
 
Summary:P3 - Number of Emails Successfully Delivered to The Recipient's Server is Low
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:Low Number of Emails Successfully Delivered to The Recipient's Server
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

resource "datadog_monitor" "ses_rejected_high_monitor" {

  name                = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
  type                = "query alert"
  query               = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt
 
Summary:P3 - {{value}} Rejected Send Attempts 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Rejected Send Attempts
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

resource "datadog_monitor" "ses_spam_emails_monitor" {

  name                = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
  type                = "query alert"
  query               = "sum(last_1h):count:aws.ses.complaints{*} > 5"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt 
Summary:P3 - {{value}} Emails Signed As Spam by Their Recipients
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:High Number Emails Signed As Spam
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
    warning  = 3
  }
  priority = 3
}

resource "datadog_monitor" "ses_successfully_emails_sent_monitor" {

  name                = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
  type                = "query alert"
  query               = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
  message             = <<EOF
Priority:P2 @slack-cloud-alerts-bindid-prd

@webhook-XiteIt
 
Summary:P3 - Number of Successful Emails Sent is Low
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:Low Number of Successful Emails Sent
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

