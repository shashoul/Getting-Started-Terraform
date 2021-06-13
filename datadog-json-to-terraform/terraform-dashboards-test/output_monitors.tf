resource "datadog_monitor" "monitor_1" {

  tags         = []
  query        = "\"ntp.in_sync\".over(\"*\").by(\"host\").last(2).count_by_status()"
  message      = <<EOF
Triggers if any host's clock goes out of sync with the time given by NTP. The offset threshold is configured in the Agent's `ntp.yaml` file.

Please read the [KB article](https://docs.datadoghq.com/agent/faq/network-time-protocol-ntp-offset-issues) on NTP Offset issues for more details on cause and resolution.

@webhook-XiteIt

Summary:Clock Went Out of Sync by NTP on {{host.name}} 
Critical Threshold:-
Warning Threshold:-

Host:{{host.name}} 
Service:Clock Went Out of Sync by NTP
Value:Clock Went Out of Sync by NTP
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "[Auto] Clock in sync with NTP"
  priority     = null
  type         = "service check"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    warning  = 1
    ok       = 1
    critical = 1
  }
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_2" {

  tags                = []
  query               = "avg(last_5m):avg:datadog.agent.running{*} by {host} < 1"
  message             = <<EOF
No data received from host {{name.name}}

Regards,
Transmit Security DevOps Team
EOF
  name                = "Alert: No data received from {{name.name}}"
  priority            = null
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 10
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = 20
}


resource "datadog_monitor" "monitor_3" {

  tags         = []
  query        = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
  message      = <<EOF
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
  name         = "BindId Service Errors on env: BindID Production"
  priority     = null
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_4" {

  tags                = []
  query               = "avg(last_1h):avg:aws.ec2.cpuutilization{*} > 25"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - AWS EC2 - CPU Avg Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 25.0
    warning           = 22.0
    critical_recovery = 20.0
  }
}


resource "datadog_monitor" "monitor_5" {

  tags                = []
  query               = "sum(last_1h):max:aws.natgateway.active_connection_count{*}.as_count() >= 55000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - AWS NAT - High Count of Active Connections"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 55000.0
    warning           = 50000.0
    critical_recovery = 30000.0
  }
}


resource "datadog_monitor" "monitor_6" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_out.maximum{*} > 950000"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - AWS EC2 - Network Out Max Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 950000.0
    warning           = 900000.0
    critical_recovery = 880000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_7" {

  tags         = []
  query        = "sum(last_1h):sum:aws.applicationelb.httpcode_elb_4xx{*} by {host}.as_count() > 250"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - AWS ELB - High load of 4xx HTTPCode in total"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 250.0
    warning           = 220.0
    critical_recovery = 180.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_8" {

  tags         = []
  query        = "avg(last_30m):avg:kubernetes.cpu.usage.total{*} by {pod_name} > 4300000000"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - Kubernetes Pods - CPU Total Usage is high on pod: {{pod_name.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 4300000000.0
    warning           = 4200000000.0
    critical_recovery = 4000000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_9" {

  tags                = []
  query               = "avg(last_1h):sum:aws.natgateway.bytes_out_to_source{*} <= 85000"
  message             = <<EOF
{{^is_alert}}

AWS NAT - Number of bytes (Out) to Clients

{{/is_alert}}
EOF
  name                = "Terraform - AWS NAT Comp - Number of bytes (Out) to Clients"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 85000.0
    warning           = 87000.0
    critical_recovery = 90000.0
  }
}


resource "datadog_monitor" "monitor_10" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_in{*} > 3000000"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - AWS EC2 - Network In Avg Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 3000000.0
    warning           = 2500000.0
    critical_recovery = 2000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_11" {

  tags                = []
  query               = "avg(last_1h):max:aws.ec2.cpuutilization.maximum{*} > 100"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - AWS EC2 - CPU Max Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 100.0
    warning           = 95.0
    critical_recovery = 90.0
  }
}


resource "datadog_monitor" "monitor_12" {

  tags                = []
  query               = "avg(last_1h):avg:kubernetes.cpu.usage.total{*} > 90000000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - Kubernetes Nodes - CPU Total Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 90000000.0
    warning           = 85000000.0
    critical_recovery = 80000000.0
  }
}


resource "datadog_monitor" "monitor_13" {

  tags                = []
  query               = "avg(last_1h):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
EOF
  name                = "Terraform - AWS NAT Comp - Number of bytes received from KS server"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 2000000.0
    warning           = 1900000.0
    critical_recovery = 1480000.0
  }
}


resource "datadog_monitor" "monitor_14" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_in.maximum{*} > 6000000"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - AWS EC2 - Network In Max Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 6000000.0
    warning           = 4600000.0
    critical_recovery = 4100000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_15" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.memory.capacity{*} - avg:kubernetes.memory.usage{*} > 31000000000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - Kubernetes Pods - Free Memory Capacity has been exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 31000000000.0
    warning           = 29000000000.0
    critical_recovery = 29000000000.0
  }
}


resource "datadog_monitor" "monitor_16" {

  tags         = []
  query        = "avg(last_4h):anomalies(avg:kubernetes.memory.usage{*} by {pod_name}, 'agile', 4, direction='both', alert_window='last_30m', interval=60, count_default_zero='true', seasonality='weekly') >= 1"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - Kubernetes Pods - Memory Usage is high on pod: {{pod_name.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 1.0
    warning           = 0.9
    critical_recovery = 0.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  monitor_threshold_windows {
    recovery_window = "last_30m"
    trigger_window  = "last_30m"
  }
}


resource "datadog_monitor" "monitor_17" {

  tags                = []
  query               = "avg(last_1h):sum:aws.applicationelb.request_count{*}.as_rate() > 0.67"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - AWS ELB - Total Request Count Status (Peaks/Drops)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.67
    warning           = 0.65
    critical_recovery = 0.63
  }
}


resource "datadog_monitor" "monitor_18" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.memory.usage{*} > 512000000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - Kubernetes Nodes - Memory Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 512000000.0
    warning           = 480000000.0
    critical_recovery = 450000000.0
  }
}


resource "datadog_monitor" "monitor_19" {

  tags                = []
  query               = "!22636799 && 22636795"
  message             = <<EOF
If the value for BytesOutToSource is less than the value for BytesInFromDestination, there may be data loss during NAT gateway processing, or traffic being actively blocked by the NAT gateway.
More information: [Confluence] (https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway-cloudwatch.html) @slack-cloud-alerts-bindid-prd
EOF
  name                = "Terraform - AWS NAT Comp - Data Loss during NAT gateway processing"
  priority            = null
  type                = "composite"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
}


resource "datadog_monitor" "monitor_20" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_out{*} > 1400000"
  message      = "@slack-cloud-alerts-bindid-prd"
  name         = "Terraform - AWS EC2 - Network Out Avg Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 1400000.0
    warning           = 1200000.0
    critical_recovery = 1000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_21" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.filesystem.usage_pct{*} > 0.00047"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - Kubernetes Nodes - Disk Usage has been exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.00047
    warning           = 0.00045
    critical_recovery = 0.00042
  }
}


resource "datadog_monitor" "monitor_22" {

  tags         = ["env:production", "service:ts-auth-control", ]
  query        = "avg(last_10m):trace.akka_http.request.duration.by.service.95p{env:production,service:ts-auth-control} > 0.003"
  message      = <<EOF
Service ts-auth-control has a high p95 latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-auth-control" p95 Latency on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-auth-control p95 Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-auth-control has a high p95 latency on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 0.003
    warning  = 0.002
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_23" {

  tags         = ["env:production", "service:ts-sandbox-auth-control", ]
  query        = "avg(last_10m):trace.akka_http.request.duration.by.service.95p{env:production,service:ts-sandbox-auth-control} > 0.13"
  message      = <<EOF
Service ts-sandbox-auth-control has a high p95 latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-sandbox-auth-control" p95 Latency on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-sandbox-auth-control p95 Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-sandbox-auth-control has a high p95 latency on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 0.13
    warning  = 0.12
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_24" {

  tags                = ["env:production", "service:ts-auth-control", ]
  query               = "avg(last_10m):sum:trace.akka_http.request.duration{env:production,service:ts-auth-control} / sum:trace.akka_http.request.hits{env:production,service:ts-auth-control} > 0.0008"
  message             = <<EOF
Service ts-auth-control has a high average latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-auth-control" Latency Average on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-auth-control Latency Average
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Service ts-auth-control has a high average latency on production"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.0008
    warning  = 0.0006
  }
}


resource "datadog_monitor" "monitor_25" {

  tags                = ["env:production", "service:ts-sandbox-auth-control", ]
  query               = "avg(last_10m):sum:trace.akka_http.request.duration{env:production,service:ts-sandbox-auth-control} / sum:trace.akka_http.request.hits{env:production,service:ts-sandbox-auth-control} > 0.17"
  message             = <<EOF
Service ts-sandbox-auth-control has a high average latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-sandbox-auth-control" Latency Average on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-sandbox-auth-control Latency Average
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Service ts-sandbox-auth-control has a high average latency on production"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.17
    warning  = 0.16
  }
}


resource "datadog_monitor" "monitor_26" {

  tags                = []
  query               = "sum(last_1h):avg:mongodb.atlas.system.disk.iops.total{*}.as_count() > 30000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Avg Total Disk IOPS is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 30000.0
    warning           = 28000.0
    critical_recovery = 25000.0
  }
}


resource "datadog_monitor" "monitor_27" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.connections.current{*} > 100"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Number of current connections is above 100"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 100.0
    warning           = 95.0
    critical_recovery = 95.0
  }
}


resource "datadog_monitor" "monitor_28" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Avg CPU Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 8.0
    warning           = 7.0
    critical_recovery = 7.0
  }
}


resource "datadog_monitor" "monitor_29" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.disk.space.free{*} > 98500000000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Avg Disk Space Has Exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 98500000000.0
    warning           = 97000000000.0
    critical_recovery = 97000000000.0
  }
}


resource "datadog_monitor" "monitor_30" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.mem.resident{*} > 1750"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Process Memory Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 1750.0
    warning           = 1740.0
    critical_recovery = 1740.0
  }
}


resource "datadog_monitor" "monitor_31" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.opcounters.getmore{*}.as_rate() + sum:mongodb.atlas.opcounters.query{*}.as_rate() > 9"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Read Requests (Per Second) throughput is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 9.0
    warning           = 8.7
    critical_recovery = 8.0
  }
}


resource "datadog_monitor" "monitor_32" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.opcounters.delete{*}.as_rate() + avg:mongodb.atlas.opcounters.insert{*}.as_rate() + sum:mongodb.atlas.opcounters.update{*}.as_rate() > 2"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Write Requests (Per Second) throughput is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 2.0
    warning           = 1.9
    critical_recovery = 1.7
  }
}


