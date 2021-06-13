resource "datadog_monitor" "ALB_status" {
  for_each           = var.alb_services
  name               = "Terraform - Azure ALB - Status"
  type               = "query alert"
  message            = "Azure Load Balancer is down. ${each.value["channel"]}"
  escalation_message = ""

  query =   "avg(last_1h):avg:azure.${each.value["framework"]}.status{*} < ${each.value["alb_status_critical"]}"


  thresholds = {
    warning           = each.value["alb_status_warning"]
    critical          = each.value["alb_status_critical"]
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