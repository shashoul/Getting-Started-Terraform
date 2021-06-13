resource "datadog_monitor" "MongoDB_CPU_AVG" {
  for_each           = var.health_services
  name               = "Terraform - MongoDB - Avg CPU Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.system.cpu.norm.guest{*} + avg:${each.value["framework"]}.system.cpu.norm.iowait{*} + avg:${each.value["framework"]}.system.cpu.norm.irq{*} + avg:${each.value["framework"]}.system.cpu.mongoprocess.norm.kernel{*} + avg:${each.value["framework"]}.system.cpu.norm.nice{*} + avg:${each.value["framework"]}.system.cpu.norm.softirq{*} + avg:${each.value["framework"]}.system.cpu.norm.steal{*} + avg:${each.value["framework"]}.system.cpu.norm.user{*} > ${each.value["mongodb_cpuUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_cpuUsage_warning"]
    critical          = each.value["mongodb_cpuUsage_critical"]
    critical_recovery = each.value["mongodb_cpuUsage_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}

resource "datadog_monitor" "MongoDB_DiskSpace_AVG" {
  for_each           = var.health_services
  name               = "Terraform - MongoDB - Avg Disk Space Has Exceeded"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.system.disk.space.free{*} > ${each.value["mongodb_diskUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_diskUsage_warning"]
    critical          = each.value["mongodb_diskUsage_critical"]
    critical_recovery = each.value["mongodb_diskUsage_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}

resource "datadog_monitor" "MongoDB_DiskIOPS_totalAVG" {
  for_each           = var.health_services
  name               = "Terraform - MongoDB - Avg Total Disk IOPS is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "sum(last_1h):avg:${each.value["framework"]}.system.disk.iops.total{*}.as_count() > ${each.value["mongodb_iopsUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_iopsUsage_warning"]
    critical          = each.value["mongodb_iopsUsage_critical"]
    critical_recovery = each.value["mongodb_iopsUsage_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}

resource "datadog_monitor" "MongoDB_pMem_AVG" {
  for_each           = var.health_services
  name               = "Terraform - MongoDB - Process Memory Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.system.mem.resident{*} > ${each.value["mongodb_pmemUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_pmemUsage_warning"]
    critical          = each.value["mongodb_pmemUsage_critical"]
    critical_recovery = each.value["mongodb_pmemUsage_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}

resource "datadog_monitor" "MongoDB_current_connections" {
  for_each           = var.health_services
  name               = "Terraform - MongoDB - Number of current connections is above 100"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.connections.current{*} > ${each.value["mongodb_connect_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_connect_warning"]
    critical          = each.value["mongodb_connect_critical"]
    critical_recovery = each.value["mongodb_connect_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}