resource "datadog_monitor" "monitor_33" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.metrics.document.deleted{*}.as_rate() + sum:mongodb.atlas.metrics.document.inserted{*}.as_rate() + sum:mongodb.atlas.metrics.document.updated{*}.as_rate() > 4"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Document Writes"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 4.0
    warning           = 3.8
    critical_recovery = 3.6
  }
}


resource "datadog_monitor" "monitor_34" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.metrics.document.returned{*}.as_rate() > 100"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Document Reads"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 100.0
    warning           = 98.0
    critical_recovery = 95.0
  }
}


resource "datadog_monitor" "monitor_35" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.cursors.totalopen{*} > 0.9"
  message             = "When a read query is received, MongoDB returns a cursor which represents a pointer to the data (documents). This cursor remains open on the server, consuming memory and large amount of memory being consumed can cause application issues. @slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Total Cursors"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.9
    warning           = 0.7
    critical_recovery = 0.7
  }
}


resource "datadog_monitor" "monitor_36" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} + avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{*} > 1.5"
  message             = "Indexing queries and returned results may be slow @slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Query Efficiency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 1.5
    warning           = 1.3
    critical_recovery = 1.3
  }
}


resource "datadog_monitor" "monitor_37" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.reads.avg{*} > 0.13"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Read Operations have a high average latency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.13
    warning           = 0.12
    critical_recovery = 0.12
  }
}


resource "datadog_monitor" "monitor_38" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{*} > 0.5"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Write Operations have a high average latency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.45
    critical_recovery = 0.45
  }
}


resource "datadog_monitor" "monitor_39" {

  tags                = []
  query               = "avg(last_1h):max:mongodb.atlas.system.cpu.norm.guest{*} + max:mongodb.atlas.system.cpu.norm.iowait{*} + max:mongodb.atlas.system.cpu.norm.irq{*} + max:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + max:mongodb.atlas.system.cpu.norm.nice{*} + max:mongodb.atlas.system.cpu.norm.softirq{*} + max:mongodb.atlas.system.cpu.norm.steal{*} + max:mongodb.atlas.system.cpu.norm.user{*} > 12"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Max CPU Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 12.0
    warning           = 11.0
    critical_recovery = 11.0
  }
}


resource "datadog_monitor" "monitor_40" {

  tags                = []
  query               = "avg(last_4h):anomalies(top(max:mongodb.atlas.system.cpu.norm.user{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= 1"
  message             = "Hostname:{{hostnameport.name}} has Max CPU Usage  @slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Top Hosts with Max CPU Usage"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_threshold_windows {
    recovery_window = "last_30m"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 1.0
    warning           = 0.9
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_41" {

  tags                = []
  query               = "avg(last_1h):max:mongodb.atlas.system.disk.space.free{*} - max:mongodb.atlas.system.disk.space.used{*} < 10000000000"
  message             = "This alert triggers when disk space is below 10GB out of 90GB. @slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Max Disk Space Is Low"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 10000000000.0
    warning           = 11000000000.0
    critical_recovery = 11000000000.0
  }
}


resource "datadog_monitor" "monitor_42" {

  tags                = []
  query               = "avg(last_4h):anomalies(top(max:mongodb.atlas.system.disk.space.percentused{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= 1"
  message             = "Hostname:{{hostnameport.name}} has Max Disk Space used.  @slack-cloud-alerts-bindid-prd"
  name                = "Terraform - MongoDB - Top hosts by disk space used (Percentage)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_threshold_windows {
    recovery_window = "last_30m"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 1.0
    warning           = 0.8
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_43" {

  tags         = ["env:production", "service:ts-auth-control", ]
  query        = "avg(last_10m):(sum:trace.akka_http.request.errors{env:production,service:ts-auth-control} / sum:trace.akka_http.request.hits{env:production,service:ts-auth-control}) * 100 > 11"
  message      = <<EOF
Service ts-auth-control has a high error rate!! @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-auth-control" Error Rate on Production is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Production
Service:High ts-auth-control Error Rate
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-auth-control has a high error rate on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 11.0
    warning  = 9.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_44" {

  tags         = ["env:production", "service:ts-sandbox-auth-control", ]
  query        = "avg(last_10m):(sum:trace.akka_http.request.errors{env:production,service:ts-sandbox-auth-control} / sum:trace.akka_http.request.hits{env:production,service:ts-sandbox-auth-control}) * 100 > 11"
  message      = <<EOF
Service ts-sandbox-auth-control has a high error rate!! @slack-cloud-alerts-bindid-prd
Priority:-
@webhook-XiteIt

Summary:"ts-sandbox-auth-control" Error Rate on Production is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Production
Service:High ts-sandbox-auth-control Error Rate
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-sandbox-auth-control has a high error rate on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 11.0
    warning  = 9.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_45" {

  tags         = ["env:production", "service:ts-bindid-oauth-service", ]
  query        = "avg(last_10m):(sum:trace.http.request.errors{env:production,service:ts-bindid-oauth-service} / sum:trace.http.request.hits{env:production,service:ts-bindid-oauth-service}) * 100 > 10"
  message      = <<EOF
Service ts-bindid-oauth-service has a high error rate!! @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service" Error Rate on Production is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Production
Service:High ts-bindid-oauth-service Error Rate
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-bindid-oauth-service has a high error rate on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 10.0
    warning  = 8.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_46" {

  tags         = ["env:production", "service:ts-bindid-oauth-service", ]
  query        = "avg(last_10m):trace.http.request.duration.by.service.95p{env:production,service:ts-bindid-oauth-service} > 0.25"
  message      = <<EOF
Service ts-bindid-oauth-service has a high p95 latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service" p95 Latency on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-bindid-oauth-service p95 Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-bindid-oauth-service has a high p95 latency on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 0.25
    warning  = 0.22
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_47" {

  tags                = ["env:production", "service:ts-bindid-oauth-service", ]
  query               = "avg(last_10m):sum:trace.http.request.duration{env:production,service:ts-bindid-oauth-service} / sum:trace.http.request.hits{env:production,service:ts-bindid-oauth-service} > 0.063"
  message             = <<EOF
Service ts-bindid-oauth-service has a high average latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service" Latency Average on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-bindid-oauth-service Latency Average
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Service ts-bindid-oauth-service has a high average latency on production"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.063
    warning  = 0.061
  }
}


resource "datadog_monitor" "monitor_48" {

  tags         = ["env:production", "service:ts-bindid-oauth-service-http-client", ]
  query        = "avg(last_10m):(sum:trace.http.request.errors{env:production,service:ts-bindid-oauth-service-http-client} / sum:trace.http.request.hits{env:production,service:ts-bindid-oauth-service-http-client}) * 100 > 90"
  message      = <<EOF
Service ts-bindid-oauth-service-http-client has a high error rate!! @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service-http-client" Error Rate on Production is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Production
Service:High ts-bindid-oauth-service-http-client Error Rate
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-bindid-oauth-service-http-client has a high error rate on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 90.0
    warning  = 70.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_49" {

  tags                = ["env:production", "service:ts-bindid-oauth-service-http-client", ]
  query               = "avg(last_10m):sum:trace.http.request.duration{env:production,service:ts-bindid-oauth-service-http-client} / sum:trace.http.request.hits{env:production,service:ts-bindid-oauth-service-http-client} > 0.23"
  message             = <<EOF
Service ts-bindid-oauth-service-http-client has a high average latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service-http-client" Latency Average on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-bindid-oauth-service-http-client Latency Average
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Service ts-bindid-oauth-service-http-client has a high average latency on production"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.23
    warning  = 0.2
  }
}


resource "datadog_monitor" "monitor_50" {

  tags         = ["env:production", "service:ts-bindid-oauth-service-http-client", ]
  query        = "avg(last_10m):trace.http.request.duration.by.service.95p{env:production,service:ts-bindid-oauth-service-http-client} > 0.23"
  message      = <<EOF
Service ts-bindid-oauth-service-http-client has a high p95 latency. @slack-cloud-alerts-bindid-prd
Priority:-

@webhook-XiteIt

Summary:"ts-bindid-oauth-service-http-client" p95 Latency on Production is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Production
Service:High ts-bindid-oauth-service-http-client p95 Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Service ts-bindid-oauth-service-http-client has a high p95 latency on production"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 0.23
    warning  = 0.2
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_51" {

  tags         = []
  query        = "avg(last_30m):avg:kubernetes.cpu.usage.total{*} by {kube_container_name} > 680000000"
  message      = "CPU Usage is high for the selected service!!! This can include all auth-control services @slack-cloud-alerts-bindid-prd"
  name         = "Terraform - Kubernetes Containers - CPU Usage is high on container: {{kube_container_name.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 680000000.0
    warning           = 650000000.0
    critical_recovery = 630000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_52" {

  tags         = []
  query        = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message      = <<EOF
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
  name         = "BindID Self Serve Successful Registrations on env: BindID Production"
  priority     = null
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_53" {

  tags         = []
  query        = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message      = <<EOF
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
  name         = "BindID Self Serve Failed Registrations on env: BindID Production"
  priority     = null
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_54" {

  tags                = []
  query               = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
  message             = <<EOF
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
  name                = "Cloudfront - Number of Requests is High"
  priority            = 2
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
    critical = 2500.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_55" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} > 5"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 4XX Error Rate is High - Production"
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
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_56" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} > 5"
  message             = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 5XX Error Rate is High - Production"
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
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_57" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.volume_read_ops{environment:production} by {host}.as_count() > 25"
  message             = <<EOF
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
  name                = "EBS - Number of Read Ops is High"
  priority            = 3
  type                = "query alert"
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
    critical = 25.0
    warning  = 20.0
  }
}


resource "datadog_monitor" "monitor_58" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.volume_write_ops{environment:production,!host:i-0bad31cb7d1ea95a0,!host:i-0210258000ee05a99} by {host}.as_count() > 120000"
  message             = <<EOF
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
  name                = "EBS - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
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
    critical = 120000.0
    warning  = 110000.0
  }
}


resource "datadog_monitor" "monitor_59" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0bad31cb7d1ea95a0} by {host}.as_count() > 2000"
  message             = <<EOF
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
  name                = "EBS [i-0bad31cb7d1ea95a0] - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = false
  new_host_delay      = 900
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 2000.0
    warning  = 1700.0
  }
}


resource "datadog_monitor" "monitor_60" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0210258000ee05a99} by {host}.as_count() > 2000"
  message             = "@slack-cloud-alerts-bindid-prd"
  name                = "EBS [i-0210258000ee05a99] - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = true
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = false
  new_host_delay      = 900
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 2000.0
    warning  = 1700.0
  }
}


