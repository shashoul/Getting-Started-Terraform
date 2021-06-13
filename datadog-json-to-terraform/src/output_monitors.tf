#####
#
# monitor
#
#####
resource "datadog_monitor" monitor_1 {

 tags = ["Ring1","Production",]
 query = "logs(\"@http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized 
Service:4XX Errors - Production
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "4XX: Backend & Management - Uncategorized, non-foreign - Production"
 priority = 1
 type = "log alert"
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
}


resource "datadog_monitor" monitor_2 {

 tags = ["Ring1","Production",]
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:* @http.status_code:(400 OR 401 OR 404) @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized, non foreign 
Service: Number of 4XX Errors - Production
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "4XX: End-Users - Uncategorized, non-foreign - Production"
 priority = 1
 type = "log alert"
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
}


resource "datadog_monitor" monitor_3 {

 tags = ["Ring1","Production",]
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management 
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "500: Backend & Management - Categorized - Production"
 priority = 1
 type = "log alert"
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
}


resource "datadog_monitor" monitor_4 {

 tags = ["Ring1","Production",]
 query = "logs(\"@error_category:\\\"500: End-Users\\\" @bindid_env:production\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users - Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors - Production
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "500: End-Users - Categorized - Production"
 priority = 1
 type = "log alert"
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
}


