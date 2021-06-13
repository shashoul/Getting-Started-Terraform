resource "datadog_monitor" AWS_NAT_1 {

 name = "Terraform - AWS NAT - NAT BytesOutToDestination  is Lower than BytesInFromSource"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} / sum:aws.natgateway.bytes_in_from_source{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3
@webhook-XiteIt 
Summary:P3 - NAT BytesOutToDestination is Lower than BytesInFromSource
 Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToDestination/BytesInFromSource Ratio
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_2 {

 name = "Terraform - AWS NAT - NAT BytesOutToSource is Lower than BytesInFromDestination"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_source{*} / sum:aws.natgateway.bytes_in_from_destination{*} < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of BytesOutToSource is Lower than BytesInFromDestination
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:BytesOutToSource/BytesInFromDestination Ratio
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_3 {

 name = "Terraform - AWS NAT - NAT Connection Failures Count is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.connection_established_count{*}.as_count() / sum:aws.natgateway.connection_attempt_count{*}.as_count() < 0.999"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - AWS NAT - NAT Connection Failures Ratio is High
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Failures Ratio
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.999
 warning = 1.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_4 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_out_to_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Destination is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Destination - Anomaly
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
 evaluation_delay = 900
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


resource "datadog_monitor" AWS_NAT_5 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} > 10000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Bytes Sent to Destination
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 10000000.0
 warning = 9000000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_6 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Destination is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_out_to_destination{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Bytes Sent to Destination is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Bytes Sent to Destination
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 750000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_7 {

 name = "Terraform - AWS NAT - Number of Bytes Sent to Source Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.packets_out_to_source.sum{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Bytes Sent to Source is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Bytes Sent to Source - Anomaly
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
 evaluation_delay = 900
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


resource "datadog_monitor" AWS_NAT_8 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_destination.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Weekly Number of Destination Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Destination Bytes Received - Anomaly
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
 evaluation_delay = 900
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


resource "datadog_monitor" AWS_NAT_9 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} >= 2000000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Destination Bytes Received
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2000000.0
 warning = 1900000.0
 critical_recovery = 1480000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_10 {

 name = "Terraform - AWS NAT - Number of Destination Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_destination{*} < 110000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Destination Bytes Received is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Destination Bytes Received
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 110000.0
 warning = 120000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_11 {

 name = "Terraform - AWS NAT - Number of Error Port Allocations is High"
 type = "query alert"
 query = "sum(last_30m):sum:aws.natgateway.error_port_allocation{*}.as_count() > 0"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2 - {{value}} Port Allocations Errors on AWS NAT
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:AWS NAT
Service:Number of Error Port Allocations
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" AWS_NAT_12 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is High"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() > 100000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Packets Sent to Source
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 100000.0
 warning = 80000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_13 {

 name = "Terraform - AWS NAT - Number of Packets Sent to Source is Low"
 type = "query alert"
 query = "sum(last_1h):sum:aws.natgateway.packets_out_to_source{*}.as_count() < 25000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Packets Sent to Source is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Packets Sent to Source
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 25000.0
 warning = 27000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_14 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.natgateway.bytes_in_from_source.sum{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.6"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P4

@webhook-XiteIt 
Summary:P4 - Number of Source Bytes Received is {{value}} (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS NAT
Service:Number of Source Bytes Received - Anomaly
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
 evaluation_delay = 900
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


resource "datadog_monitor" AWS_NAT_15 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is High"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} >= 2200000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:High number of Source Bytes Received
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2200000.0
 warning = 1800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_16 {

 name = "Terraform - AWS NAT - Number of Source Bytes Received is Low"
 type = "query alert"
 query = "avg(last_30m):sum:aws.natgateway.bytes_in_from_source{*} < 700000"
 message = <<EOF
{{is_alert}}

AWS NAT - Number of bytes received from KS server 

{{is_alert}} @slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - Number of Source Bytes Received is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS NAT
Service:Low number of Source Bytes Received
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
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 700000.0
 warning = 800000.0
 } 
 priority = 3
}


resource "datadog_monitor" AWS_NAT_17 {

 name = "Terraform - [MoovingOn] AWS NAT - High Count of Active Connections"
 type = "query alert"
 query = "sum(last_1h):max:aws.natgateway.active_connection_count{*} by {name}.as_count() >= 2500"
 message = <<EOF
@slack-cloud-alerts-bindid-prd

@webhook-XiteIt

Summary:Count of Active Connections on {{name}}  is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}} 

Host:AWS NAT - {{name}}
Service:High Count of Active Connections
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = true
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = true
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 2000.0
 } 
 priority = 3
}


