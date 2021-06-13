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
  priority = 1
  # classification = "integration"
}

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

resource "datadog_monitor" "alb_4xx_target_monitor_monitor" {

  name                = "Terraform - AWS ALB - Target 4XX Error Rate is High"
  type                = "query alert"
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Summary:P1 - 4XX Error Rate is {{value}} on {{targetgroup}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["targetgroup", ]
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
    critical = 10
    warning  = 6
  }
  priority = 1
}

resource "datadog_monitor" "alb_5xx_monitor_monitor" {

  name                = "Terraform - AWS ALB - 5XX Error Rate is High"
  type                = "query alert"
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
  message             = <<EOF
Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
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
    critical = 5
  }
  priority = 1
}

resource "datadog_monitor" "alb_anomaly_request_monitor" {

  name                = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4
@webhook-XiteIt 

Summary:P4 - Requests Anomaly - Number of Weekly Requests is {{value}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Number of Requests (Weekly)
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
  include_tags        = false
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  threshold_windows = {
    trigger_window  = "last_30m"
    recovery_window = "last_1h"
  }
  priority = 4
}

resource "datadog_monitor" "alb_healty_host_low_monitor" {

  name                = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
  type                = "query alert"
  query               = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P1 - Number of Healthy Hosts is {{value}} in TG: {{targetgroup}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Healthy Hosts is Low per Target Group
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
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 1
  }
  priority = 1
}

resource "datadog_monitor" "alb_request_high_monitor" {

  name                = "Terraform - AWS ALB - Number of Requests is High"
  type                = "query alert"
  query               = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 
Summary:P2 - Number of ALB total Requests is {{value}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Requests is High
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
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 4000
    warning  = 3000
  }
  priority = 2
}

resource "datadog_monitor" "alb_request_low_monitor" {

  name                = "Terraform - AWS ALB - Number of Requests is Low"
  type                = "query alert"
  query               = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 
Priority:P2

Summary:P2 - Number of ALB total Requests is {{value}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Requests is Low
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
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 20
    warning  = 25
  }
  priority = 2
}

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

