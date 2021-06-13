# resource "datadog_monitor" "bindid_authentication_server_1" {

#   name         = "Terraform Shady Test - 4XX: Backend & Management - Uncategorized"
#   type         = "log alert"
#   query        = "logs(\"source:bindid-authentication-server (\\\"statusCode: [400]\\\" OR \\\"statusCode: [401]\\\" OR \\\"statusCode: [404]\\\" OR \\\"status: [400]\\\" OR \\\"status: [401]\\\") -\\\"uri: [/api/v2/auth/*]\\\" -\\\"client returned with error\\\" -cannot_consume_ticket -(\\\"uri: [/api/v2/mng-ui/support/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/reports/user*]\\\" \\\"User not found\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad administrator session\\\") -(\\\"uri: [/api/v2/mng-ui/*]\\\" \\\"Bad credentials provided\\\") -\\\"uri: [/api/v2/oidc/bindid-oidc/complete]\\\" -\\\"Unknown authorization code\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" \\\"error: invalid_client\\\") -(\\\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\\\" \\\"api_error_code: invalid_auth\\\") -(\\\"uri: [/api/v2/oidc/*]\\\" \\\"error: invalid_request\\\") -\\\"api_error_code: alias_already_set\\\" -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" invalid_grant \\\"Invalid redirect uri\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/token]\\\" unsupported_grant_type \\\"Unsupported grant type\\\") -(\\\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\\\" invalid_client \\\"Invalid client credentials\\\")\").index(\"*\").rollup(\"count\").last(\"15m\") >= 1"
#   message      = <<EOF
# @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt
# Summary:P1 - {{value}} 4XX Errors on Backend & Management

# Critical Threshold:{{threshold}}
# Warning Threshold:-

# Host:Backend & Management - Uncategorized
# Service:4XX Errors
# Value:{{value}} 
# Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
# EOF
#   tags         = ["Ring1", ]
#   notify_audit = false
#   locked       = false
#   timeout_h    = 0
#   include_tags = true
#   monitor_thresholds {
#     critical = 1.0
#   }
#   new_host_delay = 300

#   notify_no_data    = false
#   renotify_interval = 0

#   # enable_logs_sample = true

#   priority = 1
# }

