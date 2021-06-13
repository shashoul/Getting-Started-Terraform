resource "datadog_monitor" "aws_ec2_network_monitor" {

  name         = "Shady Terraform Test !!! - AWS EC2 - Network Out Avg Usage is high"
  type         = "query alert"
  query        = "avg(last_1h):avg:aws.ec2.network_out{*} > 1250000"
  message      = "@slack-cloud-alerts-dev-test"
  tags         = []
  notify_audit = false
  locked       = true
  include_tags = false
  monitor_thresholds {
    critical          = 1250000
    warning           = 1230000
    critical_recovery = 1200000
  }
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = false
  priority            = null
}