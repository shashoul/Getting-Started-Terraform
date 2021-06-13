resource "datadog_monitor" "AWS_EC2_1" {

  tags                = []
  query               = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:P1 - {{value}} Failed Host Checks on AWS EC2

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS ALB
Service:Number of Failed Host Checks
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "AWS EC2 - Number of Failed Host Checks is High"
  priority            = 1
  type                = "query alert"
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
    critical = 0.0
  }
}

