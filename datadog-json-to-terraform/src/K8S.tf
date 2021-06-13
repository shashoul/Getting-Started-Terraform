resource "datadog_monitor" K8S_1 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Container"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {container_name} > 300000000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_2 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.cpu.usage.total{*} by {host} > 300000000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_3 {

 name = "Terraform - Kubernetes -  CPU Total Usage is high on Pod"
 type = "query alert"
 query = "avg(last_1m):max:kubernetes.cpu.usage.total{*} by {pod_name} > 300000000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 300000000.0
 warning = 250000000.0
 critical_recovery = 240000000.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_4 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Container"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {container_name} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_5 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Node"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {host} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_6 {

 name = "Terraform - Kubernetes -  Memory Usage is high on Pod"
 type = "query alert"
 query = "avg(last_10m):max:kubernetes.memory.usage_pct{*} by {pod_name} > 3"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 3.0
 warning = 2.0
 critical_recovery = 2.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_7 {

 name = "Terraform - Kubernetes - CPU Total Usage is high on Node Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(max:kubernetes.cpu.usage.total{*} by {host}, 'robust', 2, direction='above', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 15
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_8 {

 name = "Terraform - Kubernetes Nodes - Container Has Stopped Working"
 type = "query alert"
 query = "avg(last_15m):sum:kubernetes_state.container.terminated{*} by {container} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_9 {

 name = "Terraform - Kubernetes Nodes - Desired Pods and Available Pods Are Unmatched"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_desired{*} by {host} / avg:kubernetes_state.deployment.replicas_available{*} by {host} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_10 {

 name = "Terraform - Kubernetes Nodes - Memory Utilization Exceeded Pod Limit"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes.memory.usage{*} by {pod_name} / avg:kubernetes.memory.limits{*} by {pod_name} > 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_11 {

 name = "Terraform - Kubernetes Nodes - Node is not OK"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.node.status{*} by {host} < 1"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = 1
}


resource "datadog_monitor" K8S_12 {

 name = "Terraform - Kubernetes Nodes - Number of Unavailable Pods is High"
 type = "query alert"
 query = "avg(last_10m):avg:kubernetes_state.deployment.replicas_unavailable{*} by {host} > 0"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" K8S_13 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(sum:kubernetes.network.tx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_14 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is High"
 type = "query alert"
 query = "avg(last_1h):sum:kubernetes.network.tx_bytes{*} by {host} > 100000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 90000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_15 {

 name = "Terraform - Kubernetes Nodes - Number of bytes Transmitted is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.tx_bytes{*} by {host} < 10000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 10000.0
 warning = 15000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_16 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:kubernetes.network.rx_bytes{*} by {host}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 120
 escalation_message = ""
 monitor_threshold_windows {
 recovery_window = "last_1h"
 trigger_window = "last_30m"
 } 
 monitor_thresholds {
 critical = 0.6
 warning = 0.5
 critical_recovery = 0.0
 } 
 priority = 4
}


resource "datadog_monitor" K8S_17 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is High"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} > 300000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 300000.0
 warning = 200000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_18 {

 name = "Terraform - Kubernetes Nodes - Number of bytes received is Low"
 type = "query alert"
 query = "avg(last_10m):sum:kubernetes.network.rx_bytes{*} by {host} < 15000"
 message = <<EOF
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
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 600
 escalation_message = ""
 monitor_thresholds {
 critical = 15000.0
 warning = 20000.0
 } 
 priority = 3
}


resource "datadog_monitor" K8S_19 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Deployments Replica Pods"
 type = "query alert"
 query = "avg(last_15m):avg:kubernetes_state.deployment.replicas_desired{*} by {deployment} - avg:kubernetes_state.deployment.replicas_ready{*} by {deployment} >= 2"
 message = <<EOF
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
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 5
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_20 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
 type = "query alert"
 query = "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed} by {kubernetes_cluster,kube_namespace} > 10"
 message = <<EOF
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
 tags = ["integration:kubernetes",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 10.0
 warning = 5.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_21 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Pods Restarting"
 type = "query alert"
 query = "change(sum(last_5m),last_5m):exclude_null(avg:kubernetes.containers.restarts{*} by {pod_name}) > 5"
 message = <<EOF
Pods are restarting multiple times in the last five minutes.

@webhook-XiteIt

Summary:Kubernetes - {{pod_name.name}}  Has Been Restarted {{value}} Times in The Last 5 Minutes.  
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:Kubernetes - {{pod_name.name}}
Service:High Pods Restarting Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 10
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 warning = 3.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_22 {

 name = "Terraform - [kubernetes] Monitor Kubernetes Statefulset Replicas"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.statefulset.replicas_desired{*} by {statefulset} - sum:kubernetes_state.statefulset.replicas_ready{*} by {statefulset} >= 2"
 message = <<EOF
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
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 2.0
 warning = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_23 {

 name = "Terraform - [kubernetes] Monitor Unschedulable Kubernetes Nodes"
 type = "query alert"
 query = "max(last_15m):sum:kubernetes_state.node.status{status:schedulable} by {kubernetes_cluster} * 100 / sum:kubernetes_state.node.status{*} by {kubernetes_cluster} < 80"
 message = <<EOF
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
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_24 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:crashloopbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
This alert could generate several alerts for a bad deployment.

@webhook-XiteIt

Summary:Kubernetes - Pod {{pod_name.name}} is CrashloopBackOff on {{kube_namespace.name}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Kubernetes - {{kube_namespace.name}}
Service:CrashloopBackOff
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


resource "datadog_monitor" K8S_25 {

 name = "Terraform - [kubernetes] Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
 type = "query alert"
 query = "max(last_10m):max:kubernetes_state.container.status_report.count.waiting{reason:imagepullbackoff} by {kube_namespace,pod_name} >= 1"
 message = <<EOF
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
 tags = ["integration:kubernetes",]
 notify_audit = true
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 1.0
 } 
 priority = null
}


