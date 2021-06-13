resource "datadog_monitor" "k8s_Monitor_Kubernetes_Statefulset_Replicas_monitor" {

  name                = "[kubernetes] Monitor Kubernetes Statefulset Replicas"
  type                = "query alert"
  query               = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
  message             = <<EOF
More than one Statefulset Replica's pods are down. This might present an unsafe situation for any further manual operations, such as killing other pods.

@webhook-XiteIt

Summary:Kubernetes - Down Pods on Statefulset Replica {{statefulset.name}} is  {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{statefulset.name}}
Service:High Number of Statefulset Replica's Pods are Down
Value:{{value}}
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
    critical = 2
    warning  = 1
  }
  priority = null
}