resource "datadog_monitor" "monitor_61" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.status.ok{*} < 8"
  message             = <<EOF
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
  name                = "EBS - Number of Volumes with Status OK is Low"
  priority            = 3
  type                = "query alert"
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
    critical = 8.0
  }
}


resource "datadog_monitor" "monitor_62" {

  tags                = []
  query               = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
  message             = <<EOF
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
  name                = "[MoovingOn] AWS NAT - High Count of Active Connections"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = true
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 2500.0
    warning  = 2000.0
  }
}


resource "datadog_monitor" "monitor_63" {

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


resource "datadog_monitor" "monitor_64" {

  tags                = []
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
  name                = "AWS ALB - Number of Healthy Hosts is Low"
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
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_65" {

  tags                = []
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
  name                = "AWS ALB - Number of Requests is High"
  priority            = 2
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
    critical = 4000.0
    warning  = 3000.0
  }
}


resource "datadog_monitor" "monitor_66" {

  tags                = []
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
  name                = "AWS ALB - Number of Requests is Low"
  priority            = 2
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
    critical = 20.0
    warning  = 25.0
  }
}


resource "datadog_monitor" "monitor_67" {

  tags                = ["targetgroup", ]
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
  name                = "AWS ALB - Target 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 10.0
    warning  = 6.0
  }
}


resource "datadog_monitor" "monitor_68" {

  tags                = []
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
  message             = <<EOF
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
  name                = "AWS ALB - Target 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 120
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_69" {

  tags                = ["Ring1", ]
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
  message             = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "AWS ALB - 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_70" {

  tags                = ["Ring1", ]
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
  message             = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "AWS ALB - 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_71" {

  tags                = []
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
  name                = "AWS ALB - Target Respone Time is too High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 120
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 3.0
    warning  = 2.0
  }
}


resource "datadog_monitor" "monitor_72" {

  tags                = []
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
  name                = "AWS ALB Requests Anomaly - Number of Requests (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_73" {

  tags                = []
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
  name                = "MongoDB - Avg Tasks CPU Usage is high"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 8.0
    warning           = 7.0
    critical_recovery = 7.0
  }
}


resource "datadog_monitor" "monitor_74" {

  tags                = []
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
  name                = "MongoDB - Process Memory Usage is high"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 2050.0
    warning  = 1840.0
  }
}


resource "datadog_monitor" "monitor_75" {

  tags                = []
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
  name                = "MongoDB - Number of Read Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 2000.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_76" {

  tags                = []
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
  name                = "MongoDB - Number of Write Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 2000.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_77" {

  tags                = []
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
  name                = "MongoDB - Avg of IOPS Disk Usage is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_78" {

  tags                = []
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
  name                = "MongoDB - Number of Current Connections is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 75.0
    warning  = 65.0
  }
}


resource "datadog_monitor" "monitor_79" {

  tags                = []
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
  name                = "MongoDB - Free Disk Space is Low"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 70000000000.0
    warning  = 80000000000.0
  }
}


resource "datadog_monitor" "monitor_80" {

  tags                = []
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
  name                = "MongoDB - Read Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.3
    warning  = 0.2
  }
}


resource "datadog_monitor" "monitor_81" {

  tags                = []
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
  name                = "MongoDB - Write Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical          = 0.14
    warning           = 0.13
    critical_recovery = 0.13
  }
}


resource "datadog_monitor" "monitor_82" {

  tags                = []
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
  name                = "MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.5
    warning  = 0.45
  }
}


resource "datadog_monitor" "monitor_83" {

  tags                = []
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
  name                = "MongoDB - Number of Inefficient Queries is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.5
    warning  = 1.2
  }
}


resource "datadog_monitor" "monitor_84" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Destination Bytes Received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical          = 2000000.0
    warning           = 1900000.0
    critical_recovery = 1480000.0
  }
}


resource "datadog_monitor" "monitor_85" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Destination Bytes Received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 110000.0
    warning  = 120000.0
  }
}


resource "datadog_monitor" "monitor_86" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Source Bytes Received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 2200000.0
    warning  = 1800000.0
  }
}


resource "datadog_monitor" "monitor_87" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Source Bytes Received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 700000.0
    warning  = 800000.0
  }
}


resource "datadog_monitor" "monitor_88" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Bytes Sent to Destination is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 10000000.0
    warning  = 9000000.0
  }
}


resource "datadog_monitor" "monitor_89" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Bytes Sent to Destination is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 700000.0
    warning  = 750000.0
  }
}


resource "datadog_monitor" "monitor_90" {

  tags                = []
  query               = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Packets Sent to Source is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 100000.0
    warning  = 80000.0
  }
}


resource "datadog_monitor" "monitor_91" {

  tags                = []
  query               = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Packets Sent to Source is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 25000.0
    warning  = 27000.0
  }
}


resource "datadog_monitor" "monitor_92" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
  message             = <<EOF
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
  name                = "AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_93" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
  message             = <<EOF
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
  name                = "AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_94" {

  tags                = []
  query               = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
  message             = <<EOF
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
  name                = "AWS NAT - NAT Connection Failures Count is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_95" {

  tags                = []
  query               = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Error Port Allocations is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_96" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
  message             = <<EOF
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
  name                = "Kubernetes -  CPU Total Usage is high on Node"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_97" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_98" {

  tags                = []
  query               = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Node is not OK"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_99" {

  tags                = []
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
  message             = <<EOF
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
  name                = "Kubernetes -  CPU Total Usage is high on Pod"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_100" {

  tags                = []
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
  message             = <<EOF
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
  name                = "Kubernetes -  CPU Total Usage is high on Container"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_101" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 300000.0
    warning  = 200000.0
  }
}


resource "datadog_monitor" "monitor_102" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 15000.0
    warning  = 20000.0
  }
}


resource "datadog_monitor" "monitor_103" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes Transmitted is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 10000.0
    warning  = 15000.0
  }
}


resource "datadog_monitor" "monitor_104" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
  message             = <<EOF
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
  name                = "Kubernetes -  Memory Usage is high on Pod"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_105" {

  tags                = []
  query               = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes Transmitted is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 100000.0
    warning  = 90000.0
  }
}


resource "datadog_monitor" "monitor_106" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
  message             = <<EOF
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
  name                = "Kubernetes -  Memory Usage is high on Container"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_107" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of Unavailable Pods is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_108" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
  message             = <<EOF
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
  name                = "Kubernetes -  Memory Usage is high on Node"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_109" {

  tags                = []
  query               = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Container Has Stopped Working"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_110" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_111" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Admin Sandbox Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid-sandbox.io/version
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on admin.bindid-sandbox.io/version - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_112" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Assets Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 


Summary:Failed HTTP Check on assets.bindid-sandbox.io/Acme.png
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - assets.bindid-sandbox.io/Acme.png
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on assets.bindid-sandbox.io/Acme.png"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_113" {

  tags              = ["Ring1", "Production", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Developer Service has failed @slack-bindid-srv-uptime-alerts  @webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on developer.bindid.io
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - developer.bindid.io
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on developer.bindid.io"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_114" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for IDP Service has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on signin.bindid-sandbox.io/authorize
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - signin.bindid-sandbox.io/authorize
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on signin.bindid-sandbox.io/authorize?client_id=bid_demo_acme&redirect_uri=https:%2F%2Fdemo.bindid-sandbox.io%2F_complete%2Facme&nonce=734586662&state=392980498&bindid_aux_link_title=More%20ways%20to%20verify&bindid_aux_link=https:%2F%2Fdemo.bindid-sandbox.io%2Fother_login&bindid_custom_message=Login%20to%20Acme&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_115" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Auth Server has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on ts.bindid-sandbox.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid-sandbox.io/api/v2/status
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on ts.bindid-sandbox.io/api/v2/status - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_116" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Demo Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on demo.bindid-sandbox.io/initial demoIdentifier=acme 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - demo.bindid-sandbox.io/initial?demoIdentifier=acme
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on demo.bindid-sandbox.io/initial?demoIdentifier=acme"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_117" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_118" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 15
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_119" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_120" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_121" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_122" {

  tags                = []
  query               = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_123" {

  tags                = []
  query               = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
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
  name                = "Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 15
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_124" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
  message             = <<EOF
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
  name                = "Cloudfront - High Avg Response time on CDN"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 700.0
    warning  = 650.0
  }
}


resource "datadog_monitor" "monitor_125" {

  tags                = []
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
  name                = "AWS ALB - 3XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 9.0
    warning  = 7.0
  }
}


resource "datadog_monitor" "monitor_126" {

  tags                = []
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
  name                = "AWS ALB - Average Response Time is High per API Resource"
  priority            = 2
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 0.5
    warning  = 0.3
  }
}


resource "datadog_monitor" "monitor_127" {

  tags         = []
  query        = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message      = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "ELB Monitor - Count 4XX errors on auth server"
  priority     = 1
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_128" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
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
  name                = "Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
  priority            = 2
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
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_129" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
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
  name                = "Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
  priority            = 3
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
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_130" {

  tags                = []
  query               = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
  message             = <<EOF
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
  name                = "Cloudfront - Distribution 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_131" {

  tags                = []
  query               = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
  message             = <<EOF
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
  name                = "Cloudfront - Distribution 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
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
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_132" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
  message             = <<EOF
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
  name                = "Cloudfront - Cache Hit Rate is Low"
  priority            = 2
  type                = "query alert"
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
    critical = 80.0
    warning  = 90.0
  }
}


resource "datadog_monitor" "monitor_133" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
  message             = <<EOF
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
  name                = "Cloudfront - Low Avg Cache Hit Rate"
  priority            = 2
  type                = "query alert"
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
    critical = 80.0
    warning  = 90.0
  }
}


resource "datadog_monitor" "monitor_134" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
  message             = <<EOF
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
  name                = "Cloudfront - Response Time on CDN Distribution is High"
  priority            = 1
  type                = "metric alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 720.0
    warning  = 660.0
  }
}


resource "datadog_monitor" "monitor_135" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
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
  name                = "Cloudfront - Number of Requests Anomaly (Weekly)"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_136" {

  tags         = ["Ring1", ]
  query        = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
  message      = <<EOF
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
  name         = "API's - Response time over 250ms for {{[@http.url_details.path].name}}"
  priority     = 1
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 250000000.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_137" {

  tags         = ["Ring1", ]
  query        = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
  message      = <<EOF
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
  name         = "URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
  priority     = 1
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 250000000.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_138" {

  tags                = []
  query               = "avg(last_1h):avg:aws.applicationelb.target_response_time.average{*} > 0.25"
  message             = "@slack-bindid-srvrefine-uptime-alerts"
  name                = "Terraform - AWS ALB - High Avg Response time on Load Balancer (over 250ms)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.25
    warning           = 0.22
    critical_recovery = 0.2
  }
}


