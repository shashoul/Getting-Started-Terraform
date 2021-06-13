resource "datadog_monitor" "k8s_Monitor_Kubernetes_Deployments_Replica_Pods_monitor" {

  name                = "[kubernetes] Monitor Kubernetes Deployments Replica Pods"
  type                = "query alert"
  query               = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
  message             = <<EOF
More than one Deployments Replica's pods are down.

@webhook-XiteIt

Summary:Down Deployments Replica number on {{deployment}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{deployment}}
Service:Down Kubernetes Deployments Replica Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = ["integration:kubernetes", ]
  notify_audit        = true
  locked              = false
  timeout_h           = 0
  new_host_delay      = 300
  require_full_window = false
  notify_no_data      = true
  renotify_interval   = "0"
  escalation_message  = ""
  no_data_timeframe   = 5
  include_tags        = true
  monitor_thresholds {
    critical = 2
  }
  priority = null
}