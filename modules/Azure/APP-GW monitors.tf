resource "datadog_monitor" "APP-GW_httpResponse" {
  for_each           = var.appgw_services
  name               = "Terraform - Azure Application Gateway - Http Response Status"
  type               = "query alert"
  message            = "Http response status returned by Application Gateway is high. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:azure.${each.value["framework"]}.response_status{*} > ${each.value["app-gw_httpResponse_critical"]}"


  thresholds = {
    warning           = each.value["app-gw_httpResponse_warning"]
    critical          = each.value["app-gw_httpResponse_critical"]
    critical_recovery = each.value["app-gw_httpResponse_recovery"]
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

resource "datadog_monitor" "APP-GW_backendResponse" {
  for_each           = var.appgw_services
  name               = "Terraform - Azure Application Gateway - Backend Response Status"
  type               = "query alert"
  message            = "Backend response status returned by Application Gateway is high. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:azure.${each.value["framework"]}.backend_response_status{*} > ${each.value["app-gw_backendResponse_critical"]}"


  thresholds = {
    warning           = each.value["app-gw_backendResponse_warning"]
    critical          = each.value["app-gw_backendResponse_critical"]
    critical_recovery = each.value["app-gw_backendResponse_recovery"]
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

resource "datadog_monitor" "APP-GW_throughput" {
  for_each           = var.appgw_services
  name               = "Terraform - Azure Application Gateway - Throughput"
  type               = "query alert"
  message            = "Number of bytes per second the Application Gateway has served. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:azure.${each.value["framework"]}.throughput{*} > ${each.value["app-gw_throughput_critical"]}"


  thresholds = {
    warning           = each.value["app-gw_throughput_warning"]
    critical          = each.value["app-gw_throughput_critical"]
    critical_recovery = each.value["app-gw_throughput_recovery"]
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