resource "datadog_monitor" "monitor_139" {

  tags              = ["probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Auth Server has failed
Monitor to exclude DNS lookup: https://app.datadoghq.com/monitors/32593392

@webhook-XiteIt

Summary:High Response Time on ts.bindid-sandbox.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid-sandbox.io/api/v2/status
Service:Failed Health - Response Time Check
Value:Response Time is High 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_140" {

  tags              = ["probe_dc:aws:ca-central-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Admin Sandbox Service failed
Monitor to exclude DNS lookup: https://app.datadoghq.com/monitors/32593296
@webhook-XiteIt

Summary:Response Time is High on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid-sandbox.io/version
Service:Failed Health - Response Time Check
Value:Response Time is High
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on admin.bindid-sandbox.io/version - Response time check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_141" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
  message             = <<EOF
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
  name                = "Test on admin.bindid-sandbox.io/version - Response time check"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 250.0
  }
}


resource "datadog_monitor" "monitor_142" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
  message             = <<EOF
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
  name                = "Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 250.0
  }
}


resource "datadog_monitor" "monitor_143" {

  tags                = ["integration:kubernetes", ]
  query               = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
  message             = <<EOF
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
  name                = "[kubernetes] Monitor Kubernetes Deployments Replica Pods"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 5
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 2.0
  }
}


resource "datadog_monitor" "monitor_144" {

  tags                = ["integration:kubernetes", ]
  query               = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
  message             = <<EOF
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
  name                = "[kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_145" {

  tags                = ["integration:kubernetes", ]
  query               = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
  message             = <<EOF
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
  name                = "[kubernetes] Monitor Kubernetes Pods Restarting"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 10
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_146" {

  tags                = ["integration:kubernetes", ]
  query               = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
  message             = <<EOF
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
  name                = "[kubernetes] Monitor Kubernetes Statefulset Replicas"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 2.0
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_147" {

  tags                = ["integration:kubernetes", ]
  query               = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
  message             = <<EOF
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
  name                = "[kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_148" {

  tags                = ["integration:kubernetes", ]
  query               = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
  message             = <<EOF
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
  name                = "[kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 10.0
    warning  = 5.0
  }
}


resource "datadog_monitor" "monitor_149" {

  tags                = ["integration:kubernetes", ]
  query               = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
  message             = <<EOF
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
  name                = "[kubernetes] Monitor Unschedulable Kubernetes Nodes"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 80.0
    warning  = 90.0
  }
}


resource "datadog_monitor" "monitor_150" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.404_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 404 Error Rate is High - Production"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_151" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
  message             = <<EOF
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
  name                = "AWS SES - Number of Opened Emails is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_152" {

  tags                = []
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
  name                = "AWS SES - Number of Successful Emails Sent is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_153" {

  tags                = []
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
  name                = "AWS SES - Number of Bounced Emails is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_154" {

  tags                = []
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
  name                = "AWS SES - Number of Hard Bounced Emails is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_155" {

  tags                = []
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
  name                = "AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_156" {

  tags                = []
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
  name                = "AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_157" {

  tags                = []
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
  name                = "AWS SES - Number of Delivery Attempts is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_158" {

  tags                = []
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
  name                = "AWS SES - Number of Rejected Send Attempts is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 60
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_159" {

  tags         = []
  query        = "logs(\"source:bindid-authentication-server \\\"Could not find credentials for alias\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message      = <<EOF
@slack-cloud-alerts-dev-test

@webhook-XiteIt

Summary:"Could not find credentials for alias" Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High "Could not find credentials for alias" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "UsageIdentityStoreDataAccess Errors"
  priority     = null
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_160" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.401_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 401 Error Rate is High - Production"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_161" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.403_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 403 Error Rate is High - Production"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_162" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on backoffice.bindid-sandbox.io/api/auth/google
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:backoffice.bindid-sandbox.io/api/auth/google
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on backoffice.bindid-sandbox.io/api/auth/google - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_163" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on my.bindid-sandbox.io/manage/login

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:my.bindid-sandbox.io/manage/login
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on my.bindid-sandbox.io/manage/login - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_164" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on aux.bindid-sandbox.io/ciba

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:aux.bindid-sandbox.io/ciba
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on aux.bindid-sandbox.io/ciba - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_165" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"User Cancellation\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors  - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User Cancellation - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_166" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Ticket consumption errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number - Production
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Ticket consumption errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_167" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Recovery Journey Invocations - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_168" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:* @http.status_code:(400 OR 401 OR 404) @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized, non foreign 
Service: Number of 4XX Errors - Production
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "4XX: End-Users - Uncategorized, non-foreign - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_169" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized 
Service:4XX Errors - Production
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "4XX: Backend & Management - Uncategorized, non-foreign - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_170" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend & Management - unsupported_grant - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_171" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend & Management – invalid_grant - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_172" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"End User - invalid_client\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "End User - invalid_client - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_173" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid Request - Invalid redirect URI on /authorize - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_174" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid Request - Missing client_id on /authorize - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_175" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid authentication to BindID Backend API - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_176" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid client credentials on /token - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_177" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Number of \"Alias already set\" Errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_178" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10.8"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User not found for backend/management support APIs - Categorized - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User not found for backend/management support APIs - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.8
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_179" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Management Console Bad Logins\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Management Console Bad Logins - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_180" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"FIDO Registration Failures\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "FIDO Registration Failures - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_181" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid HTTP Method: Frontend/End-User - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_182" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"500: End-Users\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "500: End-Users - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_183" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"500: Backend & Management\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "500: Backend & Management - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_184" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"User not found errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User not found errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_185" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Device not found errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Device not found errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_186" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"OIDC /complete with errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "OIDC /complete with errors - Categorized" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  OIDC /complete with errors - Categorized - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "OIDC /complete with errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_187" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Expression evaluation errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Expression evaluation errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_188" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "All Invalid Request Errors on /authorize - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_189" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid HTTP Method: Backend/Management - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_190" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
  name              = "OIDC Backend invalid_request errors - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_191" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Unknown authorization code on /token - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_192" {

  tags              = []
  query             = "logs(\"@error_category:\\\"Foreign errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
This error can be dismissed. Monitor used if needed in the future

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Foreign errors - Categorized - Production"
  priority          = 5
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_193" {

  tags              = ["Ring1", "Production", "probe_dc:aws:ca-central-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Admin Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid.io/version
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on admin.bindid.io/version - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_194" {

  tags              = ["Ring1", "Sandbox", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Admin Sandbox Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on mobile.bindid-sandbox.io
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - mobile.bindid-sandbox.io
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on mobile.bindid-sandbox.io - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_195" {

  tags              = ["Ring1", "Production", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on aux.bindid.io/ciba

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:aux.bindid.io/ciba
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on aux.bindid.io/ciba - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_196" {

  tags              = ["Ring1", "Production", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on backoffice.bindid.io/api/auth/google
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:backoffice.bindid.io/api/auth/google
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on backoffice.bindid.io/api/auth/google - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_197" {

  tags              = ["Ring1", "Production", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Demo Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on demo.bindid.io/initial demoIdentifier=acme 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - demo.bindid.io/initial?demoIdentifier=acme
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on demo.bindid.io/initial?demoIdentifier=acme"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_198" {

  tags              = ["Ring1", "Production", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on my.bindid.io/manage/login

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:my.bindid.io/manage/login
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on my.bindid.io/manage/login - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_199" {

  tags              = ["Ring1", "Production", "probe_dc:aws:us-east-2", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Auth Server has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on ts.bindid.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid.io/api/v2/status
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on ts.bindid.io/api/v2/status - 200 status code check"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_200" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid.io/version} > 250"
  message             = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Test on admin.bindid.io/version - Response time check"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 250.0
  }
}


resource "datadog_monitor" "monitor_201" {

  tags                = ["Ring1", "Production", ]
  query               = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
  message             = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Test on ts.bindid.io/api/v2/status - Response time check"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 250.0
  }
}


resource "datadog_monitor" "monitor_202" {

  tags              = ["Ring1", "Production", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for Assets Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 


Summary:Failed HTTP Check on assets.bindid.io/app_c50756a4_TransmitLogo.jpg
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - assets.bindid.io//app_c50756a4_TransmitLogo.jpg
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on assets.bindid.io/app_c50756a4_TransmitLogo.jpg"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_203" {

  tags              = ["Ring1", "Production", "probe_dc:aws:eu-west-1", "check_type:api", "check_status:live", ]
  query             = "no_query"
  message           = <<EOF
Health Check for IDP Service has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on signin.bindid.io/authorize
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - signin.bindid.io/authorize
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "[Synthetics] Test on signin.bindid.io/authorize?client_id=be415353.c50756a4.dev_36434736.bindid.io&redirect_uri=https%3A%2F%2Fdemo.bindid.io%2Fsynthetic-monitoring-request&nonce=666666666&state=123456789&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
  priority          = null
  type              = "synthetics alert"
  notify_audit      = false
  locked            = false
  include_tags      = true
  new_host_delay    = 300
  notify_no_data    = false
  renotify_interval = 0
}


resource "datadog_monitor" "monitor_204" {

  tags               = []
  query              = "logs(\"service:cloudfront -@http.url_details.path:(\\/favicon* OR \\\"/robots.txt\\\" OR \\/apple-touch-icon*) @http.ident:*bindid-sandbox.io @http.status_code:[400 TO 499]\").index(\"*\").rollup(\"count\").last(\"15m\") > 25"
  message            = <<EOF
@slack-cloud-alerts-bindid-prd 

Summary:P1 - {{value}} High 4XX Errors count on Sandbox 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:Cloudfront 
Service:High 4XX Errors count on Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "Cloudfront - High 4XX Errors count on Sandbox"
  priority           = 5
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = false
  monitor_thresholds {
    critical = 25.0
  }
  new_host_delay = 300
  notify_no_data = false
  include_tags   = true
}


resource "datadog_monitor" "monitor_205" {

  tags               = []
  query              = "logs(\"service:cloudfront -@http.url_details.path:(\\/favicon* OR \\\"/robots.txt\\\" OR \\/apple-touch-icon*) @http.ident:*bindid.io @http.status_code:[400 TO 499]\").index(\"*\").rollup(\"count\").last(\"15m\") > 10"
  message            = <<EOF
@slack-cloud-alerts-bindid-prd

Summary:P1 - {{value}} High 4XX Errors count on Production 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:Cloudfront 
Service:High 4XX Errors count on Production 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "Cloudfront - High 4XX Errors count on Production"
  priority           = 5
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = false
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay = 300
  notify_no_data = false
  include_tags   = true
}


resource "datadog_monitor" "monitor_206" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:backend @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Backend - Invalid Request on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Backend - Invalid Request - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend - Invalid Request - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_207" {

  tags              = ["Ring1", "Production", ]
  query             = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:enduser @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - End User - Invalid Request on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:End User - Invalid Request - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "End User - Invalid Request - Categorized - Production"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_208" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 2"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized 
Service:4XX Errors - Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "4XX: Backend & Management - Uncategorized, non-foreign - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 2.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_209" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"500: Backend & Management\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Number of 500 Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "500: Backend & Management - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_210" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"500: End-Users\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "500: End-Users - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_211" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "All Invalid Request Errors on /authorize - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_212" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend & Management - unsupported_grant - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_213" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants  - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend & Management – invalid_grant - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_214" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"End User - invalid_client\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "End User - invalid_client - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_215" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"FIDO Registration Failures\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "FIDO Registration Failures - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_216" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid HTTP Method: Backend/Management - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_217" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid HTTP Method: Frontend/End-User - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_218" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid Request - Invalid redirect URI on /authorize - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_219" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid Request - Missing client_id on /authorize - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_220" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid authentication to BindID Backend API - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_221" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Invalid client credentials on /token - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_222" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Management Console Bad Logins\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins  - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Management Console Bad Logins - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_223" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Number of \"Alias already set\" Errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_224" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 25"
  message           = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of OIDC Backend invalid_request errors - Categorized - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
  name              = "OIDC Backend invalid_request errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 25.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_225" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Recovery Journey Invocations - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_226" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Ticket consumption errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number - Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Ticket consumption errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_227" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Unknown authorization code on /token - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_228" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:* @http.status_code:(400 OR 401 OR 404) @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 36"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized, non foreign 
Service: Number of 4XX Errors - Sandbox
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "4XX: End-Users - Uncategorized, non-foreign - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 36.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_229" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:backend @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 6"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Backend - Invalid Request on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Backend - Invalid Request - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Backend - Invalid Request - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 6.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_230" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Device not found errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 2"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Device not found errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 2.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_231" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:enduser @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - End User - Invalid Request on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:End User - Invalid Request - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "End User - Invalid Request - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_232" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"Expression evaluation errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Expression evaluation errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_233" {

  tags              = []
  query             = "logs(\"@error_category:\\\"Foreign errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
This error can be dismissed. Monitor used if needed in the future

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "Foreign errors - Categorized - Sandbox"
  priority          = 5
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_234" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"OIDC /complete with errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "OIDC /complete with errors - Categorized" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  OIDC /complete with errors - Categorized - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "OIDC /complete with errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_235" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"User Cancellation\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 7"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User Cancellation - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 7.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_236" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"User not found errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message           = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User not found errors - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_237" {

  tags              = ["Ring1", "Sandbox", ]
  query             = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10.8"
  message           = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User not found for backend/management support APIs - Categorized - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name              = "User not found for backend/management support APIs - Categorized - Sandbox"
  priority          = 1
  type              = "log alert"
  notify_audit      = false
  locked            = false
  timeout_h         = 0
  renotify_interval = 0
  include_tags      = true
  monitor_thresholds {
    critical = 10.8
  }
  new_host_delay     = 300
  notify_no_data     = false
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_238" {

  tags               = []
  query              = "logs(\"service:cloudfront @http.url_details.path:\\\"/registration-result\\\" @http.useragent:\\\"-\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
@slack-cloud-alerts-bindid-prd @webhook-XiteIt

Summary:P1 - {{value}} Cloudfront error hits on /registration-result with no useragent
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/registration-result
Service:Cloudfront error hits
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "Cloudfront error hits on /registration-result with no useragent"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = false
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay = 300
  notify_no_data = false
  include_tags   = true
}


resource "datadog_monitor" "monitor_239" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} > 5"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 4XX Error Rate is High - Sandbox"
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
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_240" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} > 5"
  message             = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 5XX Error Rate is High - Sandbox"
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
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_241" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.401_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 401 Error Rate is High - Sandbox"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_242" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.403_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 403 Error Rate is High - Sandbox"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  evaluation_delay    = 900
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_243" {

  tags                = ["Ring1", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.404_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message             = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "Cloudfront - 404 Error Rate is High - Sandbox"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_244" {

  tags                = ["integration:kubernetes", ]
  query               = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
  message             = <<EOF
More than one Deployments Replica's pods are down.

webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - [Kubernetes] Monitor Kubernetes Deployments Replica Pods"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  include_tags        = true
  no_data_timeframe   = 5
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  monitor_thresholds {
    critical = 2.0
  }
}


resource "datadog_monitor" "monitor_245" {

  tags                = ["#####", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} > 5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 4XX Error Rate is High - Production"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_246" {

  tags                = []
  query               = "sum(last_1h):avg:mongodb.atlas.system.disk.iops.total{*}.as_count() > 30000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Avg Total Disk IOPS is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 30000.0
    warning           = 28000.0
    critical_recovery = 25000.0
  }
}


resource "datadog_monitor" "monitor_247" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.mem.resident{*} > 2050"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - Process Memory Usage on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Process Memory Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Process Memory Usage is high"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 2050.0
    warning  = 1840.0
  }
}


resource "datadog_monitor" "monitor_248" {

  tags                = []
  query               = "sum(last_10m):sum:mongodb.atlas.opcounters.query{*}.as_count() > 2000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt


Summary:P2 - Number of MongoDB Read Requests is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Read Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Number of Read Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 2000.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_249" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.connections.current{*} > 75"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

 webhook-XiteIt

Summary:P3 - {{value}} Current Connections on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Current Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Number of Current Connections is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 75.0
    warning  = 65.0
  }
}


resource "datadog_monitor" "monitor_250" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} + avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{*} > 1.5"
  message             = "Indexing queries and returned results may be slow slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Query Efficiency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 1.5
    warning           = 1.3
    critical_recovery = 1.3
  }
}


resource "datadog_monitor" "monitor_251" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Avg CPU Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 8.0
    warning           = 7.0
    critical_recovery = 7.0
  }
}


resource "datadog_monitor" "monitor_252" {

  tags                = ["#####", "Production", ]
  query               = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} > 5"
  message             = <<EOF
slack-bindid-prd-alerts
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 5XX Error Rate is High - Production"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_253" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Expression evaluation errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Expression evaluation errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_254" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.oplatencies.writes.avg{host:production-shard-00-01.dmun4.mongodb.net} > 0.5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - Write Operations Latency on production-shard-00-01.dmun4.mongodb.net is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB - production-shard-00-01.dmun4.mongodb.net
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB [production-shard-00-01.dmun4.mongodb.net] - Write Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 0.5
    warning  = 0.45
  }
}


resource "datadog_monitor" "monitor_255" {

  tags                = []
  query               = "sum(last_10m):avg:mongodb.atlas.system.disk.iops.percentutilization{*} > 50"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Avg of IOPS Disk Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg of IOPS Disk Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Avg of IOPS Disk Usage is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_256" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{*} by {host} > 1.5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt

Summary:P2 - {{value}}  Inefficient Queries on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:High Number of Inefficient Queries
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Number of Inefficient Queries is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 1.5
    warning  = 1.2
  }
}


resource "datadog_monitor" "monitor_257" {

  tags                = []
  query               = "avg(last_1h):max:mongodb.atlas.system.disk.space.free{*} - max:mongodb.atlas.system.disk.space.used{*} < 10000000000"
  message             = "This alert triggers when disk space is below 10GB out of 90GB. slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Max Disk Space Is Low"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 10000000000.0
    warning           = 11000000000.0
    critical_recovery = 11000000000.0
  }
}


