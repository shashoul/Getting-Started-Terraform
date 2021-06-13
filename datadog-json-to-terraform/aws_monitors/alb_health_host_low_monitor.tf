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