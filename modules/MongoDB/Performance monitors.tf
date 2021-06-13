resource "datadog_monitor" "MongoDB_queryEfficiency" {
  for_each           = var.performance_services
  name               = "Terraform - MongoDB - Query Efficiency"
  type               = "query alert"
  message            = "Indexing queries and returned results may be slow ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.metrics.queryexecutor.scannedobjectsperreturned{*} + avg:${each.value["framework"]}.metrics.queryexecutor.scannedperreturned{*} > ${each.value["mongodb_queryExec_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_queryExec_warning"]
    critical          = each.value["mongodb_queryExec_critical"]
    critical_recovery = each.value["mongodb_queryExec_recovery"]
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

resource "datadog_monitor" "MongoDB_cursor" {
  for_each           = var.performance_services
  name               = "Terraform - MongoDB - Total Cursors"
  type               = "query alert"
  message            = "When a read query is received, MongoDB returns a cursor which represents a pointer to the data (documents). This cursor remains open on the server, consuming memory and large amount of memory being consumed can cause application issues. ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.cursors.totalopen{*} > ${each.value["mongodb_cursor_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_cursor_warning"]
    critical          = each.value["mongodb_cursor_critical"]
    critical_recovery = each.value["mongodb_cursor_recovery"]
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

resource "datadog_monitor" "MongoDB_readOps_latency" {
  for_each           = var.performance_services
  name               = "Terraform - MongoDB - Read Operations have a high average latency"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.oplatencies.reads.avg{*} > ${each.value["mongodb_readOps_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_readOps_warning"]
    critical          = each.value["mongodb_readOps_critical"]
    critical_recovery = each.value["mongodb_readOps_recovery"]
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

resource "datadog_monitor" "MongoDB_writeOps_latency" {
  for_each           = var.performance_services
  name               = "Terraform - MongoDB - Write Operations have a high average latency"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.oplatencies.writes.avg{*} > ${each.value["mongodb_writeOps_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_writeOps_warning"]
    critical          = each.value["mongodb_writeOps_critical"]
    critical_recovery = each.value["mongodb_writeOps_recovery"]
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