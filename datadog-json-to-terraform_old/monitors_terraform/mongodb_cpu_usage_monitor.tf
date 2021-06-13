resource "datadog_monitor" "mongodb_cpu_usage_monitor" {

  name                = "Shady Terraform Test !!! - MongoDB - Avg CPU Usage is high"
  type                = "query alert"
  query               = "avg(last_1h):avg:mongodb.atlas.system.cpu.norm.guest{*} + avg:mongodb.atlas.system.cpu.norm.iowait{*} + avg:mongodb.atlas.system.cpu.norm.irq{*} + avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*} + avg:mongodb.atlas.system.cpu.norm.nice{*} + avg:mongodb.atlas.system.cpu.norm.softirq{*} + avg:mongodb.atlas.system.cpu.norm.steal{*} + avg:mongodb.atlas.system.cpu.norm.user{*} > 8"
  message             = "@slack-cloud-alerts-dev-test"
  tags                = []
  notify_audit        = false
  locked              = true
  include_tags        = false
  no_data_timeframe   = 30
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  monitor_thresholds {
    critical          = 8
    warning           = 7
    critical_recovery = 7
  }
  priority = null
}