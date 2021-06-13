######### All Active Connection Resources ###########
resource "datadog_monitor" "NAT_Active_Connection" {
  for_each           = var.nat_services
  name               = "Terraform - AWS NAT - High Count of Active Connections"
  type               = "query alert"
  message            = each.value["channel"]
  escalation_message = ""

  query = "sum(last_1h):max:aws.${each.value["framework"]}.active_connection_count{*}.as_count() >= ${each.value["nat_activeConnection_count_critical"]}"

  thresholds = {
    warning           = each.value["nat_activeConnection_count_warning"]
    critical          = each.value["nat_activeConnection_count_critical"]
    critical_recovery = each.value["nat_activeConnection_count_recovery"]
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

######### All Non-Alerts for Composite Alerts ###########
# ID = 20269391
resource "datadog_monitor" "NAT_BytesOut_ToClients" {
  for_each           = var.natComp_services
  name               = "Terraform - AWS NAT Comp - Number of bytes (Out) to Clients"
  type               = "query alert"
  message            = "{{^is_alert}}\n\nAWS NAT - Number of bytes (Out) to Clients\n\n{{/is_alert}}"
  escalation_message = ""

  query = "avg(last_1h):sum:aws.${each.value["framework"]}.bytes_out_to_source{*} <= ${each.value["natComp_byteOut_clients_critical"]}"

  thresholds = {
    warning           = each.value["natComp_byteOut_clients_warning"]
    critical          = each.value["natComp_byteOut_clients_critical"]
    critical_recovery = each.value["natComp_byteOut_clients_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = true
  
}

######### All Composite Alerts ###########
# ID = 20269988
resource "datadog_monitor" "NAT_BytesIn_FromDest" {
  for_each           = var.natComp_services
  name               = "Terraform - AWS NAT Comp - Number of bytes received from KS server"
  type               = "query alert"
  message            = "{{is_alert}}\n\nAWS NAT - Number of bytes received from KS server \n\n{{is_alert}} ${each.value["channel"]}"
  escalation_message = ""

  query = "avg(last_1h):sum:aws.${each.value["framework"]}.bytes_in_from_destination{*} >= ${each.value["natComp_byteIn_dest_critical"]}"

  thresholds = {
    warning           = each.value["natComp_byteIn_dest_warning"]
    critical          = each.value["natComp_byteIn_dest_critical"]
    critical_recovery = each.value["natComp_byteIn_dest_recovery"]
  }

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = true
  
}

resource "datadog_monitor" "NAT_dataLoss" {
  for_each           = var.natComp_services
  name               = "Terraform - AWS NAT Comp - Data Loss during NAT gateway processing"
  type               = "composite"
  message            = "If the value for BytesOutToSource is less than the value for BytesInFromDestination, there may be data loss during NAT gateway processing, or traffic being actively blocked by the NAT gateway.\nMore information: [Confluence] (https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway-cloudwatch.html) ${each.value["channel"]}"
  escalation_message = ""

  query = "!${datadog_monitor.NAT_BytesIn_FromDest[each.key].id} && ${datadog_monitor.NAT_BytesOut_ToClients[each.key].id}"

  notify_no_data    = true
  no_data_timeframe = 30
  renotify_interval = 0
  locked            = true
  new_host_delay    = 300

  notify_audit = false
  timeout_h    = 0
  include_tags = false
  
}