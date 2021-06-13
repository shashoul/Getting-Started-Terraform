resource "datadog_logs_metric" "datadog_logs_metric" {
  for_each = toset(keys({ for k, v in var.conf : k => v }))

  name = var.conf[each.value].name

  compute {
    aggregation_type = var.conf[each.value].compute_type
    path             = var.conf[each.value].compute_path
  }

  filter {
    query = var.conf[each.value].filter_query
  }

  dynamic "group_by" {
    for_each = trimspace(var.conf[each.value].group_by) == "" ? [] : split(" ", trimspace(var.conf[each.value].group_by))
    content {
      path     = group_by.value
      tag_name = replace(group_by.value, "@", "")
    }
  }
}