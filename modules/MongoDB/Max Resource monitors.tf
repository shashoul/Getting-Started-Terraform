resource "datadog_monitor" "MongoDB_CPU_MAX" {
  for_each           = var.maxRes_services
  name               = "Terraform - MongoDB - Max CPU Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):max:${each.value["framework"]}.system.cpu.norm.guest{*} + max:${each.value["framework"]}.system.cpu.norm.iowait{*} + max:${each.value["framework"]}.system.cpu.norm.irq{*} + max:${each.value["framework"]}.system.cpu.mongoprocess.norm.kernel{*} + max:${each.value["framework"]}.system.cpu.norm.nice{*} + max:${each.value["framework"]}.system.cpu.norm.softirq{*} + max:${each.value["framework"]}.system.cpu.norm.steal{*} + max:${each.value["framework"]}.system.cpu.norm.user{*} > ${each.value["mongodb_mcpuUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_mcpuUsage_warning"]
    critical          = each.value["mongodb_mcpuUsage_critical"]
    critical_recovery = each.value["mongodb_mcpuUsage_recovery"]
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

resource "datadog_monitor" "MongoDB_DiskSpace_MAX" {
  for_each           = var.maxRes_services
  name               = "Terraform - MongoDB - Max Disk Space Is Low"
  type               = "query alert"
  message            = "This alert triggers when disk space is below 10GB out of 90GB. ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_1h):max:${each.value["framework"]}.system.disk.space.free{*} - max:${each.value["framework"]}.system.disk.space.used{*} < ${each.value["mongodb_mdiskUsage_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_mdiskUsage_warning"]
    critical          = each.value["mongodb_mdiskUsage_critical"]
    critical_recovery = each.value["mongodb_mdiskUsage_recovery"]
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

resource "datadog_monitor" "MongoDB_hostsCPU_MAX" {
  for_each           = var.maxRes_services
  name               = "Terraform - MongoDB - Top Hosts with Max CPU Usage"
  type               = "query alert"
  message            = "Hostname:{{hostnameport.name}} has Max CPU Usage  ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_4h):anomalies(top(max:${each.value["framework"]}.system.cpu.norm.user{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= ${each.value["mongodb_hostCPU_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_hostCPU_warning"]
    critical          = each.value["mongodb_hostCPU_critical"]
    critical_recovery = each.value["mongodb_hostCPU_recovery"]
  }

  threshold_windows = {
    recovery_window = "last_30m"
    trigger_window = "last_30m"
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

resource "datadog_monitor" "MongoDB_hostsDisk_MAX" {
  for_each           = var.maxRes_services
  name               = "Terraform - MongoDB - Top hosts by disk space used (Percentage)"
  type               = "query alert"
  message            = "Hostname:{{hostnameport.name}} has Max Disk Space used.  ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_4h):anomalies(top(max:${each.value["framework"]}.system.disk.space.percentused{*} by {hostnameport}, 10, 'mean', 'desc'), 'agile', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true') >= ${each.value["mongodb_hostDisk_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_hostDisk_warning"]
    critical          = each.value["mongodb_hostDisk_critical"]
    critical_recovery = each.value["mongodb_hostDisk_recovery"]
  }

  threshold_windows = {
    recovery_window = "last_30m"
    trigger_window = "last_30m"
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