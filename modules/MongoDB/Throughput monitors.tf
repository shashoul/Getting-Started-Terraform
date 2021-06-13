resource "datadog_monitor" "MongoDB_readRequests" {
  for_each           = var.throughput_services
  name               = "Terraform - MongoDB - Read Requests (Per Second) throughput is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):sum:${each.value["framework"]}.opcounters.getmore{*}.as_rate() + sum:${each.value["framework"]}.opcounters.query{*}.as_rate() > ${each.value["mongodb_readReq_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_readReq_warning"]
    critical          = each.value["mongodb_readReq_critical"]
    critical_recovery = each.value["mongodb_readReq_recovery"]
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

resource "datadog_monitor" "MongoDB_writeRequests" {
  for_each           = var.throughput_services
  name               = "Terraform - MongoDB - Write Requests (Per Second) throughput is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):sum:${each.value["framework"]}.opcounters.delete{*}.as_rate() + avg:${each.value["framework"]}.opcounters.insert{*}.as_rate() + sum:${each.value["framework"]}.opcounters.update{*}.as_rate() > ${each.value["mongodb_writeReq_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_writeReq_warning"]
    critical          = each.value["mongodb_writeReq_critical"]
    critical_recovery = each.value["mongodb_writeReq_recovery"]
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

resource "datadog_monitor" "MongoDB_documentReads" {
  for_each           = var.throughput_services
  name               = "Terraform - MongoDB - Document Reads"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:${each.value["framework"]}.metrics.document.returned{*}.as_rate() > ${each.value["mongodb_readDocs_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_readDocs_warning"]
    critical          = each.value["mongodb_readDocs_critical"]
    critical_recovery = each.value["mongodb_readDocs_recovery"]
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

resource "datadog_monitor" "MongoDB_documentWrites" {
  for_each           = var.throughput_services
  name               = "Terraform - MongoDB - Document Writes"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):sum:${each.value["framework"]}.metrics.document.deleted{*}.as_rate() + sum:${each.value["framework"]}.metrics.document.inserted{*}.as_rate() + sum:${each.value["framework"]}.metrics.document.updated{*}.as_rate() > ${each.value["mongodb_writeDocs_critical"]}"

  thresholds = {
    warning           = each.value["mongodb_writeDocs_warning"]
    critical          = each.value["mongodb_writeDocs_critical"]
    critical_recovery = each.value["mongodb_writeDocs_recovery"]
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