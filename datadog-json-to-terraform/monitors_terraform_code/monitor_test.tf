
# resource "datadog_monitor" "AWS_EC2_1_test" {
#   for_each            = local.conf
#   name                = "Terraform shady test  - AWS EC2 - Number of Failed Host Checks is High"
#   type                = "query alert"
#   query               = "avg(last_10m):sum:aws.ec2.status_check_failed{*} > ${each.value.critical}"
#   message             = <<EOF

# Priority:P1

# EOF
#   tags                = []
#   notify_audit        = false
#   locked              = false
#   timeout_h           = 0
#   include_tags        = false
#   no_data_timeframe   = 30
#   require_full_window = false
#   new_host_delay      = 300
#   notify_no_data      = true
#   renotify_interval   = 0
#   evaluation_delay    = 900
#   escalation_message  = ""
#   monitor_thresholds {
#     critical          = each.value.critical
#     warning           = each.value.warning
#     critical_recovery = each.value.recovered == "5" ? null : 2
#   }
#   priority = 1
# }

module "Datadog_Monitor" {
  # source = "./modules/monitors"
  source = "../../../transmitsecurity/observability/modules/Datadog_Monitor"
  conf   = local.conf
}

# output "configuration" {
#   value = local.conf
# }