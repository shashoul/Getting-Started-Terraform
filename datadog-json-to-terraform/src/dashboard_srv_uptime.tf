#####
#
# dashboard
#
#####
resource "datadog_dashboard" dashboard_1 {

 notify_list = []
 description = ""
 template_variable {
 default = "*"
 prefix = "@bindid_env"
 name = "Environment"
 } 
 is_read_only = false
 title = "SRV Uptime - Production & SandBox Dashboard"
 url = "/dashboard/ejd-rrt-u57/srv-uptime---production--sandbox-dashboard"
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "500: Backend & Management Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"statusCode: [500]\" OR \"status: [500]\" -\"uri: [/api/v2/auth/*]\" -\"uri: [/api/v2/oidc/bindid-oidc/complete]\" -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket -\"api_audience:backend\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 13
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 3"
 label = " y > 3 "
 } 
 show_legend = true
 title = "500: End-Users Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"statusCode: [500]\" (\"uri: [/api/v2/auth/*]\" OR \"uri: [/api/v2/oidc/bindid-oidc/complete]\")) -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 13
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 "
 } 
 show_legend = true
 title = "Cloudfront - 4XX Error Rate is High"
 request {
 q = "avg:aws.cloudfront.4xx_error_rate{environment:production}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 61
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5% "
 } 
 show_legend = true
 title = "Cloudfront - 5XX Error Rate is High"
 request {
 q = "avg:aws.cloudfront.5xx_error_rate{*}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 77
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "ELB Monitor - Count 4XX errors on auth server"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "service:elb status:warn @http.url_details.path:\"/api/v2/oidc/bindid-oidc/token\""
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 141
 x = 49
 height = 14
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "FIDO Registration Failures"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "\"assertion_error_code:9\" @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 77
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Invalid HTTP Method: Frontend/End-User Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"statusCode: [500]\" \"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 29
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5 "
 } 
 show_legend = true
 title = "Management Console Bad Logins"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/*]\" \"Bad administrator session\") OR (\"uri: [/api/v2/mng-ui/*]\" \"Bad credentials provided\")) @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 125
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Number of \"Alias already set\" Errors Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server api_error_code alias_already_set @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 141
 x = 1
 height = 14
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5 "
 } 
 show_legend = true
 title = "Recovery Journey Invocations Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״ @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 29
 x = 147
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5 "
 } 
 show_legend = true
 title = "Ticket consumption errors"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "cannot_consume_ticket ERROR 401 @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 45
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5 "
 } 
 show_legend = true
 title = "User Cancellation"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\") ((\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\" \"errorCode: [4001]\" \"you denied the request\") OR (\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") OR (\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\")) @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 61
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y > 5 "
 } 
 show_legend = true
 title = "User not found for backend/management support APIs Status"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/support/user*]\" \"User not found\") OR (\"uri: [/api/v2/mng-ui/reports/user*]\" \"User not found\")) @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 61
 x = 147
 height = 15
 width = 47
 } 
 } 
 widget {
 free_text_definition { 
 color = "#000"
 text = "Backend"
 font_size = "56"
 text_align = "left" 
 }
 widget_layout {
 y = 4
 x = 38
 height = 6
 width = 24
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "4XX: Backend & Management - Uncategorized"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server @http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\"/api/v2/oidc/bindid-oidc/complete\" @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 13
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 rsps "
 } 
 show_legend = true
 title = "AWS ALB - 4XX Error Rate is High"
 request {
 q = "avg:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count()"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 29
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 10"
 label = " y > 10 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 7"
 label = " y > 7 rsps "
 } 
 show_legend = true
 title = "AWS ALB - 5XX Error Rate is High Status"
 request {
 q = "avg:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count()"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 29
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Backend & Management - unsupported_grant"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" unsupported_grant_type \"Unsupported grant type\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 45
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Backend & Management – invalid_grant"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" invalid_grant \"Invalid redirect uri\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 61
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "End User - invalid_client"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" invalid_client \"Invalid client credentials\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 13
 x = 147
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "Invalid HTTP Method: Backend/Management"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"statusCode: [500]\" -\"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 93
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "Invalid Request - Invalid redirect URI on /authorize"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Invalid redirect uri\" @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 93
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "Invalid Request - Missing client_id on /authorize"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Missing \" client_id @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 109
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Invalid authentication to BindID Backend API"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\" \"api_error_code: invalid_auth\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 109
 x = 49
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "Invalid client credentials on /token"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" \"error: invalid_client\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 125
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 rsps "
 } 
 show_legend = true
 title = "Test on admin.bindid-sandbox.io/version - Response time check"
 request {
 q = "avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version}, avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 77
 x = 147
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 rsps "
 } 
 show_legend = true
 title = "Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 request {
 q = "avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status}, avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 77
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 free_text_definition { 
 color = "#000"
 text = "End-user"
 font_size = "56"
 text_align = "left" 
 }
 widget_layout {
 y = 4
 x = 136
 height = 6
 width = 24
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "All Invalid Request Errors on /authorize - Categorized -"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server @error_category:\"All Invalid Request Errors on /authorize\" @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 45
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 1"
 label = " y >= 1 "
 } 
 show_legend = true
 title = "OIDC Backend invalid_request errors"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/*]\" \"error: invalid_request\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 156
 x = 1
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 5"
 label = " y >= 5 "
 } 
 show_legend = true
 title = "Unknown authorization code on /token"
 request {
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 log_query {
 index = "*"
 search_query = "source:bindid-authentication-server (\"status: [400]\" \"Unknown authorization code\") @bindid_env:$Environment.value"
 compute_query {
 aggregation = "count"
 } 
 } 
 }  
 }
 widget_layout {
 y = 45
 x = 147
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 rsps "
 } 
 show_legend = true
 title = "Test on ts.bindid.io/api/v2/status - Response time check"
 request {
 q = "avg:synthetics.http.response.time{url:https://ts.bindid.io/api/v2/status}, avg:synthetics.http.dns.time{url:https://ts.bindid.io/api/v2/status}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 93
 x = 99
 height = 15
 width = 47
 } 
 } 
 widget {
 timeseries_definition { 
 title_size = "16"
 yaxis {
 include_zero = true
 max = "auto"
 scale = "linear"
 min = "auto"
 label = ""
 } 
 title_align = "left"
 marker {
 display_type = "error dashed"
 value = "y = 50"
 label = " y > 50 rsps "
 } 
 marker {
 display_type = "warning dashed"
 value = "y = 30"
 label = " y > 30 rsps "
 } 
 show_legend = true
 title = "Test on admin.bindid.io/version - Response time check"
 request {
 q = "avg:synthetics.http.response.time{url:https://admin.bindid.io/version}, avg:synthetics.http.dns.time{url:https://admin.bindid.io/version}"
 style {
 line_width = "normal"
 palette = "dog_classic"
 line_type = "solid"
 } 
 display_type = "line"
 }  
 }
 widget_layout {
 y = 93
 x = 147
 height = 15
 width = 47
 } 
 } 
 layout_type = "free"
}


