resource "datadog_logs_metric" "log_metric1" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "*"
  }
  group_by {
    path     = "datadog_is_excluded"
    tag_name = "datadog_is_excluded"
  }
  group_by {
    path     = "service"
    tag_name = "service"
  }
  group_by {
    path     = "status"
    tag_name = "status"
  }
  group_by {
    path     = "datadog_index"
    tag_name = "datadog_index"
  }
  name = "datadog.estimated_usage.logs.ingested_events"
}