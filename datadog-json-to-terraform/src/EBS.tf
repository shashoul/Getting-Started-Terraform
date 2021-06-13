resource "datadog_monitor" EBS_1 {

 name = "Terraform - EBS - Number of Read Ops is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.ebs.volume_read_ops{environment:production} by {host}.as_count() > 25"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 

Summary:P3 - {{value}}  Read Ops on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Read Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25.0
 warning = 20.0
 } 
 priority = 3
}


resource "datadog_monitor" EBS_2 {

 name = "Terraform - EBS - Number of Volumes with Status OK is Low"
 type = "query alert"
 query = "sum(last_15m):sum:aws.ebs.status.ok{*} < 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 

Summary:P3 - {{value}} EBS Volumes are with Status OK 
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS
Service:Low Number of Volumes with Status OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 } 
 priority = 3
}


resource "datadog_monitor" EBS_3 {

 name = "Terraform - EBS - Number of Write Ops is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.ebs.volume_write_ops{environment:production,!host:i-0bad31cb7d1ea95a0,!host:i-0210258000ee05a99} by {host}.as_count() > 120000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Number of Write Ops is {{value}} on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Write Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 120000.0
 warning = 110000.0
 } 
 priority = 3
}


resource "datadog_monitor" EBS_4 {

 name = "Terraform - EBS [i-0210258000ee05a99] - Number of Write Ops is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0210258000ee05a99} by {host}.as_count() > 2000"
 message = "@slack-cloud-alerts-bindid-prd"
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 900
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1700.0
 } 
 priority = 3
}


resource "datadog_monitor" EBS_5 {

 name = "Terraform - EBS [i-0bad31cb7d1ea95a0] - Number of Write Ops is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0bad31cb7d1ea95a0} by {host}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Number of Write Ops is {{value}}  on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Write Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 900
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1700.0
 } 
 priority = 3
}


