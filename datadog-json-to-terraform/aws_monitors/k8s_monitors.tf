resource "datadog_monitor" "k8s_bytes_received_anomaly_monitor" {

  name                = "Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes received Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes received - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  priority = 4
}
resource "datadog_monitor" "k8s_bytes_received_high_monitor" {

  name                = "Kubernetes Nodes - Number of bytes received is High"
  type                = "query alert"
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes received
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 300000
    warning  = 200000
  }
  priority = 3
}
resource "datadog_monitor" "k8s_bytes_received_low_monitor" {

  name                = "Kubernetes Nodes - Number of bytes received is Low"
  type                = "query alert"
  query               = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{Value}} bytes received on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes received
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
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = true
  monitor_thresholds {
    critical = 15000
    warning  = 20000
  }
  priority = 3
}
resource "datadog_monitor" "k8s_bytes_transmitted_anomaly_monitor" {

  name                = "Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - {{value}} bytes Transmitted Anomaly (Weekly) on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Number of bytes Transmitted - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  priority = 4
}
resource "datadog_monitor" "k8s_bytes_transmitted_high_monitor" {

  name                = "Kubernetes Nodes - Number of bytes Transmitted is High"
  type                = "query alert"
  query               = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical = 100000
    warning  = 90000
  }
  priority = 3
}
resource "datadog_monitor" "k8s_bytes_transmitted_low_monitor" {

  name                = "Kubernetes Nodes - Number of bytes Transmitted is Low"
  type                = "query alert"
  query               = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} bytes Transmitted on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:Low Number of bytes Transmitted
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 10000
    warning  = 15000
  }
  priority = 3
}
resource "datadog_monitor" "k8s_container_stopped_monitor" {

  name                = "Kubernetes Nodes - Container Has Stopped Working"
  type                = "query alert"
  query               = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:Container:P3 - {{container_name}} Has Stopped Working
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Container:{{container_name}}
Service:Container is Down
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0
  }
  priority = 3
}
resource "datadog_monitor" "k8s_cpu_high_usage_anomaly_monitor" {

  name                = "Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
  type                = "query alert"
  query               = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 

Summary:P4 - CPU Total Usage is {{value}} on Node Anomaly (Weekly)
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:CPU Total Usage on Node - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = false
  no_data_timeframe   = 15
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 120
  escalation_message  = ""
  monitor_threshold_windows {
    recovery_window = "last_1h"
    trigger_window  = "last_30m"
  }
  monitor_thresholds {
    critical          = 0.6
    warning           = 0.5
    critical_recovery = 0
  }
  priority = 4
}
resource "datadog_monitor" "k8s_cpu_high_usage_container_monitor" {

  name                = "Kubernetes -  CPU Total Usage is high on Container"
  type                = "query alert"
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 
Summary:P2 - CPU Usage is {{value}} on Container: {{container_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Container:{{container_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000
    warning           = 250000000
    critical_recovery = 240000000
  }
  priority = 2
}
resource "datadog_monitor" "k8s_cpu_high_usage_node_monitor" {

  name                = "Kubernetes -  CPU Total Usage is high on Node"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Node: {{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000
    warning           = 250000000
    critical_recovery = 240000000
  }
  priority = 2
}
resource "datadog_monitor" "k8s_cpu_usage_high_pod_monitor" {

  name                = "Kubernetes -  CPU Total Usage is high on Pod"
  type                = "query alert"
  query               = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - CPU Usage is {{value}} on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:CPU Usage
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  escalation_message  = ""
  monitor_thresholds {
    critical          = 300000000
    warning           = 250000000
    critical_recovery = 240000000
  }
  priority = 2
}
resource "datadog_monitor" "k8s_desired_available_pods_unmatch_monitor" {

  name                = "Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
  type                = "query alert"
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - Desired Pods and Available Pods Are Unmatched on Node:{{host}}
Critical Threshold:-
Warning Threshold:-

Host:Kubernetes Node:{{host}}
Service:Unmatched Desired Pods and Available Pods
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
  evaluation_delay    = 600
  escalation_message  = ""
  no_data_timeframe   = 30
  include_tags        = false
  monitor_thresholds {
    critical = 1
  }
  priority = 2
}
resource "datadog_monitor" "k8s_memory_high_usage_container_monitor" {

  name                = "Kubernetes -  Memory Usage is high on Container"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Container: {{container_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Container:{{container_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3
    warning           = 2
    critical_recovery = 2
  }
  priority = 3
}
resource "datadog_monitor" "k8s_memory_high_usage_node_monitor" {

  name                = "Kubernetes -  Memory Usage is high on Node"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2
@webhook-XiteIt 

@webhook-XiteIt 

Summary:P2 - {{value}} Memory Usage on Node: {{host}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Node:{{host}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3
    warning           = 2
    critical_recovery = 2
  }
  priority = 2
}
resource "datadog_monitor" "k8s_memory_high_usage_pod_monitor" {

  name                = "Kubernetes -  Memory Usage is high on Pod"
  type                = "query alert"
  query               = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - {{value}} Memory Usage on Pod: {{pod_name}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Usage
Value:{{value}}%
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical          = 3
    warning           = 2
    critical_recovery = 2
  }
  priority = 3
}
resource "datadog_monitor" "k8s_memory_utilization_exceeded_pod_limit_monitor" {

  name                = "Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
  type                = "query alert"
  query               = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 

Summary:P3 - Memory Utilization Exceeded Pod Limit on Pod: {{pod_name}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Pod:{{pod_name}}
Service:Memory Utilization Exceeded Pod Limit
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 1
  }
  priority = 3
}
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
resource "datadog_monitor" "k8s_unavailable_pods_high_monitor" {

  name                = "Kubernetes Nodes - Number of Unavailable Pods is High"
  type                = "query alert"
  query               = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
  message             = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 

Summary:P2 - {{value}} Unavailable Pods on Node:{{host}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Kubernetes Node:{{host}}
Service:High Number of Unavailable Pods
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
  tags                = []
  notify_audit        = false
  locked              = false
  timeout_h           = 0
  include_tags        = true
  no_data_timeframe   = 30
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = true
  renotify_interval   = 0
  evaluation_delay    = 600
  escalation_message  = ""
  monitor_thresholds {
    critical = 0
  }
  priority = 2
}
