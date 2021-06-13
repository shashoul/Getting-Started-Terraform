terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

######### All Target Response Time AVG Resources ###########
resource "datadog_monitor" "EC2_ALB_RESP_AVG" {
  for_each           = var.alb_response
  name               = "Terraform - AWS ALB - High Avg Response time on Load Balancer (over 250ms)"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:aws.${each.value["framework"]}.target_response_time.average{*} > ${each.value["alb_responseTime_avg_critical"]}"

  thresholds = {
    warning           = each.value["alb_responseTime_avg_warning"]
    critical          = each.value["alb_responseTime_avg_critical"]
    critical_recovery = each.value["alb_responseTime_avg_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 120
  renotify_interval = 0
  locked            = true

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}

######### All Request Count Resources ###########
resource "datadog_monitor" "EC2_ALB_TotalReq_Count" {
  for_each           = var.alb_services
  name               = "Terraform - AWS ELB - Total Request Count Status (Peaks/Drops)"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):sum:aws.${each.value["framework"]}.request_count{*}.as_rate() > ${each.value["alb_totalReqCount_critical"]}"

  thresholds = {
    warning           = each.value["alb_totalReqCount_warning"]
    critical          = each.value["alb_totalReqCount_critical"]
    critical_recovery = each.value["alb_totalReqCount_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 120
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}

######### All HTTPCode Resources ###########
resource "datadog_monitor" "EC2_ALB_4XX" {
  for_each           = var.alb_services
  name               = "Terraform - AWS ELB - High load of 4xx HTTPCode in total"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query =   "sum(last_1h):sum:aws.${each.value["framework"]}.httpcode_elb_4xx{*} by {host}.as_count() > ${each.value["alb_4xx_httpcode_critical"]}"

  thresholds = {
    warning           = each.value["alb_4xx_httpcode_warning"]
    critical          = each.value["alb_4xx_httpcode_critical"]
    critical_recovery = each.value["alb_4xx_httpcode_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 120
  renotify_interval = 0
  locked            = false
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}