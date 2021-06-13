######### All CPU Resources ###########
resource "datadog_monitor" "EC2_CPU_AVG" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - CPU Avg Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):avg:aws.${each.value["framework"]}.cpuutilization{*} > ${each.value["ec2_cpu_avg_critical"]}"

  thresholds = {
    warning           = each.value["ec2_cpu_avg_warning"]
    critical          = each.value["ec2_cpu_avg_critical"]
    critical_recovery = each.value["ec2_cpu_avg_recovery"]
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

resource "datadog_monitor" "EC2_CPU_MAX" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - CPU Max Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "avg(last_1h):max:aws.${each.value["framework"]}.cpuutilization.maximum{*} > ${each.value["ec2_cpu_max_critical"]}"

  thresholds = {
    warning           = each.value["ec2_cpu_max_warning"]
    critical          = each.value["ec2_cpu_max_critical"]
    critical_recovery = each.value["ec2_cpu_max_recovery"]
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

######### All Network Resources ###########
resource "datadog_monitor" "EC2_NetworkIn_AVG" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - Network In Avg Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query              = "avg(last_1h):avg:aws.${each.value["framework"]}.network_in{*} > ${each.value["ec2_networkIn_avg_critical"]}"

  thresholds = {
    warning           = each.value["ec2_networkIn_avg_warning"]
    critical          = each.value["ec2_networkIn_avg_critical"]
    critical_recovery = each.value["ec2_networkIn_avg_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}

resource "datadog_monitor" "EC2_NetworkOut_AVG" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - Network Out Avg Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query              = "avg(last_1h):avg:aws.${each.value["framework"]}.network_out{*} > ${each.value["ec2_networkOut_avg_critical"]}"

  thresholds = {
    warning           = each.value["ec2_networkOut_avg_warning"]
    critical          = each.value["ec2_networkOut_avg_critical"]
    critical_recovery = each.value["ec2_networkOut_avg_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}

resource "datadog_monitor" "EC2_NetworkOut_MAX" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - Network Out Max Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query              = "avg(last_1h):avg:aws.${each.value["framework"]}.network_out.maximum{*} > ${each.value["ec2_networkOut_max_critical"]}"

  thresholds = {
    warning           = each.value["ec2_networkOut_max_warning"]
    critical          = each.value["ec2_networkOut_max_critical"]
    critical_recovery = each.value["ec2_networkOut_max_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}

resource "datadog_monitor" "EC2_NetworkIn_MAX" {
  for_each           = var.ec2_services
  name               = "Terraform - AWS EC2 - Network In Max Usage is high"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query              = "avg(last_1h):avg:aws.${each.value["framework"]}.network_in.maximum{*} > ${each.value["ec2_networkIn_max_critical"]}"

  thresholds = {
    warning           = each.value["ec2_networkIn_max_warning"]
    critical          = each.value["ec2_networkIn_max_critical"]
    critical_recovery = each.value["ec2_networkIn_max_recovery"]
  }

  notify_no_data    = false
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
}