resource "datadog_monitor" "monitor_258" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.oplatencies.reads.avg{*} by {host} > 0.3"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt

Summary:P2 - Read Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Read Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Read Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 0.3
    warning  = 0.2
  }
}


resource "datadog_monitor" "monitor_259" {

  tags                = []
  query               = "sum(last_10m):sum:mongodb.atlas.opcounters.delete{*} + sum:mongodb.atlas.opcounters.insert{*}.as_count() + sum:mongodb.atlas.opcounters.update{*}.as_count() > 2000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2
webhook-XiteIt 

Summary:P2 - Number of MongoDB Write Requests is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Number of Write Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Number of Write Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 2000.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_260" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{!host:production-shard-00-01.dmun4.mongodb.net} by {host} > 0.14"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2 

webhook-XiteIt


Summary:P2 - Write Operations Latency on MongoDB is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Write Operations Latency
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Write Operations Latency is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 0.14
    warning           = 0.13
    critical_recovery = 0.13
  }
}


resource "datadog_monitor" "monitor_261" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.disk.space.free{*} > 98500000000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Avg Disk Space Has Exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 98500000000.0
    warning           = 97000000000.0
    critical_recovery = 97000000000.0
  }
}


resource "datadog_monitor" "monitor_262" {

  tags                = []
  query               = "avg(last_4h):anomalies(top(max:mongodb.atlas.system.disk.space.percentused{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= 1"
  message             = "Hostname:{{hostnameport.name}} has Max Disk Space used.  slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Top hosts by disk space used (Percentage)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_threshold_windows {
    recovery_window = "last_30m"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 1.0
    warning           = 0.8
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_263" {

  tags                = []
  query               = "sum(last_10m):min:mongodb.atlas.system.disk.space.free{*} by {host} < 70000000000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1

webhook-XiteIt 
Summary:P1 - {{value}} Free Disk Space on MongoDB:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB:{{host}}
Service:Low Free Disk Space
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Free Disk Space is Low"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 70000000000.0
    warning  = 80000000000.0
  }
}


resource "datadog_monitor" "monitor_264" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.opcounters.delete{*}.as_rate() + avg:mongodb.atlas.opcounters.insert{*}.as_rate() + sum:mongodb.atlas.opcounters.update{*}.as_rate() > 2"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Write Requests (Per Second) throughput is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 2.0
    warning           = 1.9
    critical_recovery = 1.7
  }
}


resource "datadog_monitor" "monitor_265" {

  tags                = []
  query               = "avg(last_4h):anomalies(top(max:mongodb.atlas.system.cpu.norm.user{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= 1"
  message             = "Hostname:{{hostnameport.name}} has Max CPU Usage  slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Top Hosts with Max CPU Usage"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_threshold_windows {
    recovery_window = "last_30m"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 1.0
    warning           = 0.9
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_266" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.system.mem.resident{*} > 1750"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Process Memory Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 1750.0
    warning           = 1740.0
    critical_recovery = 1740.0
  }
}


resource "datadog_monitor" "monitor_267" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.connections.current{*} > 100"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Number of current connections is above 100"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 100.0
    warning           = 95.0
    critical_recovery = 95.0
  }
}


resource "datadog_monitor" "monitor_268" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.reads.avg{*} > 0.13"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Read Operations have a high average latency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.13
    warning           = 0.12
    critical_recovery = 0.12
  }
}


resource "datadog_monitor" "monitor_269" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.metrics.document.returned{*}.as_rate() > 100"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Document Reads"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 100.0
    warning           = 98.0
    critical_recovery = 95.0
  }
}


