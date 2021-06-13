#####
#
# AWS_EC2
#
#####
resource "datadog_monitor" AWS_EC2_1 {

 name = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
 type = "query alert"
 query = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 1
}


#####
#
# AWS_ALB
#
#####
resource "datadog_monitor" AWS_ALB_1 {

 name = "Terraform - AWS ALB - 3XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
 message = <<EOF
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
 critical = 9.0
 warning = 7.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_2 {

 name = "Terraform - AWS ALB - 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_3 {

 name = "Terraform - AWS ALB - 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_4 {

 name = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_5 {

 name = "Terraform - AWS ALB - Number of Requests is High"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 4000.0
 warning = 3000.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_6 {

 name = "Terraform - AWS ALB - Number of Requests is Low"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 20.0
 warning = 25.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_7 {

 name = "Terraform - AWS ALB - Target 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
 message = <<EOF
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
 tags = ["targetgroup",]
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
 critical = 10.0
 warning = 6.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_8 {

 name = "Terraform - AWS ALB - Target 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1
@webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_9 {

 name = "Terraform - AWS ALB - Target Respone Time is too High"
 type = "query alert"
 query = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_10 {

 name = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_ALB_11 {

 name = "Terraform - AWS ALB - Average Response Time is High per API Resource"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.3
 } 
 priority = 2
}


#####
#
# MongoDB
#
#####
resource "datadog_monitor" MongoDB_1 {

 name = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 warning = 7.0
 critical_recovery = 7.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_2 {

 name = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
 type = "query alert"
 query = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_3 {

 name = "Terraform - MongoDB - Free Disk Space is Low"
 type = "query alert"
 query = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 70000000000.0
 warning = 80000000000.0
 } 
 priority = 1
}


resource "datadog_monitor" MongoDB_4 {

 name = "Terraform - MongoDB - Number of Current Connections is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 75.0
 warning = 65.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_5 {

 name = "Terraform - MongoDB - Number of Inefficient Queries is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.5
 warning = 1.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_6 {

 name = "Terraform - MongoDB - Number of Read Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_7 {

 name = "Terraform - MongoDB - Number of Write Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_8 {

 name = "Terraform - MongoDB - Process Memory Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2050.0
 warning = 1840.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_9 {

 name = "Terraform - MongoDB - Read Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
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
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.3
 warning = 0.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_10 {

 name = "Terraform - MongoDB - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.14
 warning = 0.13
 critical_recovery = 0.13
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_11 {

 name = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.45
 } 
 priority = 2
}


#####
#
# AWS_SES
#
#####
resource "datadog_monitor" AWS_SES_1 {

 name = "Terraform - AWS SES - Number of Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_2 {

 name = "Terraform - AWS SES - Number of Delivery Attempts is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_3 {

 name = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.complaints{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_4 {

 name = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_5 {

 name = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_6 {

 name = "Terraform - AWS SES - Number of Opened Emails is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_7 {

 name = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_8 {

 name = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


#####
#
# K8S
#
#####
resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


#####
#
# AWS_NAT
#
#####
resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


#####
#
# Cloudfront
#
#####
resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


#####
#
# EBS
#
#####
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


#####
#
# bindid_authentication_server
#
#####
resource "datadog_monitor" bindid_authentication_server_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") -\\\"uri: [/api/v2/auth/*]\\\" -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\") -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"Unknown authorization code\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\") -(\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\") -(\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\") -\\\"api_error_code: alias_already_set\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant) -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_2 {

 name = "Terraform - 500: Backend & Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" OR \\\"status: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_3 {

 name = "Terraform - 500: End-Users"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" (\\\"uri: [/api/v2/auth/*]\\\" OR \\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\")) -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_4 {

 name = "Terraform - All Invalid Request Errors on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number ofInvalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_5 {

 name = "Terraform - Backend & Management - unsupported_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_6 {

 name = "Terraform - Backend & Management – invalid_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_7 {

 name = "Terraform - End User - invalid_client"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_8 {

 name = "Terraform - FIDO Registration Failures"
 type = "log alert"
 query = "logs(\"\\\"assertion_error_code:9\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_9 {

 name = "Terraform - Invalid HTTP Method: Backend/Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_10 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" \\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_11 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Invalid redirect uri\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_12 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Missing \\\" client_id\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_13 {

 name = "Terraform - Invalid authentication to BindID Backend API"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_14 {

 name = "Terraform - Invalid client credentials on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_15 {

 name = "Terraform - Management Console Bad Logins"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") OR (\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_16 {

 name = "Terraform - Number of \"Alias already set\" Errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server api_error_code alias_already_set\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_17 {

 name = "Terraform - OIDC Backend invalid_request errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_18 {

 name = "Terraform - Recovery Journey Invocations"
 type = "log alert"
 query = "logs(\"״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_19 {

 name = "Terraform - Ticket consumption errors"
 type = "log alert"
 query = "logs(\"cannot_consume_ticket ERROR 401\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_20 {

 name = "Terraform - Unknown authorization code on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"status: [400]\\\" \\\"Unknown authorization code\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_21 {

 name = "Terraform - User Cancellation"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\") ((\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) OR (\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") OR (\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_22 {

 name = "Terraform - User not found for backend/management support APIs"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") OR (\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_23 {

 name = "Terraform - 4XX: End-Users - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") (\\\"uri: [/api/v2/auth/*]\\\" OR (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" -(invalid_client \\\"Invalid client credentials\\\"))) -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) -(\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request (\\\"Invalid redirect uri\\\" OR \\\"Missing \\\\\"response_type\\\\\"\\\" OR \\\"Missing \\\" client_id)) -\\\"User not found\\\" -\\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_24 {

 name = "Terraform - Device not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_25 {

 name = "Terraform - Expression evaluation errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Unexpected exception during field resolution\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_26 {

 name = "Terraform - OIDC /complete with errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Client returned with error\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "OIDC /complete with errors"
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_27 {

 name = "Terraform - User not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"User not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# bindid_authentication_server_categorized
#
#####
resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized - Test error_category"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized - Test error_category"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-XiteIt 
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = ""
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# Bindid
#
#####
resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# ELB
#
#####
resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# AWS_EC2
#
#####
resource "datadog_monitor" AWS_EC2_1 {

 name = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
 type = "query alert"
 query = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 1
}


#####
#
# AWS_ALB
#
#####
resource "datadog_monitor" AWS_ALB_1 {

 name = "Terraform - AWS ALB - 3XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
 message = <<EOF
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
 critical = 9.0
 warning = 7.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_2 {

 name = "Terraform - AWS ALB - 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_3 {

 name = "Terraform - AWS ALB - 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_4 {

 name = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_5 {

 name = "Terraform - AWS ALB - Number of Requests is High"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 4000.0
 warning = 3000.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_6 {

 name = "Terraform - AWS ALB - Number of Requests is Low"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 20.0
 warning = 25.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_7 {

 name = "Terraform - AWS ALB - Target 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
 message = <<EOF
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
 tags = ["targetgroup",]
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
 critical = 10.0
 warning = 6.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_8 {

 name = "Terraform - AWS ALB - Target 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1
@webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_9 {

 name = "Terraform - AWS ALB - Target Respone Time is too High"
 type = "query alert"
 query = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_10 {

 name = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_ALB_11 {

 name = "Terraform - AWS ALB - Average Response Time is High per API Resource"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.3
 } 
 priority = 2
}


#####
#
# MongoDB
#
#####
resource "datadog_monitor" MongoDB_1 {

 name = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 warning = 7.0
 critical_recovery = 7.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_2 {

 name = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
 type = "query alert"
 query = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_3 {

 name = "Terraform - MongoDB - Free Disk Space is Low"
 type = "query alert"
 query = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 70000000000.0
 warning = 80000000000.0
 } 
 priority = 1
}


resource "datadog_monitor" MongoDB_4 {

 name = "Terraform - MongoDB - Number of Current Connections is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 75.0
 warning = 65.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_5 {

 name = "Terraform - MongoDB - Number of Inefficient Queries is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.5
 warning = 1.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_6 {

 name = "Terraform - MongoDB - Number of Read Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_7 {

 name = "Terraform - MongoDB - Number of Write Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_8 {

 name = "Terraform - MongoDB - Process Memory Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2050.0
 warning = 1840.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_9 {

 name = "Terraform - MongoDB - Read Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
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
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.3
 warning = 0.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_10 {

 name = "Terraform - MongoDB - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.14
 warning = 0.13
 critical_recovery = 0.13
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_11 {

 name = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.45
 } 
 priority = 2
}


#####
#
# AWS_SES
#
#####
resource "datadog_monitor" AWS_SES_1 {

 name = "Terraform - AWS SES - Number of Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_2 {

 name = "Terraform - AWS SES - Number of Delivery Attempts is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_3 {

 name = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.complaints{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_4 {

 name = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_5 {

 name = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_6 {

 name = "Terraform - AWS SES - Number of Opened Emails is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_7 {

 name = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_8 {

 name = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


#####
#
# K8S
#
#####
resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


#####
#
# AWS_NAT
#
#####
resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


#####
#
# Cloudfront
#
#####
resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


#####
#
# EBS
#
#####
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


#####
#
# bindid_authentication_server
#
#####
resource "datadog_monitor" bindid_authentication_server_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") -\\\"uri: [/api/v2/auth/*]\\\" -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\") -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"Unknown authorization code\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\") -(\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\") -(\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\") -\\\"api_error_code: alias_already_set\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant) -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_2 {

 name = "Terraform - 500: Backend & Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" OR \\\"status: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_3 {

 name = "Terraform - 500: End-Users"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" (\\\"uri: [/api/v2/auth/*]\\\" OR \\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\")) -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_4 {

 name = "Terraform - All Invalid Request Errors on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number ofInvalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_5 {

 name = "Terraform - Backend & Management - unsupported_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_6 {

 name = "Terraform - Backend & Management – invalid_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_7 {

 name = "Terraform - End User - invalid_client"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_8 {

 name = "Terraform - FIDO Registration Failures"
 type = "log alert"
 query = "logs(\"\\\"assertion_error_code:9\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_9 {

 name = "Terraform - Invalid HTTP Method: Backend/Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_10 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" \\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_11 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Invalid redirect uri\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_12 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Missing \\\" client_id\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_13 {

 name = "Terraform - Invalid authentication to BindID Backend API"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_14 {

 name = "Terraform - Invalid client credentials on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_15 {

 name = "Terraform - Management Console Bad Logins"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") OR (\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_16 {

 name = "Terraform - Number of \"Alias already set\" Errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server api_error_code alias_already_set\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_17 {

 name = "Terraform - OIDC Backend invalid_request errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_18 {

 name = "Terraform - Recovery Journey Invocations"
 type = "log alert"
 query = "logs(\"״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_19 {

 name = "Terraform - Ticket consumption errors"
 type = "log alert"
 query = "logs(\"cannot_consume_ticket ERROR 401\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_20 {

 name = "Terraform - Unknown authorization code on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"status: [400]\\\" \\\"Unknown authorization code\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_21 {

 name = "Terraform - User Cancellation"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\") ((\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) OR (\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") OR (\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_22 {

 name = "Terraform - User not found for backend/management support APIs"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") OR (\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_23 {

 name = "Terraform - 4XX: End-Users - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") (\\\"uri: [/api/v2/auth/*]\\\" OR (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" -(invalid_client \\\"Invalid client credentials\\\"))) -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) -(\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request (\\\"Invalid redirect uri\\\" OR \\\"Missing \\\\\"response_type\\\\\"\\\" OR \\\"Missing \\\" client_id)) -\\\"User not found\\\" -\\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_24 {

 name = "Terraform - Device not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_25 {

 name = "Terraform - Expression evaluation errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Unexpected exception during field resolution\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_26 {

 name = "Terraform - OIDC /complete with errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Client returned with error\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "OIDC /complete with errors"
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_27 {

 name = "Terraform - User not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"User not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


#####
#
# bindid_authentication_server_categorized
#
#####
resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


#####
#
# Bindid
#
#####
resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# ELB
#
#####
resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# AWS_EC2
#
#####
resource "datadog_monitor" AWS_EC2_1 {

 name = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
 type = "query alert"
 query = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 1
}


#####
#
# AWS_ALB
#
#####
resource "datadog_monitor" AWS_ALB_1 {

 name = "Terraform - AWS ALB - 3XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
 message = <<EOF
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
 critical = 9.0
 warning = 7.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_2 {

 name = "Terraform - AWS ALB - 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_3 {

 name = "Terraform - AWS ALB - 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_4 {

 name = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_5 {

 name = "Terraform - AWS ALB - Number of Requests is High"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 4000.0
 warning = 3000.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_6 {

 name = "Terraform - AWS ALB - Number of Requests is Low"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 20.0
 warning = 25.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_7 {

 name = "Terraform - AWS ALB - Target 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
 message = <<EOF
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
 tags = ["targetgroup",]
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
 critical = 10.0
 warning = 6.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_8 {

 name = "Terraform - AWS ALB - Target 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1
@webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_9 {

 name = "Terraform - AWS ALB - Target Respone Time is too High"
 type = "query alert"
 query = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_10 {

 name = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_ALB_11 {

 name = "Terraform - AWS ALB - Average Response Time is High per API Resource"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.3
 } 
 priority = 2
}


#####
#
# MongoDB
#
#####
resource "datadog_monitor" MongoDB_1 {

 name = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 warning = 7.0
 critical_recovery = 7.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_2 {

 name = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
 type = "query alert"
 query = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_3 {

 name = "Terraform - MongoDB - Free Disk Space is Low"
 type = "query alert"
 query = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 70000000000.0
 warning = 80000000000.0
 } 
 priority = 1
}


resource "datadog_monitor" MongoDB_4 {

 name = "Terraform - MongoDB - Number of Current Connections is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 75.0
 warning = 65.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_5 {

 name = "Terraform - MongoDB - Number of Inefficient Queries is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.5
 warning = 1.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_6 {

 name = "Terraform - MongoDB - Number of Read Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_7 {

 name = "Terraform - MongoDB - Number of Write Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_8 {

 name = "Terraform - MongoDB - Process Memory Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2050.0
 warning = 1840.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_9 {

 name = "Terraform - MongoDB - Read Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
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
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.3
 warning = 0.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_10 {

 name = "Terraform - MongoDB - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.14
 warning = 0.13
 critical_recovery = 0.13
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_11 {

 name = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.45
 } 
 priority = 2
}


#####
#
# AWS_SES
#
#####
resource "datadog_monitor" AWS_SES_1 {

 name = "Terraform - AWS SES - Number of Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_2 {

 name = "Terraform - AWS SES - Number of Delivery Attempts is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_3 {

 name = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.complaints{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_4 {

 name = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_5 {

 name = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_6 {

 name = "Terraform - AWS SES - Number of Opened Emails is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_7 {

 name = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_8 {

 name = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


#####
#
# K8S
#
#####
resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


#####
#
# AWS_NAT
#
#####
resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


#####
#
# Cloudfront
#
#####
resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


#####
#
# EBS
#
#####
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


#####
#
# bindid_authentication_server
#
#####
resource "datadog_monitor" bindid_authentication_server_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") -\\\"uri: [/api/v2/auth/*]\\\" -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\") -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"Unknown authorization code\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\") -(\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\") -(\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\") -\\\"api_error_code: alias_already_set\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant) -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_2 {

 name = "Terraform - 500: Backend & Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" OR \\\"status: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_3 {

 name = "Terraform - 500: End-Users"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" (\\\"uri: [/api/v2/auth/*]\\\" OR \\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\")) -\\\"rejection: MethodRejection\\\" -\\\"client returned with error\\\" -cannot_consume_ticket\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_4 {

 name = "Terraform - All Invalid Request Errors on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number ofInvalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_5 {

 name = "Terraform - Backend & Management - unsupported_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_6 {

 name = "Terraform - Backend & Management – invalid_grant"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_7 {

 name = "Terraform - End User - invalid_client"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_8 {

 name = "Terraform - FIDO Registration Failures"
 type = "log alert"
 query = "logs(\"\\\"assertion_error_code:9\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_9 {

 name = "Terraform - Invalid HTTP Method: Backend/Management"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" -\\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_10 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [500]\\\" \\\"uri: [/api/v2/auth/*]\\\" \\\"rejection: MethodRejection\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_11 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Invalid redirect uri\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_12 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request \\\"Missing \\\" client_id\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_13 {

 name = "Terraform - Invalid authentication to BindID Backend API"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_14 {

 name = "Terraform - Invalid client credentials on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_15 {

 name = "Terraform - Management Console Bad Logins"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") OR (\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_16 {

 name = "Terraform - Number of \"Alias already set\" Errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server api_error_code alias_already_set\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_17 {

 name = "Terraform - OIDC Backend invalid_request errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_18 {

 name = "Terraform - Recovery Journey Invocations"
 type = "log alert"
 query = "logs(\"״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_19 {

 name = "Terraform - Ticket consumption errors"
 type = "log alert"
 query = "logs(\"cannot_consume_ticket ERROR 401\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_20 {

 name = "Terraform - Unknown authorization code on /token"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"status: [400]\\\" \\\"Unknown authorization code\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_21 {

 name = "Terraform - User Cancellation"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\") ((\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) OR (\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") OR (\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_22 {

 name = "Terraform - User not found for backend/management support APIs"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server ((\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") OR (\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\"))\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_23 {

 name = "Terraform - 4XX: End-Users - Uncategorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") (\\\"uri: [/api/v2/auth/*]\\\" OR (\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" -(invalid_client \\\"Invalid client credentials\\\"))) -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\\\" \\\"errorCode: [4001]\\\" bindid_error_user_declined_title) -(\\\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\\\" \\\"errorCode: [4001]\\\" \\\"Authentication cancelled by the user\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\\\" invalid_request (\\\"Invalid redirect uri\\\" OR \\\"Missing \\\\\"response_type\\\\\"\\\" OR \\\"Missing \\\" client_id)) -\\\"User not found\\\" -\\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_24 {

 name = "Terraform - Device not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"Device not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_25 {

 name = "Terraform - Expression evaluation errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Unexpected exception during field resolution\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_26 {

 name = "Terraform - OIDC /complete with errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server \\\"Client returned with error\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "OIDC /complete with errors"
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_27 {

 name = "Terraform - User not found errors"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") \\\"uri: [/api/v2/auth/*]\\\" \\\"User not found\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


#####
#
# bindid_authentication_server_categorized
#
#####
resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


#####
#
# Bindid
#
#####
resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# ELB
#
#####
resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# AWS_EC2
#
#####
resource "datadog_monitor" AWS_EC2_1 {

 name = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
 type = "query alert"
 query = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 1
}


#####
#
# AWS_ALB
#
#####
resource "datadog_monitor" AWS_ALB_1 {

 name = "Terraform - AWS ALB - 3XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
 message = <<EOF
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
 critical = 9.0
 warning = 7.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_2 {

 name = "Terraform - AWS ALB - 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_3 {

 name = "Terraform - AWS ALB - 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_4 {

 name = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_5 {

 name = "Terraform - AWS ALB - Number of Requests is High"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 4000.0
 warning = 3000.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_6 {

 name = "Terraform - AWS ALB - Number of Requests is Low"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 20.0
 warning = 25.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_7 {

 name = "Terraform - AWS ALB - Target 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
 message = <<EOF
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
 tags = ["targetgroup",]
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
 critical = 10.0
 warning = 6.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_8 {

 name = "Terraform - AWS ALB - Target 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1
@webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_9 {

 name = "Terraform - AWS ALB - Target Respone Time is too High"
 type = "query alert"
 query = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_10 {

 name = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_ALB_11 {

 name = "Terraform - AWS ALB - Average Response Time is High per API Resource"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.3
 } 
 priority = 2
}


#####
#
# MongoDB
#
#####
resource "datadog_monitor" MongoDB_1 {

 name = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 warning = 7.0
 critical_recovery = 7.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_2 {

 name = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
 type = "query alert"
 query = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_3 {

 name = "Terraform - MongoDB - Free Disk Space is Low"
 type = "query alert"
 query = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 70000000000.0
 warning = 80000000000.0
 } 
 priority = 1
}


resource "datadog_monitor" MongoDB_4 {

 name = "Terraform - MongoDB - Number of Current Connections is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 75.0
 warning = 65.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_5 {

 name = "Terraform - MongoDB - Number of Inefficient Queries is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.5
 warning = 1.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_6 {

 name = "Terraform - MongoDB - Number of Read Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_7 {

 name = "Terraform - MongoDB - Number of Write Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_8 {

 name = "Terraform - MongoDB - Process Memory Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2050.0
 warning = 1840.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_9 {

 name = "Terraform - MongoDB - Read Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
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
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.3
 warning = 0.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_10 {

 name = "Terraform - MongoDB - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.14
 warning = 0.13
 critical_recovery = 0.13
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_11 {

 name = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.45
 } 
 priority = 2
}


#####
#
# AWS_SES
#
#####
resource "datadog_monitor" AWS_SES_1 {

 name = "Terraform - AWS SES - Number of Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_2 {

 name = "Terraform - AWS SES - Number of Delivery Attempts is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_3 {

 name = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.complaints{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_4 {

 name = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_5 {

 name = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_6 {

 name = "Terraform - AWS SES - Number of Opened Emails is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_7 {

 name = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_8 {

 name = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


#####
#
# K8S
#
#####
resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


#####
#
# AWS_NAT
#
#####
resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


#####
#
# Cloudfront
#
#####
resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


#####
#
# EBS
#
#####
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


#####
#
# bindid_authentication_server_categorized
#
#####
resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized - Categorized"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


#####
#
# Bindid
#
#####
resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# ELB
#
#####
resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# AWS_EC2
#
#####
resource "datadog_monitor" AWS_EC2_1 {

 name = "Terraform - AWS EC2 - Number of Failed Host Checks is High"
 type = "query alert"
 query = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 1
}


#####
#
# AWS_ALB
#
#####
resource "datadog_monitor" AWS_ALB_1 {

 name = "Terraform - AWS ALB - 3XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
 message = <<EOF
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
 critical = 9.0
 warning = 7.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_2 {

 name = "Terraform - AWS ALB - 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_3 {

 name = "Terraform - AWS ALB - 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_4 {

 name = "Terraform - AWS ALB - Number of Healthy Hosts is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_5 {

 name = "Terraform - AWS ALB - Number of Requests is High"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 4000.0
 warning = 3000.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_6 {

 name = "Terraform - AWS ALB - Number of Requests is Low"
 type = "query alert"
 query = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 20.0
 warning = 25.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_ALB_7 {

 name = "Terraform - AWS ALB - Target 4XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
 message = <<EOF
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
 tags = ["targetgroup",]
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
 critical = 10.0
 warning = 6.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_8 {

 name = "Terraform - AWS ALB - Target 5XX Error Rate is High"
 type = "query alert"
 query = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1
@webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_9 {

 name = "Terraform - AWS ALB - Target Respone Time is too High"
 type = "query alert"
 query = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 120
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 } 
 priority = 1
}


resource "datadog_monitor" AWS_ALB_10 {

 name = "Terraform - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_ALB_11 {

 name = "Terraform - AWS ALB - Average Response Time is High per API Resource"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.3
 } 
 priority = 2
}


#####
#
# MongoDB
#
#####
resource "datadog_monitor" MongoDB_1 {

 name = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 8.0
 warning = 7.0
 critical_recovery = 7.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_2 {

 name = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
 type = "query alert"
 query = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_3 {

 name = "Terraform - MongoDB - Free Disk Space is Low"
 type = "query alert"
 query = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 70000000000.0
 warning = 80000000000.0
 } 
 priority = 1
}


resource "datadog_monitor" MongoDB_4 {

 name = "Terraform - MongoDB - Number of Current Connections is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

 @webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 75.0
 warning = 65.0
 } 
 priority = 3
}


resource "datadog_monitor" MongoDB_5 {

 name = "Terraform - MongoDB - Number of Inefficient Queries is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.5
 warning = 1.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_6 {

 name = "Terraform - MongoDB - Number of Read Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_7 {

 name = "Terraform - MongoDB - Number of Write Requests is High"
 type = "query alert"
 query = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2000.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_8 {

 name = "Terraform - MongoDB - Process Memory Usage is high"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 2050.0
 warning = 1840.0
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_9 {

 name = "Terraform - MongoDB - Read Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
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
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.3
 warning = 0.2
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_10 {

 name = "Terraform - MongoDB - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2 

@webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.14
 warning = 0.13
 critical_recovery = 0.13
 } 
 priority = 2
}


resource "datadog_monitor" MongoDB_11 {

 name = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
 type = "query alert"
 query = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.5
 warning = 0.45
 } 
 priority = 2
}


#####
#
# AWS_SES
#
#####
resource "datadog_monitor" AWS_SES_1 {

 name = "Terraform - AWS SES - Number of Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_2 {

 name = "Terraform - AWS SES - Number of Delivery Attempts is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_3 {

 name = "Terraform - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
 type = "query alert"
 query = "sum(last_1h):count:aws.ses.complaints{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_4 {

 name = "Terraform - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_5 {

 name = "Terraform - AWS SES - Number of Hard Bounced Emails is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_6 {

 name = "Terraform - AWS SES - Number of Opened Emails is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_7 {

 name = "Terraform - AWS SES - Number of Rejected Send Attempts is High"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_SES_8 {

 name = "Terraform - AWS SES - Number of Successful Emails Sent is Low"
 type = "query alert"
 query = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 60
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


#####
#
# K8S
#
#####
resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


#####
#
# AWS_NAT
#
#####
resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


#####
#
# Cloudfront
#
#####
resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
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
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
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
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


#####
#
# EBS
#
#####
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


#####
#
# bindid_authentication_server_categorized
#
#####
resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized, non-foreign"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\" OR \\\"Foreign errors\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized, non-foreign"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\" OR \\\"Foreign errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_28 {

 name = "Terraform - Foreign errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Foreign errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


#####
#
# Bindid
#
#####
resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


#####
#
# ELB
#
#####
resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


