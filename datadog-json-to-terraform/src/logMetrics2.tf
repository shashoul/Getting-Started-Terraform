resource "datadog_logs_metric" "log_metric2" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "cannot_consume_ticket ERROR 401"
  }
  name = "cannot.consume"
}