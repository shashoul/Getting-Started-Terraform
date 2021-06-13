resource "datadog_monitor" Bindid_1 {

 name = "Terraform - BindID Self Serve Failed Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Failure\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-failure-alerts
Priority:-
@webhook-XiteIt 

Summary:{{value}} Failed Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Failed Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_2 {

 name = "Terraform - BindID Self Serve Successful Registrations on env: BindID Production"
 type = "log alert"
 query = "logs(\"self-serve-registration;Success\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-p-bindid-selfserve-success-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Successful Registrations on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Self Serve Successful Registrations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_3 {

 name = "Terraform - BindId Service Errors on env: BindID Production"
 type = "log alert"
 query = "logs(\"source:(nodejs OR bindid-authentication-server OR bindid-authentication-server-activity-log) service:(bindid-oauth-service OR bindid-appless-service OR bindid-demo-app OR bindid-authentication-server) status:error\").index(\"*\").rollup(\"count\").by(\"service\").last(\"5m\") > 5"
 message = <<EOF
@slack-bindid-prd-alerts
Priority:-

@webhook-XiteIt 

Summary:{{value}} Service Errors on BindID Production

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:BindID Production
Service:Number of Service Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = []
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = null
}


resource "datadog_monitor" Bindid_4 {

 name = "Terraform - Test on admin.bindid-sandbox.io/version - Response time check"
 type = "query alert"
 query = "avg(last_15m):avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version} - avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on admin.bindid-sandbox.io/version is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:admin.bindid-sandbox.io/version
Service:High Response Time
Value:{{value}}ms
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
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_5 {

 name = "Terraform - Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "query alert"
 query = "avg(last_5m):avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status} - avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status} > 250"
 message = <<EOF
@slack-bindid-srv-uptime-alerts 
@webhook-Uptime-XiteIt

Summary:P1 - Response Time on ts.bindid-sandbox.io/api/v2/status is {{value}}ms
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:ts.bindid-sandbox.io/api/v2/status
Service:High Response Time
Value:{{value}}ms
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
 critical = 250.0
 } 
 priority = 1
}


resource "datadog_monitor" Bindid_6 {

 name = "Terraform - URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"(-\\\"/api/*\\\" OR \\\"/.well-known/openid-configuration\\\" OR \\\"/_complete/*\\\" OR \\\"/ama\\\" OR \\\"/authorize\\\" OR \\\"/authorize_ciba\\\" OR \\\"/config/*\\\" OR \\\"/console\\\" OR \\\"/console/invite\\\" OR \\\"/console/preview\\\" OR \\\"/console/resume-invite\\\" OR \\\"/demo-token-exchange\\\" OR \\\"/initial/*\\\" OR \\\"/jwks\\\" OR \\\"/login\\\" OR \\\"/logout\\\" OR \\\"/manage\\\" OR \\\"/manage/delete-device\\\" OR \\\"/manage/login\\\" OR \\\"/manager/html\\\" OR \\\"/other_login\\\" OR \\\"/playground\\\" OR \\\"/register\\\" OR \\\"/registration-result\\\" OR \\\"/report\\\" OR \\\"/send-session-feedback\\\" OR \\\"/session-feedback\\\" OR \\\"/token\\\" OR \\\"/userinfo\\\" OR \\\"/version\\\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \\\"/styles.eeed0a952180434276c0.css\\\" OR \\\"/styles.7579e9ab48bb69114ea4.css\\\" OR \\\"/favicon.ico\\\" OR \\\"/img/playground-hover.svg\\\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time on {{[@http.url_details.path].name}} is {{value}}ms 
Critical Threshold:{{threshold}}ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:High Response Time
Value:{{value}}ms
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


resource "datadog_monitor" Bindid_7 {

 name = "Terraform - API's - Response time over 250ms for {{[@http.url_details.path].name}}"
 type = "log alert"
 query = "logs(\"service:cloudfront @http.referer:(\\\"https://admin.bindid-sandbox.io/\\\" OR \\\"https://ts.bindid-sandbox.io/console/\\\" OR \\\"https://admin.bindid-sandbox.io/console/\\\") @http.url_details.path:(\\\"/api/v2/mng-ui/application/policies\\\" OR \\\"/api/v2/mng-ui/identity/trusted/list\\\" OR \\\"/api/v2/mng-ui/application/procedures\\\" OR \\\"/api/v2/mng-ui/localization/keys\\\" OR \\\"/api/v1/tenants\\\" OR \\\"/api/v1/tenant\\\" OR \\\"/api/v2/mng-ui/external-connections/metadata\\\" OR \\\"/api/v1/admin-data\\\" OR \\\"/api/v2/mng-ui/debugger/update_debug_context\\\" OR \\\"/api/v2/mng-ui/debugger/console_messages\\\" OR \\\"/api/v2/mng-ui/identity/credentials/list\\\")\").index(\"*\").rollup(\"pc95\", \"@duration\").by(\"@http.url_details.path\").last(\"1h\") > 250000000"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Response Time is {{value}} on {{[@http.url_details.path].name}}

Critical Threshold:250ms
Warning Threshold:-

Host:{{[@http.url_details.path].name}}
Service:Response Time
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 250000000.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