resource "datadog_monitor" "monitor_270" {

  tags                = []
  query               = "avg(last_1h):max:mongodb.atlas.system.cpu.norm.guest{*} + max:mongodb.atlas.system.cpu.norm.iowait{*} + max:mongodb.atlas.system.cpu.norm.irq{*} + max:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + max:mongodb.atlas.system.cpu.norm.nice{*} + max:mongodb.atlas.system.cpu.norm.softirq{*} + max:mongodb.atlas.system.cpu.norm.steal{*} + max:mongodb.atlas.system.cpu.norm.user{*} > 12"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Max CPU Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 12.0
    warning           = 11.0
    critical_recovery = 11.0
  }
}


resource "datadog_monitor" "monitor_271" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.opcounters.getmore{*}.as_rate() + sum:mongodb.atlas.opcounters.query{*}.as_rate() > 9"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Read Requests (Per Second) throughput is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 9.0
    warning           = 8.7
    critical_recovery = 8.0
  }
}


resource "datadog_monitor" "monitor_272" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.oplatencies.writes.avg{*} > 0.5"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Write Operations have a high average latency"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.45
    critical_recovery = 0.45
  }
}


resource "datadog_monitor" "monitor_273" {

  tags                = []
  query               = "avg(last_1h):sum:mongodb.atlas.metrics.document.deleted{*}.as_rate() + sum:mongodb.atlas.metrics.document.inserted{*}.as_rate() + sum:mongodb.atlas.metrics.document.updated{*}.as_rate() > 4"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Document Writes"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 4.0
    warning           = 3.8
    critical_recovery = 3.6
  }
}


resource "datadog_monitor" "monitor_274" {

  tags                = []
  query               = "avg(last_1h):avg:mongodb.atlas.cursors.totalopen{*} > 0.9"
  message             = "When a read query is received, MongoDB returns a cursor which represents a pointer to the data (documents). This cursor remains open on the server, consuming memory and large amount of memory being consumed can cause application issues. slack-cloud-alerts-bindid-prd"
  name                = "TF - MongoDB - Total Cursors"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.9
    warning           = 0.7
    critical_recovery = 0.7
  }
}


resource "datadog_monitor" "monitor_275" {

  tags                = []
  query               = "avg(last_10m):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 
Summary:P2 - Avg Tasks CPU Usage is {{value}} on MongoDB
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:MongoDB
Service:High Avg Tasks CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - MongoDB - Avg Tasks CPU Usage is high"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical          = 8.0
    warning           = 7.0
    critical_recovery = 7.0
  }
}


resource "datadog_monitor" "monitor_276" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid client credentials on /token - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_277" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Number of \"Alias already set\" Errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_278" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Foreign errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Foreign errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_279" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - All Invalid Request Errors on /authorize - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_280" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"User not found errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User not found errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_281" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"OIDC /complete with errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt 

Summary:P1 - "OIDC /complete with errors - Categorized" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  OIDC /complete with errors - Categorized - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - OIDC /complete with errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_282" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"End User - invalid_client\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - End User - invalid_client - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_283" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
webhook-Uptime-XiteIt
slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend & Management – invalid_grant - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_284" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Expression evaluation errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Expression evaluation errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_285" {

  tags               = []
  query              = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message            = <<EOF
slack-p-bindid-selfserve-success-alerts
Priority:-

webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - BindID Self Serve Successful Registrations on env: BindID Production"
  priority           = null
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_286" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Unknown authorization code on /token - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_287" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Management Console Bad Logins\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins  - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Management Console Bad Logins - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_288" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid Request - Invalid redirect URI on /authorize - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_289" {

  tags               = ["#####", ]
  query              = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 250000000.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_290" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:* @http.status_code:(400 OR 401 OR 404) @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized, non foreign 
Service: Number of 4XX Errors - Sandbox
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 4XX: End-Users - Uncategorized, non-foreign - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_291" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"FIDO Registration Failures\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - FIDO Registration Failures - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_292" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
EOF
  name               = "TF - OIDC Backend invalid_request errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_293" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid Request - Missing client_id on /authorize - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_294" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"User not found errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User not found errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_295" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"FIDO Registration Failures\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - FIDO Registration Failures - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_296" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Recovery Journey Invocations - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_297" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid HTTP Method: Frontend/End-User - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_298" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend & Management - unsupported_grant - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_299" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Foreign errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Foreign errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_300" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend & Management - unsupported_grant - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_301" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"500: End-Users\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 500: End-Users - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_302" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"User Cancellation\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors  - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User Cancellation - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_303" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Recovery Journey Invocations - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_304" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Ticket consumption errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number - Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Ticket consumption errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_305" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid client credentials on /token - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_306" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Device not found errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Device not found errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_307" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid HTTP Method: Backend/Management - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_308" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:* @http.status_code:(400 OR 401 OR 404) @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized, non foreign 
Service: Number of 4XX Errors - Production
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 4XX: End-Users - Uncategorized, non-foreign - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_309" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized 
Service:4XX Errors - Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 4XX: Backend & Management - Uncategorized, non-foreign - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_310" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"OIDC /complete with errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt 

Summary:P1 - "OIDC /complete with errors - Categorized" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  OIDC /complete with errors - Categorized - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - OIDC /complete with errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_311" {

  tags               = []
  query              = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
  message            = <<EOF
slack-p-bindid-selfserve-failure-alerts
Priority:-
webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - BindID Self Serve Failed Registrations on env: BindID Production"
  priority           = null
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_312" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
EOF
  name               = "TF - OIDC Backend invalid_request errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_313" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10.8"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User not found for backend/management support APIs - Categorized - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User not found for backend/management support APIs - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 10.8
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_314" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized 
Service:4XX Errors - Production
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 4XX: Backend & Management - Uncategorized, non-foreign - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_315" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid HTTP Method: Backend/Management - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_316" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Device not found errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Device not found errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_317" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid authentication to BindID Backend API - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_318" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Ticket consumption errors\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number - Production
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Ticket consumption errors - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_319" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Unknown authorization code on /token - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_320" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:backend @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Backend - Invalid Request on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Backend - Invalid Request - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend - Invalid Request - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_321" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid authentication to BindID Backend API - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_322" {

  tags               = []
  query              = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
  message            = <<EOF
slack-bindid-prd-alerts
Priority:-

webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - BindId Service Errors on env: BindID Production"
  priority           = null
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_323" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:backend @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Backend - Invalid Request on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Backend - Invalid Request - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend - Invalid Request - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_324" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid Request - Invalid redirect URI on /authorize - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_325" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10.8"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User not found for backend/management support APIs - Categorized - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User not found for backend/management support APIs - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 10.8
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_326" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
webhook-Uptime-XiteIt
slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants  - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Backend & Management – invalid_grant - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_327" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"500: Backend & Management\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Number of 500 Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 500: Backend & Management - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_328" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - All Invalid Request Errors on /authorize - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_329" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"500: End-Users\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 500: End-Users - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 3.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_330" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid HTTP Method: Frontend/End-User - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_331" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"500: Backend & Management\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - 500: Backend & Management - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_332" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:enduser @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - End User - Invalid Request on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:End User - Invalid Request - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - End User - Invalid Request - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_333" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Invalid Request - Missing client_id on /authorize - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_334" {

  tags               = ["#####", ]
  query              = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 250000000.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_335" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"User Cancellation\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - User Cancellation - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_336" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Management Console Bad Logins\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console - Production
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Management Console Bad Logins - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_337" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"End User - invalid_client\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - End User - invalid_client - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_338" {

  tags               = ["#####", "Sandbox", ]
  query              = "logs(\"@error_category:\\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Number of \"Alias already set\" Errors - Categorized - Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_339" {

  tags         = ["#####", "Sandbox", ]
  query        = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
  message      = <<EOF
slack-bindid-srv-uptime-alerts 
webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Test on admin.bindid-sandbox.io/version - Response time check"
  priority     = 1
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 250.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_340" {

  tags                = []
  query               = "sum(last_1h):avg:aws.ses.send{*} / avg:aws.ses.send.sum{*} < 1"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt
 
Summary:P3 - Number of Successful Emails Sent is Low
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:Low Number of Successful Emails Sent
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Successful Emails Sent is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_341" {

  tags         = ["#####", "Sandbox", ]
  query        = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
  message      = <<EOF
slack-bindid-srv-uptime-alerts 
webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
  priority     = 1
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 250.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_342" {

  tags               = ["#####", "Production", ]
  query              = "logs(\"@error_category:\\\"Invalid Request\\\" @api_audience:enduser @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt

Summary:P1 - End User - Invalid Request on bindid-authentication-server is {{value}} - Production
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:End User - Invalid Request - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - End User - Invalid Request - Categorized - Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
}


resource "datadog_monitor" "monitor_343" {

  tags                = []
  query               = "avg(last_15m):avg:aws.applicationelb.target_response_time.average{environment:production} by {ingress.k8s.aws/resource} > 0.5"
  message             = <<EOF
slack-cloud-alerts-dev-test
Priority:P1
webhook-XiteIt 

Summary:P2 - Average Response Time is {{value}} on {{ingress.k8s.aws/resource}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Average Response Time per API Resource
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Average Response Time is High per API Resource"
  priority            = 2
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.5
    warning  = 0.3
  }
}


resource "datadog_monitor" "monitor_344" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
webhook-XiteIt 

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
  name                = "TF - Cloudfront - High Avg Response time on CDN"
  priority            = 1
  type                = "metric alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 700.0
    warning  = 650.0
  }
}


resource "datadog_monitor" "monitor_345" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ses.delivery.sum{*} / sum:aws.ses.send{*} < 1"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt
 
Summary:P3 - Number of Emails Successfully Delivered to The Recipient's Server is Low
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:Low Number of Emails Successfully Delivered to The Recipient's Server
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Emails Successfully Delivered to The Recipient's Server is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_346" {

  tags                = []
  query               = "sum(last_1h):avg:aws.ses.rejects{*} > 5"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt
 
Summary:P3 - {{value}} Rejected Send Attempts 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Rejected Send Attempts
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Rejected Send Attempts is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_347" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
shahdtransmitsecurity.com slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_348" {

  tags         = []
  query        = "sum(last_1h):sum:aws.applicationelb.httpcode_elb_4xx{*} by {host}.as_count() > 250"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - AWS ELB - High load of 4xx HTTPCode in total"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = false
  monitor_thresholds {
    critical          = 250.0
    warning           = 220.0
    critical_recovery = 180.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_349" {

  tags                = []
  query               = "avg(last_1h):avg:aws.ec2.cpuutilization{*} > 25"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - AWS EC2 - CPU Avg Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 25.0
    warning           = 22.0
    critical_recovery = 20.0
  }
}


