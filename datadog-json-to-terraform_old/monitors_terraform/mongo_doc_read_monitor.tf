resource "datadog_monitor" "mongo_doc_read_monitor" {

  name                = "Shady Terraform Test !!! - MongoDB - Document Reads"
  type                = "query alert"
  query               = "avg(last_1h):avg:mongodb.atlas.metrics.document.returned{*}.as_rate() > 100"
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
    critical          = 100
    warning           = 98
    critical_recovery = 95
  }
  priority = null
}