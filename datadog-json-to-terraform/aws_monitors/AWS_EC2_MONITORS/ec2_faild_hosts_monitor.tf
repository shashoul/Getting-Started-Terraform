resource "datadog_monitor" "ec2_faild_hosts_monitor" {

  name                = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
  type                = "query alert"
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
    critical = 0
  }
  priority = 1
}