resource "datadog_monitor" "monitor_350" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Bytes Sent to Destination is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 10000000.0
    warning  = 9000000.0
  }
}


resource "datadog_monitor" "monitor_351" {

  tags                = []
  query               = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1

webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Distribution 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_352" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_353" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.volume_write_ops{environment:production,!host:i-0bad31cb7d1ea95a0,!host:i-0210258000ee05a99} by {host}.as_count() > 120000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - Number of Write Ops is {{value}} on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Write Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - EBS - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 120000.0
    warning  = 110000.0
  }
}


resource "datadog_monitor" "monitor_354" {

  tags                = []
  query               = "sum(last_1h):max:aws.natgateway.active_connection_count{*}.as_count() >= 55000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - AWS NAT - High Count of Active Connections"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 55000.0
    warning           = 50000.0
    critical_recovery = 30000.0
  }
}


resource "datadog_monitor" "monitor_355" {

  tags                = []
  query               = "avg(last_1h):sum:aws.applicationelb.request_count{*}.as_rate() > 0.67"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - AWS ELB - Total Request Count Status (Peaks/Drops)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 0.67
    warning           = 0.65
    critical_recovery = 0.63
  }
}


resource "datadog_monitor" "monitor_356" {

  tags                = []
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_elb_3xx{environment:production}.as_count() > 9"
  message             = <<EOF
Inactive
webhook-XiteIt 

Summary:P1 - 3XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:3XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - 3XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 9.0
    warning  = 7.0
  }
}


resource "datadog_monitor" "monitor_357" {

  tags                = []
  query               = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Distribution 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_358" {

  tags                = []
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_target_5xx{environment:production} by {targetgroup}.as_count() > 5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1
webhook-XiteIt 

Summary:P1 - 5XX Error Rate is {{value}}on {{targetgroup}} 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Target 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_359" {

  tags                = []
  query               = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Packets Sent to Source is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 25000.0
    warning  = 27000.0
  }
}


resource "datadog_monitor" "monitor_360" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Number of Requests Anomaly (Weekly)"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_361" {

  tags         = ["#####", "Sandbox", ]
  query        = "avg(last_15m):avg:aws.cloudfront.403_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 403 Error Rate is High - Sandbox"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_362" {

  tags                = []
  query               = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Error Port Allocations is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_363" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_364" {

  tags               = ["#####", ]
  query              = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message            = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - ELB Monitor - Count 4XX errors on auth server"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_365" {

  tags               = ["#####", ]
  query              = "logs(\"service:cloudfront -@http.url_details.path:(\\/favicon* OR \\\"/robots.txt\\\" OR \\/apple-touch-icon*) @http.ident:*bindid-sandbox.io @http.status_code:[400 TO 499]\").index(\"*\").rollup(\"count\").last(\"15m\") > 25"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}} High 4XX Errors count on Sandbox 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:Cloudfront 
Service:High 4XX Errors count on Sandbox
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Cloudfront - High 4XX Errors count on Sandbox"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = false
  monitor_thresholds {
    critical = 25.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_366" {

  tags                = []
  query               = "sum(last_1h):avg:aws.ses.bounces{*} > 5"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt
 
Summary:P3 - {{value}} Hard Bounced Emails 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Hard Bounced Emails
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Hard Bounced Emails is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_367" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Low Avg Cache Hit Rate"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 80.0
    warning  = 90.0
  }
}


resource "datadog_monitor" "monitor_368" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3
webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_369" {

  tags                = []
  query               = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > 0"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1

webhook-XiteIt 

Summary:P1 - {{value}} Failed Host Checks on AWS EC2

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS ALB
Service:Number of Failed Host Checks
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS EC2 - Number of Failed Host Checks is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_370" {

  tags                = []
  query               = "sum(last_15m):max:aws.applicationelb.target_response_time.maximum{environment:production} by {targetgroup} > 3"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1

webhook-XiteIt 

Summary:P1 - Response Time is {{value}} on {{targetgroup}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Respone Time per Target Group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Target Respone Time is too High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 3.0
    warning  = 2.0
  }
}


resource "datadog_monitor" "monitor_371" {

  tags                = ["targetgroup", ]
  query               = "sum(last_15m):avg:aws.applicationelb.httpcode_target_4xx{environment:production} by {targetgroup}.as_count() > 10"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
webhook-XiteIt 

Summary:P1 - 4XX Error Rate is {{value}} on {{targetgroup}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate per target group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Target 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 10.0
    warning  = 6.0
  }
}


resource "datadog_monitor" "monitor_372" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.volume_read_ops{environment:production} by {host}.as_count() > 25"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3
webhook-XiteIt 

Summary:P3 - {{value}}  Read Ops on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Read Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - EBS - Number of Read Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 25.0
    warning  = 20.0
  }
}


resource "datadog_monitor" "monitor_373" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Source Bytes Received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 2200000.0
    warning  = 1800000.0
  }
}


resource "datadog_monitor" "monitor_374" {

  tags                = ["#####", ]
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count() > 50"
  message             = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - 4XX Error Rate is {{value}} on AWS ALB 

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - 4XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 50.0
    warning  = 30.0
  }
}


resource "datadog_monitor" "monitor_375" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Bytes Sent to Destination is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 700000.0
    warning  = 750000.0
  }
}


resource "datadog_monitor" "monitor_376" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Response Time on CDN Distribution is High"
  priority            = 1
  type                = "metric alert"
  notify_audit        = true
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 720.0
    warning  = 660.0
  }
}


resource "datadog_monitor" "monitor_377" {

  tags         = ["#####", "Sandbox", ]
  query        = "avg(last_15m):avg:aws.cloudfront.401_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 401 Error Rate is High - Sandbox"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_378" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0bad31cb7d1ea95a0} by {host}.as_count() > 2000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - Number of Write Ops is {{value}}  on {{host}}
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS {{host}}
Service:High Number of Write Ops
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - EBS [i-0bad31cb7d1ea95a0] - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 900
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 2000.0
    warning  = 1700.0
  }
}


resource "datadog_monitor" "monitor_379" {

  tags                = []
  query               = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() > 4000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
webhook-XiteIt 
Summary:P2 - Number of ALB total Requests is {{value}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Requests is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Number of Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 4000.0
    warning  = 3000.0
  }
}


resource "datadog_monitor" "monitor_380" {

  tags                = []
  query               = "avg(last_1h):max:aws.ec2.cpuutilization.maximum{*} > 100"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - AWS EC2 - CPU Max Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 100.0
    warning           = 95.0
    critical_recovery = 90.0
  }
}


resource "datadog_monitor" "monitor_381" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.applicationelb.request_count{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4
webhook-XiteIt 

Summary:P4 - Requests Anomaly - Number of Weekly Requests is {{value}}

Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS ALB
Service:Number of Requests (Weekly)
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB Requests Anomaly - Number of Requests (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_382" {

  tags               = ["#####", ]
  query              = "logs(\"service:cloudfront -@http.url_details.path:(\\/favicon* OR \\\"/robots.txt\\\" OR \\/apple-touch-icon*) @http.ident:*bindid.io @http.status_code:[400 TO 499]\").index(\"*\").rollup(\"count\").last(\"15m\") > 10"
  message            = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - {{value}} High 4XX Errors count on Production 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:Cloudfront 
Service:High 4XX Errors count on Production 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name               = "TF - Cloudfront - High 4XX Errors count on Production"
  priority           = 1
  type               = "log alert"
  notify_audit       = false
  locked             = false
  enable_logs_sample = false
  monitor_thresholds {
    critical = 10.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  include_tags        = true
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_383" {

  tags                = []
  query               = "avg(last_15m):avg:aws.applicationelb.healthy_host_count.minimum{*} by {targetgroup} < 1"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2
webhook-XiteIt 

Summary:P1 - Number of Healthy Hosts is {{value}} in TG: {{targetgroup}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Healthy Hosts is Low per Target Group
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Number of Healthy Hosts is Low"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_384" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_in.maximum{*} > 6000000"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - AWS EC2 - Network In Max Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 6000000.0
    warning           = 4600000.0
    critical_recovery = 4100000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_385" {

  tags         = ["#####", "Sandbox", ]
  query        = "avg(last_15m):avg:aws.cloudfront.404_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 404 Error Rate is High - Sandbox"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_386" {

  tags                = []
  query               = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Number of Requests is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 2500.0
    warning  = 1500.0
  }
}


resource "datadog_monitor" "monitor_387" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ses.bounce.sum{*} > 5"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt 
Summary:P3 - {{value}} Bounced Emails on AWS SES
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:High number of Bounced Emails
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Bounced Emails is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_388" {

  tags                = ["#####", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} > 5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 4XX Error Rate is High - Sandbox"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_389" {

  tags                = []
  query               = "sum(last_1h):count:aws.ses.deliveryattempts{*} / count:aws.ses.send{*} > 1"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt 
Summary:P3 - Number of Delivery Attempts is High
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:High Number of Delivery Attempts
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Delivery Attempts is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_390" {

  tags                = ["#####", "Sandbox", ]
  query               = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va} > 5"
  message             = <<EOF
slack-bindid-prd-alerts
slack-bindid-srv-uptime-alerts
webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront - Sandbox
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 5XX Error Rate is High - Sandbox"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_391" {

  tags                = []
  query               = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Packets Sent to Source is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 100000.0
    warning  = 80000.0
  }
}


resource "datadog_monitor" "monitor_392" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Destination Bytes Received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 2000000.0
    warning           = 1900000.0
    critical_recovery = 1480000.0
  }
}


resource "datadog_monitor" "monitor_393" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_394" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.5
    warning           = 0.4
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_395" {

  tags                = []
  query               = "sum(last_15m):sum:aws.ebs.status.ok{*} < 8"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3
webhook-XiteIt 

Summary:P3 - {{value}} EBS Volumes are with Status OK 
Critical Threshold:{{threshold}}ops
Warning Threshold:{{warn_threshold}}ops

Host:AWS EBS
Service:Low Number of Volumes with Status OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - EBS - Number of Volumes with Status OK is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 8.0
  }
}


resource "datadog_monitor" "monitor_396" {

  tags                = []
  query               = "sum(last_1h):count:aws.ses.complaints{*} > 5"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt 
Summary:P3 - {{value}} Emails Signed As Spam by Their Recipients
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS SES
Service:High Number Emails Signed As Spam
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Emails Signed As Spam by Their Recipients is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_397" {

  tags         = ["#####", "Production", ]
  query        = "avg(last_15m):avg:aws.cloudfront.404_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 404 Error Rate is High -Production"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_398" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Source Bytes Received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 700000.0
    warning  = 800000.0
  }
}


resource "datadog_monitor" "monitor_399" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ses.open{*} / sum:aws.ses.send.sum{*} < 1"
  message             = <<EOF
Priority:P2 slack-cloud-alerts-bindid-prd

