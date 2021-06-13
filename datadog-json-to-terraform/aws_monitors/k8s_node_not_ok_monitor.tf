resource "datadog_monitor" "k8s_node_not_ok_monitor" {

  name                = "Kubernetes Nodes - Node is not OK"
  type                = "query alert"
  query               = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 

Summary:Container:P1 - Node:{{host}} is not OK
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Node is not OK
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = true
  notify_no_data      = true
  renotify_interval   = "0"
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 1
  }
  priority = 1
}