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


