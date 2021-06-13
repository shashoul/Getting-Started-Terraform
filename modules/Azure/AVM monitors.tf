resource "datadog_monitor" "AVM_CPU" {
  for_each           = var.avm_services
  name               = "Terraform - Azure Virtual Machine - CPU Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "avg(last_1h):avg:${each.value["framework"]}.percentage_cpu{*} > ${each.value["avm_cpu_critical"]}"


  thresholds = {
    warning           = each.value["avm_cpu_warning"]
    critical          = each.value["avm_cpu_critical"]
    critical_recovery = each.value["avm_cpu_recovery"]
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

resource "datadog_monitor" "AVM_NetworkIn" {
  for_each           = var.avm_services
  name               = "Terraform - Azure Virtual Machine - Network In Total Usage is high"
  type               = "query alert"
  message            = "The number of bytes received on all network interfaces by the Virtual Machine(s) (Incoming Traffic). ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:${each.value["framework"]}.network_in_total{*} > ${each.value["avm_networkIn_critical"]}"


  thresholds = {
    warning           = each.value["avm_networkIn_warning"]
    critical          = each.value["avm_networkIn_critical"]
    critical_recovery = each.value["avm_networkIn_recovery"]
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

resource "datadog_monitor" "AVM_NetworkOut" {
  for_each           = var.avm_services
  name               = "Terraform - Azure Virtual Machine - Network Out Total Usage is high"
  type               = "query alert"
  message            = "The number of bytes out on all network interfaces by the Virtual Machine(s) (Outgoing Traffic). ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:${each.value["framework"]}.network_in_total{*} > ${each.value["avm_networkOut_critical"]}"


  thresholds = {
    warning           = each.value["avm_networkOut_warning"]
    critical          = each.value["avm_networkOut_critical"]
    critical_recovery = each.value["avm_networkOut_recovery"]
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

resource "datadog_monitor" "AVM_disk_read" {
  for_each           = var.avm_services
  name               = "Terraform - Azure Virtual Machine - Disk Read Bytes"
  type               = "query alert"
  message            = "High amount of bytes read. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:${each.value["framework"]}.disk_read_bytes{*} > ${each.value["avm_diskRead_critical"]}"


  thresholds = {
    warning           = each.value["avm_diskRead_warning"]
    critical          = each.value["avm_diskRead_critical"]
    critical_recovery = each.value["avm_diskRead_recovery"]
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

resource "datadog_monitor" "AVM_disk_write" {
  for_each           = var.avm_services
  name               = "Terraform - Azure Virtual Machine - Disk Write Bytes"
  type               = "query alert"
  message            = "High amount of bytes written. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:${each.value["framework"]}.disk_write_bytes{*} > ${each.value["avm_diskWrite_critical"]}"


  thresholds = {
    warning           = each.value["avm_diskWrite_warning"]
    critical          = each.value["avm_diskWrite_critical"]
    critical_recovery = each.value["avm_diskWrite_recovery"]
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