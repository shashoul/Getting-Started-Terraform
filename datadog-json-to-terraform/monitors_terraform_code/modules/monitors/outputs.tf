output "IDs" {
#   value = values(datadog_monitor.datadog_monitor)[*].id
#   count = length(datadog_monitor.datadog_monitor)
#   value = datadog_monitor.datadog_monitor[keys(datadog_monitor.datadog_monitor)].id
  value = {
    for key in keys(datadog_monitor.datadog_monitor):
      key => datadog_monitor.datadog_monitor[key].id
  }
  description = "ID numbers of the managed Datadog monitors."
}