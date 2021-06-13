resource "datadog_monitor" "k8s_Monitor_Kubernetes_Failed_Pods_in_Namespaces_monitor" {

  name                = "[kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
  type                = "query alert"
  query               = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
  message             = <<EOF
More than ten pods are failing in ({{kubernetes_cluster.name}} cluster).
@webhook-XiteIt

Summary:Number of Failed Pods on Namespace {{kubernetes_cluster.name}} is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes - {{kubernetes_cluster.name}}
Service:High Kubernetes Failed Pods in Namespaces
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["integration:kubernetes", ]
  notify_audit        = false
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
    critical = 10
    warning  = 5
  }
  priority = null
}