resource "datadog_monitor" "mongo_write_request_monitor" {

  name                = "Shady Terraform Test !!! - MongoDB - Write Requests (Per Second) throughput is high"
  type                = "query alert"
  query               = "avg(last_1h):sum:mongodb.atlas.opcounters.delete{*}.as_rate() + avg:mongodb.atlas.opcounters.insert{*}.as_rate() + sum:mongodb.atlas.opcounters.update{*}.as_rate() > 2"
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
    critical          = 2
    warning           = 1.9
    critical_recovery = 1.7
  }
  priority = null
}