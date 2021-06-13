resource "datadog_monitor" Cloudfront_1 {

 name = "Terraform - Cloudfront - 401 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.401_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 401 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 401 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_2 {

 name = "Terraform - Cloudfront - 403 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.403_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 403 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 403 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = false
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_3 {

 name = "Terraform - Cloudfront - 404 Error Rate is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.404_error_rate{environment:production} >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt
 
Summary:P1 - 404 Error Rate on Cloudfront is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 404 Error Rate is High
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = null
 require_full_window = true
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_4 {

 name = "Terraform - Cloudfront - 4XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.4xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@shahd@transmitsecurity.com @slack-cloud-alerts-bindid-prd
Priority:P2

@webhook-XiteIt 
Summary:P2- {{value}} 4XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 4XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
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
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_5 {

 name = "Terraform - Cloudfront - 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.4xx_error_rate{environment:production} > 5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt


Summary:P1 - {{value}} 4XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_6 {

 name = "Terraform - Cloudfront - 5XX Error Rate Anomaly  (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.5xx_error_rate{*}, 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P3

@webhook-XiteIt 
Summary:P3 - {{value}} 5XX Error Rate on Cloudfront (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Cloudfront - 5XX Error Rate - Anomaly
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
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
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_7 {

 name = "Terraform - Cloudfront - 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.5xx_error_rate{*} > 5"
 message = <<EOF
@slack-bindid-prd-alerts
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} 5XX Error Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 5.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_8 {

 name = "Terraform - Cloudfront - Cache Hit Rate is Low"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} by {distributionid} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}} Cache Hit Rate on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:Low Cache Hit Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_9 {

 name = "Terraform - Cloudfront - Distribution 4XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.4xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
Priority:P1

@webhook-XiteIt 
Summary:P1 - Distribution 4XX Error Rate on {{distributionid}} is {{value}}%
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront - {{distributionid}}
Service:High Distribution 4XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_10 {

 name = "Terraform - Cloudfront - Distribution 5XX Error Rate is High"
 type = "query alert"
 query = "avg(last_15m):sum:aws.cloudfront.5xx_error_rate{environment:production} by {distributionid} > 50"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 -  {{value}} Distribution 5XX Error Rate on {{distributionid}}
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:High Distribution 5XX Error Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 50.0
 warning = 30.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_11 {

 name = "Terraform - Cloudfront - High Avg Response time on CDN"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} > 700"
 message = <<EOF
@slack-cloud-alerts-bindid-prd
@webhook-XiteIt 

Note: No need to be calculated for our service uptime slack channel per Eldan's request
Priority:P1

Summary:P1 - Avg Response time on CDN is {{value}} 
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront
Service:High Avg Response time on CDN
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
 critical = 700.0
 warning = 650.0
 } 
 priority = 1
}


resource "datadog_monitor" Cloudfront_12 {

 name = "Terraform - Cloudfront - Low Avg Cache Hit Rate"
 type = "query alert"
 query = "avg(last_15m):avg:aws.cloudfront.cache_hit_rate{environment:production} <= 80"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - Avg Cache Hit Rate on Cloudfront is {{value}} 
Critical Threshold:{{threshold}}%
Warning Threshold:{{warn_threshold}}%

Host:AWS Cloudfront {{distributionid}}
Service:Low Avg Cache Hit Rate
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 80.0
 warning = 90.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_13 {

 name = "Terraform - Cloudfront - Number of Requests Anomaly (Weekly)"
 type = "query alert"
 query = "avg(last_12h):anomalies(avg:aws.cloudfront.requests{*}.as_count(), 'robust', 2, direction='both', alert_window='last_30m', interval=120, count_default_zero='true', seasonality='weekly', timezone='asia/jerusalem') >= 0.5"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P3

Summary:P3 - Weekly Number of Couldfront Requests is {{value}}  (Anomaly)
Critical Threshold:-
Warning Threshold:-

Host:AWS Cloudfront
Service:Number of Requests - Anomaly
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
 critical = 0.5
 warning = 0.4
 critical_recovery = 0.0
 } 
 priority = 3
}


resource "datadog_monitor" Cloudfront_14 {

 name = "Terraform - Cloudfront - Number of Requests is High"
 type = "query alert"
 query = "sum(last_15m):sum:aws.cloudfront.requests{environment:production}.as_count() > 2500"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P2

Summary:P2 - {{value}}  Requests on Cloudfront
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:AWS Cloudfront
Service:High Number of Requests
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = false
 no_data_timeframe = 30
 require_full_window = false
 new_host_delay = 300
 notify_no_data = true
 renotify_interval = 0
 evaluation_delay = 900
 escalation_message = ""
 monitor_thresholds {
 critical = 2500.0
 warning = 1500.0
 } 
 priority = 2
}


resource "datadog_monitor" Cloudfront_15 {

 name = "Terraform - Cloudfront - Response Time on CDN Distribution is High"
 type = "metric alert"
 query = "avg(last_15m):avg:aws.cloudfront.origin_latency{*} by {distributionid} > 720"
 message = <<EOF
@webhook-XiteIt  @slack-cloud-alerts-bindid-prd
Priority:P1

Summary:P1 - Response Time on CDN Distribution:{{distributionid}} is {{value}}
Critical Threshold:{{threshold}}s
Warning Threshold:{{warn_threshold}}s

Host:AWS Cloudfront {{distributionid}}
Service:High Response Time on CDN Distribution
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = true
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
 critical = 720.0
 warning = 660.0
 } 
 priority = 1
}


