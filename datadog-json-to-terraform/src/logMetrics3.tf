resource "datadog_logs_metric" "log_metric3" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "Request started anonymous_invoke policy_request_id ama-rejection-recovery"
  }
  name = "recovery.journey.invocations"
}