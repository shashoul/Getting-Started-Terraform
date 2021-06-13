
resource "datadog_monitor" "datadog_monitor" {
  # for_each            = { for entry in var.conf: entry.name => entry}
  for_each           = toset(keys({ for k, v in var.conf : k => v }))
  name               = var.conf[each.value].name
  type               = var.conf[each.value].type
  message            = var.conf[each.value].message
  escalation_message = var.conf[each.value].escalation_message

  query = "${trimspace(var.conf[each.value].query)} ${var.conf[each.value].operator} ${tonumber(var.conf[each.value].threshold_critical)}"

  monitor_thresholds {
    critical          = var.conf[each.value].threshold_critical
    warning           = var.conf[each.value].threshold_warning != "" ? tonumber(var.conf[each.value].threshold_warning) : var.default_conf["threshold_warning"]
    critical_recovery = var.conf[each.value].threshold_critical_recovery != "" ? tonumber(var.conf[each.value].threshold_critical_recovery) : var.default_conf["threshold_critical_recovery"]
  }

  monitor_threshold_windows {
    recovery_window = var.conf[each.value].threshold_windows_recovery_window
    trigger_window  = var.conf[each.value].threshold_windows_trigger_window
  }

  tags                = var.conf[each.value].tags != "" ? split(" ", var.conf[each.value].tags) : var.default_conf["tags"]
  notify_audit        = var.conf[each.value].notify_audit != "" ? tobool(lower(var.conf[each.value].notify_audit)) : var.default_conf["notify_audit"]
  locked              = var.conf[each.value].locked != "" ? tobool(lower(var.conf[each.value].locked)) : var.default_conf["locked"]
  timeout_h           = var.conf[each.value].timeout_h != "" ? tonumber(var.conf[each.value].timeout_h) : var.default_conf["timeout_h"]
  include_tags        = var.conf[each.value].include_tags != "" ? tobool(lower(var.conf[each.value].include_tags)) : var.default_conf["include_tags"]
  no_data_timeframe   = var.conf[each.value].no_data_timeframe != "" ? tonumber(var.conf[each.value].no_data_timeframe) : var.default_conf["no_data_timeframe"]
  require_full_window = var.conf[each.value].require_full_window != "" ? tobool(lower(var.conf[each.value].require_full_window)) : var.default_conf["require_full_window"]
  new_host_delay      = var.conf[each.value].new_host_delay != "" ? tonumber(var.conf[each.value].new_host_delay) : var.default_conf["new_host_delay"]
  notify_no_data      = var.conf[each.value].notify_no_data != "" ? tobool(lower(var.conf[each.value].notify_no_data)) : var.default_conf["notify_no_data"]
  renotify_interval   = var.conf[each.value].renotify_interval != "" ? tonumber(var.conf[each.value].renotify_interval) : var.default_conf["renotify_interval"]
  evaluation_delay    = var.conf[each.value].evaluation_delay != "" ? tonumber(var.conf[each.value].evaluation_delay) : var.default_conf["evaluation_delay"]

  enable_logs_sample = var.conf[each.value].enable_logs_sample != "" ? tobool(lower(var.conf[each.value].enable_logs_sample)) : var.default_conf["enable_logs_sample"]

  priority = var.conf[each.value].priority != "" ? var.conf[each.value].priority : var.default_conf["priority"]
}