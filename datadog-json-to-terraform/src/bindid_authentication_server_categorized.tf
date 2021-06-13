resource "datadog_monitor" bindid_authentication_server_categorized_1 {

 name = "Terraform - 4XX: Backend & Management - Uncategorized, non-foreign"
 type = "log alert"
 query = "logs(\"@http.status_code:(400 OR 401 OR 404) @api_audience:backend -@error_category:(\\\"OIDC /complete with errors\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found for backend/management support APIs\\\" OR \\\"Management Console Bad Logins\\\" OR \\\"Unknown authorization code on /token\\\" OR \\\"Invalid client credentials on /token\\\" OR \\\"Invalid authentication to BindID Backend API\\\" OR \\\"OIDC Backend invalid_request errors\\\" OR \\\"Number of \\\\\"Alias already set\\\\\" Errors\\\" OR \\\"Backend & Management - unsupported_grant\\\" OR \\\"Backend & Management – invalid_grant\\\" OR \\\"Foreign errors\\\") -@uri:\\\"/api/v2/oidc/bindid-oidc/complete\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} 4XX Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management - Uncategorized
Service:4XX Errors
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_2 {

 name = "Terraform - 4XX: End-Users - Uncategorized, non-foreign"
 type = "log alert"
 query = "logs(\"source:bindid-authentication-server @api_audience:enduser -@error_category:(\\\"End User - invalid_client\\\" OR \\\"User Cancellation\\\" OR \\\"Invalid Request - Invalid redirect URI on /authorize\\\" OR \\\"Invalid Request - Missing client_id on /authorize\\\" OR \\\"Ticket consumption errors\\\" OR \\\"User not found errors\\\" OR \\\"Device not found errors\\\" OR \\\"OIDC /complete with errors\\\" OR \\\"Foreign errors\\\") @http.status_code:(400 OR 401 OR 404)\").index(\"*\").rollup(\"count\").last(\"15m\") >= 3"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - {{value}} 4XX End-Users Errors

Critical Threshold:{{threshold}}
Warning Threshold:-

Host: 4XX: End-Users - Uncategorized
Service: Number of 4XX Errors 
Value: {{value}}
Severity: {{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_3 {

 name = "Terraform - 500: Backend & Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: Backend & Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Status Code 500 Errors on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_4 {

 name = "Terraform - 500: End-Users - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"500: End-Users\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 3"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} Status Code 500 Errors on End-Users

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End-Users
Service:Number of 500 Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 3.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_5 {

 name = "Terraform - Number of \"Alias already set\" Errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Number of \\\" Alias already set \\\" Errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - "Alias already set" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "Alias already set" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_6 {

 name = "Terraform - All Invalid Request Errors on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"All Invalid Request Errors on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}}  Invalid Request Errors on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_7 {

 name = "Terraform - Backend & Management - unsupported_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management - unsupported_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
Summary:P1 - {{value}} unsupported_grant on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of unsupported_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_8 {

 name = "Terraform - Backend & Management – invalid_grant - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Backend & Management – invalid_grant\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@webhook-Uptime-XiteIt
@slack-bindid-srv-uptime-alerts

Summary:P1 - {{value}} invalid_grants on Backend & Management

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend & Management
Service:Number of invalid_grants
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_9 {

 name = "Terraform - Device not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Device not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Device not found errors
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Device not found errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_10 {

 name = "Terraform - End User - invalid_client - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"End User - invalid_client\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - End User - {{value}}  invalid_client authentications
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:Number of Invalid_client Authentications
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_11 {

 name = "Terraform - Expression evaluation errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Expression evaluation errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts @webhook-Refine-XiteIt

Summary:P1 - {{value}} Unexpected exception during field resolution
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of Expression evaluation errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_12 {

 name = "Terraform - FIDO Registration Failures - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"FIDO Registration Failures\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") >= 1"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}} FIDO Registration Failures
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:End User
Service:High Number of FIDO Registration Failures
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 1.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_13 {

 name = "Terraform - Invalid HTTP Method: Backend/Management - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Backend/Management\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Backend/Management
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend/Management
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_14 {

 name = "Terraform - Invalid HTTP Method: Frontend/End-User - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid HTTP Method: Frontend/End-User\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid HTTP Method on Frontend/End-User
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Frontend/End-User
Service:High Number of Invalid HTTP Method
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_15 {

 name = "Terraform - Invalid Request - Invalid redirect URI on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Invalid redirect URI on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 10"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P1 - {{value}} Invalid redirect URI on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:Invalid redirect URI
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 10.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_16 {

 name = "Terraform - Invalid Request - Missing client_id on /authorize - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid Request - Missing client_id on /authorize\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid Request - Missing client_id on /authorize
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/authorize
Service:High Number of Invalid Request Errors - Missing client_id on /authorize
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_17 {

 name = "Terraform - Invalid authentication to BindID Backend API - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid authentication to BindID Backend API\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}}  Invalid authentication to BindID on Backend API
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Backend API
Service:High Number of Invalid authentication to BindID
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_18 {

 name = "Terraform - Invalid client credentials on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Invalid client credentials on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - {{value}} Invalid client credentials on /token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:/token
Service:Invalid client credentials
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_19 {

 name = "Terraform - Management Console Bad Logins - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Management Console Bad Logins\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:P1 - {{Value}} Bad Logins on Management Console
Critical Threshold:{{threshold}}
Warning Threshold:{{warn_threshold}}

Host:Management Console
Service:High Number of Bad Logins
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_20 {

 name = "Terraform - OIDC /complete with errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC /complete with errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt 

Summary:P1 - "Client returned with error" / "Session rejected by server" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of  "Client returned with error" / "Session rejected by server" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_21 {

 name = "Terraform - OIDC Backend invalid_request errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"OIDC Backend invalid_request errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Summary:P1 - "invalid_request" Errors on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Number of "invalid_request" Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}} @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_22 {

 name = "Terraform - Recovery Journey Invocations - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Recovery Journey Invocations\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - Recovery Journey Invocations on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Recovery Journey Invocations
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_23 {

 name = "Terraform - Ticket consumption errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Ticket consumption errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:cannot_consume_ticket - 401 Errors Number on bindid-authentication-server is {{value}} 
Critical Threshold:{{threshold}} 
Warning Threshold:-

Host:bindid-authentication-server
Service:High cannot_consume_ticket - 401 Errors Number 
Value:{{value}} 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_24 {

 name = "Terraform - Unknown authorization code on /token - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Unknown authorization code on /token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt

Summary:P1 - "Unknown Authorization Code" Errors Number on bindid-authentication-server - /token is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High Unknown Authorization Code Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_25 {

 name = "Terraform - User Cancellation - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User Cancellation\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Cancellation Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Cancellation Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_26 {

 name = "Terraform - User not found errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 enable_logs_sample = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_27 {

 name = "Terraform - User not found for backend/management support APIs - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"User not found for backend/management support APIs\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") > 5"
 message = <<EOF
@slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt

Summary:P1 - User Not Found Errors Number on bindid-authentication-server - backend/management support APIs is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:High User Not Found Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 renotify_interval = 0
 enable_logs_sample = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 include_tags = true
 restriction_query = null
 priority = 1
}


resource "datadog_monitor" bindid_authentication_server_categorized_28 {

 name = "Terraform - Foreign errors - Categorized"
 type = "log alert"
 query = "logs(\"@error_category:\\\"Foreign errors\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
@slack-bindid-srvrefine-uptime-alerts
@webhook-Refine-XiteIt

Summary:P1 - Foreign errors on bindid-authentication-server is {{value}}
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:bindid-authentication-server
Service:Foreign errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
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
 restriction_query = null
 priority = 1
}


