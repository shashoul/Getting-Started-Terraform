resource "datadog_monitor" "k8s_Monitor_Pod_ImageBackOff_Namespace_monitor" {

  name                = "[kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
  type                = "query alert"
  query               = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
  message             = <<EOF
pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
This could happen for several reasons, for example a bad image path or tag or if the credentials for pulling images are not configured properly.


@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is ImagePullBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:ImagePullBackOff
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
    critical = 1
  }
  priority = null
}