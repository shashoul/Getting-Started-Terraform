resource "datadog_monitor" "k8s_Monitor_Unschedulable_Kubernetes_Nodes_monitor" {

  name                = "[kubernetes] Monitor Unschedulable Kubernetes Nodes"
  type                = "query alert"
  query               = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
  message             = <<EOF
More than 20% of nodes are unschedulable on ({{kubernetes_cluster.name}} cluster).

@webhook-XiteIt

Summary:Kubernetes - {{value}}% of Kubernetes Node are Unschedulable on {{kubernetes_cluster.name}} Cluster.
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}% 

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Unschedulable Kubernetes Nodes
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["integration:kubernetes", ]
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = null
  require_full_window = false
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 80
    warning  = 90
  }
  priority = null
}