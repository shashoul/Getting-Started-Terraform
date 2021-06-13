resource "datadog_monitor" "AKV_status" {
  for_each           = var.akv_services
  name               = "Terraform - Azure AKV - Status"
  type               = "query alert"
  message            = "Azure Key Vault is down. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:azure.${each.value["framework"]}.status{*} < ${each.value["akv_status_critical"]}"


  thresholds = {
    warning           = each.value["akv_status_warning"]
    critical          = each.value["akv_status_critical"]
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

resource "datadog_monitor" "AKV_APILatency" {
  for_each           = var.akv_services
  name               = "Terraform - Azure AKV - Service API Latency"
  type               = "query alert"
  message            = "Service of API requests has high latency. Performance degradation may be impacted! ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_30m):avg:azure.${each.value["framework"]}.service_api_latency{*} > ${each.value["akv_apiLatency_critical"]}"


  thresholds = {
    warning           = each.value["akv_apiLatency_warning"]
    critical          = each.value["akv_apiLatency_critical"]
    critical_recovery = each.value["akv_apiLatency_recovery"]
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