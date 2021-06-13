resource "datadog_monitor" "mongodb_cpu_usage_high_monitor" {

  name                = "Terraform - MongoDB - Avg Tasks CPU Usage is high"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical          = 8
    warning           = 7
    critical_recovery = 7
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_current_connections_high_monitor" {

  name                = "Terraform - MongoDB - Number of Current Connections is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 75
    warning  = 65
  }
  priority = 3
}
resource "datadog_monitor" "mongodb_free_disk_space_low_monitor" {

  name                = "Terraform - MongoDB - Free Disk Space is Low"
  type                = "query alert"
  query               = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 70000000000
    warning  = 80000000000
  }
  priority = 1
}
resource "datadog_monitor" "mongodb_inefficient_queries_high_monitor" {

  name                = "Terraform - MongoDB - Number of Inefficient Queries is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 1.5
    warning  = 1.2
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_iops_disk_usage_high_monitor" {

  name                = "Terraform - MongoDB - Avg of IOPS Disk Usage is High"
  type                = "query alert"
  query               = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 50
    warning  = 30
  }
  priority = 3
}
resource "datadog_monitor" "mongodb_process_memory_usage_high_monitor" {

  name                = "Terraform - MongoDB - Process Memory Usage is high"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 2050
    warning  = 1840
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_read_operations_latency_high_monitor" {

  name                = "Terraform - MongoDB - Read Operations Latency is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 0.3
    warning  = 0.2
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_read_request_high_monitor" {

  name                = "Terraform - MongoDB - Number of Read Requests is High"
  type                = "query alert"
  query               = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 2000
    warning  = 1500
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_write_operations_latency1_high_monitor" {

  name                = "Terraform - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 0.5
    warning  = 0.45
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_write_operations_latency__high_monitor" {

  name                = "Terraform - MongoDB - Write Operations Latency is High"
  type                = "query alert"
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
  message             = <<EOF
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
    critical          = 0.14
    warning           = 0.13
    critical_recovery = 0.13
  }
  priority = 2
}
resource "datadog_monitor" "mongodb_write_request_high_monitor" {

  name                = "Terraform - MongoDB - Number of Write Requests is High"
  type                = "query alert"
  query               = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
  message             = <<EOF
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
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 2000
    warning  = 1500
  }
  priority = 2
}