webhook-XiteIt
 
Summary:P3 - Number of Opened Emails is Low
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS SES
Service:Low Number of Opened Emails
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS SES - Number of Opened Emails is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_400" {

  tags                = []
  query               = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
  message             = <<EOF
webhook-XiteIt  slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Cloudfront - Cache Hit Rate is Low"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 80.0
    warning  = 90.0
  }
}


resource "datadog_monitor" "monitor_401" {

  tags                = []
  query               = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Destination Bytes Received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 110000.0
    warning  = 120000.0
  }
}


resource "datadog_monitor" "monitor_402" {

  tags                = []
  query               = "avg(last_1h):avg:aws.applicationelb.target_response_time.average{*} > 0.25"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - AWS ALB - High Avg Response time on Load Balancer (over 250ms)"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 120
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical          = 0.25
    warning           = 0.22
    critical_recovery = 0.2
  }
}


resource "datadog_monitor" "monitor_403" {

  tags         = ["#####", "Production", ]
  query        = "avg(last_15m):avg:aws.cloudfront.401_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 401 Error Rate is High - Production"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_404" {

  tags                = []
  query               = "sum(last_1h):sum:aws.ebs.volume_write_ops{environment:production,host:i-0210258000ee05a99} by {host}.as_count() > 2000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - EBS [i-0210258000ee05a99] - Number of Write Ops is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 900
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 2000.0
    warning  = 1700.0
  }
}


resource "datadog_monitor" "monitor_405" {

  tags                = []
  query               = "sum(last_10m):avg:aws.applicationelb.request_count{*}.as_count() < 20"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
webhook-XiteIt 
Priority:P2

Summary:P2 - Number of ALB total Requests is {{value}}

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:Number of Requests is Low
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - Number of Requests is Low"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 20.0
    warning  = 25.0
  }
}


resource "datadog_monitor" "monitor_406" {

  tags         = ["#####", "Production", ]
  query        = "avg(last_15m):avg:aws.cloudfront.403_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po} >= 5"
  message      = <<EOF
slack-bindid-srvrefine-uptime-alerts
webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - Cloudfront - 403 Error Rate is High - Production"
  priority     = 1
  type         = "metric alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_407" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 15
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_408" {

  tags                = ["#####", ]
  query               = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count() > 5"
  message             = <<EOF
slack-bindid-srv-uptime-alerts webhook-Uptime-XiteIt

Summary:P1 - 5XX Error Rate is {{value}} on AWS ALB

Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS ALB
Service:5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS ALB - 5XX Error Rate is High"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 5.0
  }
}


resource "datadog_monitor" "monitor_409" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_410" {

  tags                = []
  query               = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
  message             = <<EOF
slack-cloud-alerts-bindid-prd

webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - [MoovingOn] AWS NAT - High Count of Active Connections"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 2500.0
    warning  = 2000.0
  }
}


resource "datadog_monitor" "monitor_411" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_out.maximum{*} > 950000"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - AWS EC2 - Network Out Max Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 950000.0
    warning           = 900000.0
    critical_recovery = 880000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_412" {

  tags                = []
  query               = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
  message             = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - AWS NAT - NAT Connection Failures Count is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 900
  monitor_thresholds {
    critical = 0.999
    warning  = 1.0
  }
}


resource "datadog_monitor" "monitor_413" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_in{*} > 3000000"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - AWS EC2 - Network In Avg Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 3000000.0
    warning           = 2500000.0
    critical_recovery = 2000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_414" {

  tags         = []
  query        = "avg(last_1h):avg:aws.ec2.network_out{*} > 1400000"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - AWS EC2 - Network Out Avg Usage is high"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 1400000.0
    warning           = 1200000.0
    critical_recovery = 1000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  evaluation_delay    = 900
}


resource "datadog_monitor" "monitor_415" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  Memory Usage is high on Container"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_416" {

  tags         = ["integration:kubernetes", ]
  query        = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
  message      = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - [Kubernetes] Monitor Unschedulable Kubernetes Nodes"
  priority     = null
  type         = "query alert"
  notify_audit = true
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 80.0
    warning  = 90.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_417" {

  tags         = ["integration:kubernetes", ]
  query        = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
  message      = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - [Kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = true
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_418" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.memory.usage{*} > 512000000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - Kubernetes Nodes - Memory Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 512000000.0
    warning           = 480000000.0
    critical_recovery = 450000000.0
  }
}


resource "datadog_monitor" "monitor_419" {

  tags         = []
  query        = "avg(last_30m):avg:kubernetes.cpu.usage.total{*} by {pod_name} > 4300000000"
  message      = "slack-cloud-alerts-bindid-prd"
  name         = "TF - Kubernetes Pods - CPU Total Usage is high on pod: {{pod_name.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 4300000000.0
    warning           = 4200000000.0
    critical_recovery = 4000000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_420" {

  tags                = []
  query               = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 120
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_421" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.memory.capacity{*} - avg:kubernetes.memory.usage{*} > 31000000000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - Kubernetes Pods - Free Memory Capacity has been exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 31000000000.0
    warning           = 29000000000.0
    critical_recovery = 29000000000.0
  }
}


resource "datadog_monitor" "monitor_422" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of Unavailable Pods is High"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_423" {

  tags                = []
  query               = "avg(last_30m):avg:kubernetes.filesystem.usage_pct{*} > 0.00047"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - Kubernetes Nodes - Disk Usage has been exceeded"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 60
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 0.00047
    warning           = 0.00045
    critical_recovery = 0.00042
  }
}


resource "datadog_monitor" "monitor_424" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  Memory Usage is high on Pod"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_425" {

  tags         = []
  query        = "avg(last_30m):avg:kubernetes.cpu.usage.total{*} by {kube_container_name} > 680000000"
  message      = "CPU Usage is high for the selected service!!! This can include all auth-control services slack-cloud-alerts-bindid-prd"
  name         = "TF - Kubernetes Containers - CPU Usage is high on container: {{kube_container_name.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 680000000.0
    warning           = 650000000.0
    critical_recovery = 630000000.0
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_426" {

  tags         = ["integration:kubernetes", ]
  query        = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
  message      = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - [Kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
  priority     = null
  type         = "query alert"
  notify_audit = false
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 10.0
    warning  = 5.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_427" {

  tags         = ["integration:kubernetes", ]
  query        = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
  message      = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - [Kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
  priority     = null
  type         = "query alert"
  notify_audit = true
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_428" {

  tags                = []
  query               = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Container Has Stopped Working"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 0.0
  }
}


resource "datadog_monitor" "monitor_429" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  CPU Total Usage is high on Node"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_430" {

  tags                = []
  query               = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P1

webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Node is not OK"
  priority            = 1
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_431" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_432" {

  tags                = ["integration:kubernetes", ]
  query               = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
  message             = <<EOF
Pods are restarting multiple times in the last five minutes.

webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - [Kubernetes] Monitor Kubernetes Pods Restarting"
  priority            = null
  type                = "query alert"
  notify_audit        = true
  locked              = false
  include_tags        = true
  no_data_timeframe   = 10
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  monitor_thresholds {
    critical = 5.0
    warning  = 3.0
  }
}


resource "datadog_monitor" "monitor_433" {

  tags                = []
  query               = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = false
  no_data_timeframe   = 15
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 120
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_434" {

  tags         = ["integration:kubernetes", ]
  query        = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
  message      = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "TF - [Kubernetes] Monitor Kubernetes Statefulset Replicas"
  priority     = null
  type         = "query alert"
  notify_audit = true
  locked       = false
  include_tags = true
  monitor_thresholds {
    critical = 2.0
    warning  = 1.0
  }
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = false
}


resource "datadog_monitor" "monitor_435" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes received is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 15000.0
    warning  = 20000.0
  }
}


resource "datadog_monitor" "monitor_436" {

  tags                = []
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2

webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  CPU Total Usage is high on Pod"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_437" {

  tags                = []
  query               = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P4

webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
  priority            = 4
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 120
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0.0
  }
}


resource "datadog_monitor" "monitor_438" {

  tags                = []
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2
webhook-XiteIt 

webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  Memory Usage is high on Node"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical          = 3.0
    warning           = 2.0
    critical_recovery = 2.0
  }
}


resource "datadog_monitor" "monitor_439" {

  tags                = []
  query               = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 1.0
  }
}


resource "datadog_monitor" "monitor_440" {

  tags                = []
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P2
webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes -  CPU Total Usage is high on Container"
  priority            = 2
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 300000000.0
    warning           = 250000000.0
    critical_recovery = 240000000.0
  }
}


resource "datadog_monitor" "monitor_441" {

  tags                = []
  query               = "avg(last_1h):avg:kubernetes.cpu.usage.total{*} > 90000000"
  message             = "slack-cloud-alerts-bindid-prd"
  name                = "TF - Kubernetes Nodes - CPU Total Usage is high"
  priority            = null
  type                = "query alert"
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 90000000.0
    warning           = 85000000.0
    critical_recovery = 80000000.0
  }
}


resource "datadog_monitor" "monitor_442" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes Transmitted is Low"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 10000.0
    warning  = 15000.0
  }
}


resource "datadog_monitor" "monitor_443" {

  tags                = []
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes received is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  evaluation_delay    = 600
  monitor_thresholds {
    critical = 300000.0
    warning  = 200000.0
  }
}


resource "datadog_monitor" "monitor_444" {

  tags                = []
  query               = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
  message             = <<EOF
slack-cloud-alerts-bindid-prd
Priority:P3

webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name                = "TF - Kubernetes Nodes - Number of bytes Transmitted is High"
  priority            = 3
  type                = "query alert"
  notify_audit        = false
  locked              = false
  include_tags        = true
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical = 100000.0
    warning  = 90000.0
  }
}


resource "datadog_monitor" "monitor_445" {

  tags         = ["Ring1", "Sandbox", ]
  query        = "logs(\"@error_category:\\\"Missing Authorization Header\\\" @bindid_env:sandbox\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message      = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Missing Authorization Header errors  - Sandbox

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Missing Authorization Header errors  - Sandbox
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Missing Authorization Header errors - Categorized - Sandbox"
  priority     = 1
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


resource "datadog_monitor" "monitor_446" {

  tags         = ["Ring1", "Production", ]
  query        = "logs(\"@error_category:\\\"Missing Authorization Header\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
  message      = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Missing Authorization Header errors  - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Missing Authorization Header errors  - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  name         = "Missing Authorization Header errors - Categorized - Production"
  priority     = 1
  type         = "log alert"
  notify_audit = false
  locked       = false
  timeout_h    = 0
  include_tags = true
  monitor_thresholds {
    critical = 5.0
  }
  new_host_delay     = 300
  notify_no_data     = false
  renotify_interval  = 0
  enable_logs_sample = true
}


