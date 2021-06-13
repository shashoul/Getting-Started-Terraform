
output "IDs" {
  value = [
    for metric in datadog_logs_metric.datadog_logs_metric :
        metric.name
  ]
  description = "Datadog Log Metrics names."
}