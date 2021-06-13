resource "datadog_dashboard" "dashboard_1" {

  notify_list = []
  description = ""
  template_variable {
    default = "*"
    prefix  = "@bindid_env"
    name    = "Environment"
  }
  is_read_only = false
  title        = "SRV Uptime - Production & SandBox Dashboard"
  url          = "/dashboard/ejd-rrt-u57/srv-uptime---production--sandbox-dashboard"
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "500: Backend & Management Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" OR \"status: [500]\" -\"uri: [/api/v2/auth/*]\" -\"uri: [/api/v2/oidc/bindid-oidc/complete]\" -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket -\"api_audience:backend\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 13
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 3"
        label        = " y > 3 "
      }
      show_legend = true
      title       = "500: End-Users Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" (\"uri: [/api/v2/auth/*]\" OR \"uri: [/api/v2/oidc/bindid-oidc/complete]\")) -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 13
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 "
      }
      show_legend = true
      title       = "Cloudfront - 4XX Error Rate is High"
      request {
        q = "avg:aws.cloudfront.4xx_error_rate{environment:production}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 61
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5% "
      }
      show_legend = true
      title       = "Cloudfront - 5XX Error Rate is High"
      request {
        q = "avg:aws.cloudfront.5xx_error_rate{*}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 77
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "ELB Monitor - Count 4XX errors on auth server"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "service:elb status:warn @http.url_details.path:\"/api/v2/oidc/bindid-oidc/token\""
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 141
      x      = 49
      height = 14
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "FIDO Registration Failures"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "\"assertion_error_code:9\" @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 77
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Invalid HTTP Method: Frontend/End-User Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" \"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 29
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5 "
      }
      show_legend = true
      title       = "Management Console Bad Logins"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/*]\" \"Bad administrator session\") OR (\"uri: [/api/v2/mng-ui/*]\" \"Bad credentials provided\")) @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 125
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Number of \"Alias already set\" Errors Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server api_error_code alias_already_set @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 141
      x      = 1
      height = 14
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5 "
      }
      show_legend = true
      title       = "Recovery Journey Invocations Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״ @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 29
      x      = 147
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5 "
      }
      show_legend = true
      title       = "Ticket consumption errors"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "cannot_consume_ticket ERROR 401 @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 45
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5 "
      }
      show_legend = true
      title       = "User Cancellation"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\") ((\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\" \"errorCode: [4001]\" \"you denied the request\") OR (\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") OR (\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\")) @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 61
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y > 5 "
      }
      show_legend = true
      title       = "User not found for backend/management support APIs Status"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/support/user*]\" \"User not found\") OR (\"uri: [/api/v2/mng-ui/reports/user*]\" \"User not found\")) @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 61
      x      = 147
      height = 15
      width  = 47
    }
  }
  widget {
    free_text_definition {
      color      = "#000"
      text       = "Backend"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 4
      x      = 38
      height = 6
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "4XX: Backend & Management - Uncategorized"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @http.status_code:[400 TO 499] @api_audience:backend -@error_category:* -@uri:\"/api/v2/oidc/bindid-oidc/complete\" @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 13
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 rsps "
      }
      show_legend = true
      title       = "AWS ALB - 4XX Error Rate is High"
      request {
        q = "avg:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count()"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 29
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 10"
        label        = " y > 10 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 7"
        label        = " y > 7 rsps "
      }
      show_legend = true
      title       = "AWS ALB - 5XX Error Rate is High Status"
      request {
        q = "avg:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count()"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 29
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Backend & Management - unsupported_grant"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" unsupported_grant_type \"Unsupported grant type\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 45
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Backend & Management – invalid_grant"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" invalid_grant \"Invalid redirect uri\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 61
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "End User - invalid_client"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" invalid_client \"Invalid client credentials\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 13
      x      = 147
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "Invalid HTTP Method: Backend/Management"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" -\"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 93
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "Invalid Request - Invalid redirect URI on /authorize"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Invalid redirect uri\" @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 93
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "Invalid Request - Missing client_id on /authorize"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Missing \" client_id @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 109
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Invalid authentication to BindID Backend API"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\" \"api_error_code: invalid_auth\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 109
      x      = 49
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Invalid client credentials on /token"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" \"error: invalid_client\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 125
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 rsps "
      }
      show_legend = true
      title       = "Test on admin.bindid-sandbox.io/version - Response time check"
      request {
        q = "avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version}, avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 77
      x      = 147
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 rsps "
      }
      show_legend = true
      title       = "Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
      request {
        q = "avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status}, avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 77
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    free_text_definition {
      color      = "#000"
      text       = "End-user"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 4
      x      = 136
      height = 6
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "All Invalid Request Errors on /authorize - Categorized -"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"All Invalid Request Errors on /authorize\" @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 45
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "OIDC Backend invalid_request errors"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/*]\" \"error: invalid_request\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 156
      x      = 1
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 5"
        label        = " y >= 5 "
      }
      show_legend = true
      title       = "Unknown authorization code on /token"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"status: [400]\" \"Unknown authorization code\") @bindid_env:$Environment.value"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 45
      x      = 147
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 rsps "
      }
      show_legend = true
      title       = "Test on ts.bindid.io/api/v2/status - Response time check"
      request {
        q = "avg:synthetics.http.response.time{url:https://ts.bindid.io/api/v2/status}, avg:synthetics.http.dns.time{url:https://ts.bindid.io/api/v2/status}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 93
      x      = 99
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 50"
        label        = " y > 50 rsps "
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 30"
        label        = " y > 30 rsps "
      }
      show_legend = true
      title       = "Test on admin.bindid.io/version - Response time check"
      request {
        q = "avg:synthetics.http.response.time{url:https://admin.bindid.io/version}, avg:synthetics.http.dns.time{url:https://admin.bindid.io/version}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 93
      x      = 147
      height = 15
      width  = 47
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_2" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Sandbox Uptime Service Dashboard"
  url          = "/dashboard/y3f-8ai-pbm/sandbox-uptime-service-dashboard"
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "55ad00f9a95c5aeabd68fc2a6c1e10b2"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Admin Service"
    }
    widget_layout {
      y      = 0
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "2ff174d9c792533798f4554572b1d890"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Auth Service"
    }
    widget_layout {
      y      = 13
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "cb1dad5231d55dc68d46e83af8cc57d9"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on IDP Service"
    }
    widget_layout {
      y      = 19
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "2d59c7879a175e9cadec273b5367a4aa"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Appless Service"
    }
    widget_layout {
      y      = 38
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "78ce67bacc5256c68481783005019ffb"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Developer Service"
    }
    widget_layout {
      y      = 32
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "e66e2e3c92ed53a6ba7273fc9827e34b"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Assets Service"
    }
    widget_layout {
      y      = 51
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    image_definition {
      sizing           = "contain"
      has_background   = false
      horizontal_align = "center"
      has_border       = false
      url              = "https://s3-ap-southeast-2.amazonaws.com/cookbook.transmit-dev.com/logo.png"
      vertical_align   = "center"
      margin           = "md"
    }
    widget_layout {
      y      = 0
      x      = 16
      height = 13
      width  = 25
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "98cd85bfd6a453f3a1ebf5b5a971b2fe"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Backoffice Service"
    }
    widget_layout {
      y      = 57
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "1f9331f3eae25aa78681bac68613daaf"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Demo Service"
    }
    widget_layout {
      y      = 70
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "f1566fd686465e89a03fdfaf44884270"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on MY Service"
    }
    widget_layout {
      y      = 76
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "cd147efd57e85d10a029103a48d32c84"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Aux Service"
    }
    widget_layout {
      y      = 89
      x      = 0
      height = 21
      width  = 62
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_3" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "SRV Refine - SandBox Alerts"
  url          = "/dashboard/ys8-xuh-siy/srv-refine---sandbox-alerts"
  widget {
    free_text_definition {
      color      = "#000"
      text       = "Backend"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 4
      x      = 38
      height = 3
      width  = 24
    }
  }
  widget {
    free_text_definition {
      color      = "#000"
      text       = "End-user"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 3
      x      = 140
      height = 6
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 3"
        label        = " y > 3 "
      }
      show_legend = true
      title       = "4XX: End-Users - Uncategorized"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\" OR \"status: [400]\" OR \"status: [401]\") (\"uri: [/api/v2/auth/*]\" OR (\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" -(invalid_client \"Invalid client credentials\"))) -\"client returned from error\" -cannot_consume_ticket -(\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\" \"errorCode: [4001]\" \"you denied the request\") -(\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") -(\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") -(\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Invalid redirect uri\") @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 102
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "OIDC /complete with errors"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "\"Client returned with error\" \"Session rejected by server\" @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 59
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 401 Error Rate is High - Sandbox Status"
      request {
        q = "avg:aws.cloudfront.401_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 27
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 403 Error Rate is High - Sandbox Status"
      request {
        q = "avg:aws.cloudfront.403_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 27
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 404 Error Rate is High - Sandbox Status"
      request {
        q = "avg:aws.cloudfront.404_error_rate{distributionid:e1hdwr1opp59eu OR distributionid:e1hnowufe04l4u OR distributionid:e1zltsdcqsnwg OR distributionid:e27zv9r6zge1bf OR distributionid:e2vdow6e5btlst OR distributionid:e36k3k2yb7i25z OR distributionid:e3qoq285lr3xv3 OR distributionid:ea7188mg43d68 OR distributionid:ebpzvgpchdxvs OR distributionid:etea6nrsz58va}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 43
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Device not found errors - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Device not found errors\" @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 150
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "End User - Invalid Request - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Invalid Request\" @api_audience:enduser @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 27
      x      = 102
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Expression evaluation errors - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Expression evaluation errors\" @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 43
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "User not found errors - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "@error_category:\"User not found errors\" @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Backend - Invalid Request - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Invalid Request\" @api_audience:backend @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 50
      height = 15
      width  = 47
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_4" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "SRV Refine - Production Dashboard"
  url          = "/dashboard/4j5-ezh-m96/srv-refine---production-dashboard"
  widget {
    free_text_definition {
      color      = "#000"
      text       = "Backend"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 4
      x      = 38
      height = 3
      width  = 24
    }
  }
  widget {
    free_text_definition {
      color      = "#000"
      text       = "End-user"
      font_size  = "56"
      text_align = "left"
    }
    widget_layout {
      y      = 3
      x      = 140
      height = 6
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 3"
        label        = " y > 3 "
      }
      show_legend = true
      title       = "4XX: End-Users - Uncategorized"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\" OR \"status: [400]\" OR \"status: [401]\") (\"uri: [/api/v2/auth/*]\" OR (\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" -(invalid_client \"Invalid client credentials\"))) -\"client returned from error\" -cannot_consume_ticket -(\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\" \"errorCode: [4001]\" \"you denied the request\") -(\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") -(\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") -(\"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Invalid redirect uri\") @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 102
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error bold"
        value        = "y = 0.25"
        label        = " y > 250ms "
      }
      show_legend = true
      title       = "API's - Response time over 250ms for {{[@http.url_details.path].name}}"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "service:cloudfront @http.referer:(\"https://admin.bindid-sandbox.io/\" OR \"https://ts.bindid-sandbox.io/console/\" OR \"https://admin.bindid-sandbox.io/console/\") @http.url_details.path:(\"/api/v2/mng-ui/application/policies\" OR \"/api/v2/mng-ui/identity/trusted/list\" OR \"/api/v2/mng-ui/application/procedures\" OR \"/api/v2/mng-ui/localization/keys\" OR \"/api/v1/tenants\" OR \"/api/v1/tenant\" OR \"/api/v2/mng-ui/external-connections/metadata\" OR \"/api/v1/admin-data\" OR \"/api/v2/mng-ui/debugger/update_debug_context\" OR \"/api/v2/mng-ui/debugger/console_messages\" OR \"/api/v2/mng-ui/identity/credentials/list\")"
          group_by {
            facet = "@http.url_details.path"
            sort_query {
              facet       = "@duration"
              order       = "desc"
              aggregation = "pc95"
            }
            limit = 10
          }
          compute_query {
            facet       = "@duration"
            aggregation = "pc95"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "OIDC /complete with errors"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "\"Client returned with error\" \"Session rejected by server\" @bindid_env:sandbox"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 59
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Backend - Invalid Request - Categorized - Production"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Invalid Request\" @api_audience:backend @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error bold"
        value        = "y = 0.25"
        label        = " y > 250ms "
      }
      show_legend = true
      title       = "URL's - Response time over 250ms for {{[@http.url_details.path].name}}"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "(-\"/api/*\" OR \"/.well-known/openid-configuration\" OR \"/_complete/*\" OR \"/ama\" OR \"/authorize\" OR \"/authorize_ciba\" OR \"/config/*\" OR \"/console\" OR \"/console/invite\" OR \"/console/preview\" OR \"/console/resume-invite\" OR \"/demo-token-exchange\" OR \"/initial/*\" OR \"/jwks\" OR \"/login\" OR \"/logout\" OR \"/manage\" OR \"/manage/delete-device\" OR \"/manage/login\" OR \"/manager/html\" OR \"/other_login\" OR \"/playground\" OR \"/register\" OR \"/registration-result\" OR \"/report\" OR \"/send-session-feedback\" OR \"/session-feedback\" OR \"/token\" OR \"/userinfo\" OR \"/version\") service:cloudfront -@http.url_details.path:(*\\/websdk* OR *\\/main\\-* OR *\\/polyfills\\-* OR *\\/runtime\\-* OR *\\/journey* OR \"/styles.eeed0a952180434276c0.css\" OR \"/styles.7579e9ab48bb69114ea4.css\" OR \"/favicon.ico\" OR \"/img/playground-hover.svg\" OR *\\/assets\\/playground* OR *\\/console\\/assets* OR *\\/env.js* OR *\\/initial\\/transmit\\-internal\\-login*)"
          group_by {
            facet = "@http.url_details.path"
            sort_query {
              facet       = "@duration"
              order       = "desc"
              aggregation = "pc95"
            }
            limit = 10
          }
          compute_query {
            facet       = "@duration"
            aggregation = "pc95"
          }
        }
      }
    }
    widget_layout {
      y      = 59
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 401 Error Rate is High - Production Status"
      request {
        q = "avg:aws.cloudfront.401_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 27
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 403 Error Rate is High - ProductionStatus"
      request {
        q = "avg:aws.cloudfront.403_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 27
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = " Cloudfront - 404 Error Rate is High - Production Status"
      request {
        q = "avg:aws.cloudfront.404_error_rate{distributionid:e1dk6tlw75pcfy OR distributionid:e1ixgymmkwy0e5 OR distributionid:e1pjtks53nqq94 OR distributionid:e22of9g37ixhv8 OR distributionid:e2bduc6glnsgo7 OR distributionid:e2iacuwbekgr72 OR distributionid:e3e8gqjwmsm4km OR distributionid:e3jepmxmiylgw0 OR distributionid:efu9jk9yae4fr OR distributionid:eoqgkblrt88po}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 43
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Device not found errors - Categorized - Production"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Device not found errors\" @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 11
      x      = 150
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "End User - Invalid Request - Categorized - Production"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Invalid Request\" @api_audience:enduser @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 27
      x      = 102
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Expression evaluation errors - Categorized - Sandbox"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server @error_category:\"Expression evaluation errors\" @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 43
      x      = 50
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "Terraform - AWS ALB - High Avg Response time on Load Balancer (over 250ms)"
      request {
        q = "avg:aws.applicationelb.target_response_time.average{*}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 75
      x      = 2
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y = 1"
        label        = " y >= 1 "
      }
      show_legend = true
      title       = "User not found errors - Categorized - Production"
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "@error_category:\"User not found errors\" @bindid_env:production"
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 75
      x      = 50
      height = 15
      width  = 47
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_5" {

  notify_list = []
  description = ""
  template_variable {
    default = "*"
    prefix  = ""
    name    = "var"
  }
  is_read_only = false
  title        = "CloudFront Edge Hits"
  url          = "/dashboard/h54-srn-cx3/cloudfront-edge-hits"
  widget {
    geomap_definition {
      style {
        palette      = "yellow_to_green"
        palette_flip = false
      }
      title_size  = "20"
      title       = "CDN Edge hits"
      title_align = "center"
      request {
        log_query {
          index        = "*"
          search_query = ""
          group_by {
            facet = "@network.client.country"
            sort_query {
              order       = "desc"
              aggregation = "count"
            }
            limit = 10
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
      view {
        focus = "WORLD"
      }
    }
    widget_layout {
      y      = 1
      x      = 1
      height = 76
      width  = 195
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_6" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Production Uptime Service Dashboard"
  url          = "/dashboard/2j4-8ik-fuz/production-uptime-service-dashboard"
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "07e4bb86366c56e5bf406344c2a57fc4"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Admin Service"
    }
    widget_layout {
      y      = 0
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "7ac53ef38f285ea0ad88b05cfc781999"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Auth Service"
    }
    widget_layout {
      y      = 13
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "b56e5c13024b59969986c7c30c82a5bf"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on IDP Service"
    }
    widget_layout {
      y      = 19
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "2d59c7879a175e9cadec273b5367a4aa"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Appless Service"
    }
    widget_layout {
      y      = 38
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "78ce67bacc5256c68481783005019ffb"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Developer Service"
    }
    widget_layout {
      y      = 32
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "0136757ee1b755168bd506a21e115d46"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Assets Service"
    }
    widget_layout {
      y      = 51
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    image_definition {
      sizing           = "contain"
      has_background   = false
      horizontal_align = "center"
      has_border       = false
      url              = "https://s3-ap-southeast-2.amazonaws.com/cookbook.transmit-dev.com/logo.png"
      vertical_align   = "center"
      margin           = "md"
    }
    widget_layout {
      y      = 0
      x      = 16
      height = 13
      width  = 25
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "5a48373c36c257229075626368440984"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Demo Service"
    }
    widget_layout {
      y      = 70
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "431810046010534e83bc6a9168ff68f6"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Backoffice Service"
    }
    widget_layout {
      y      = 57
      x      = 62
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "3a7c088e1949538d91189af89fb20208"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on Aux Service"
    }
    widget_layout {
      y      = 89
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    service_level_objective_definition {
      time_windows      = ["7d", "week_to_date", ]
      title_size        = "16"
      show_error_budget = true
      view_type         = "detail"
      title_align       = "left"
      slo_id            = "0b8f6bfa8ad45f88841973c0797c4925"
      view_mode         = "both"
      title             = "SLO of 99.99% over the last 7 days on MY Service"
    }
    widget_layout {
      y      = 76
      x      = 62
      height = 21
      width  = 62
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_7" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Top Active Business Units"
  url          = "/dashboard/seg-x7t-shw/top-active-business-units"
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = true
      live_span   = "1w"
      title       = ""
      request {
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        log_query {
          index        = "*"
          search_query = "service:bindid-authentication-server source:bindid-authentication-server-activity-log"
          group_by {
            facet = "@data.bu"
            sort_query {
              facet       = "@data.__app_enrichment.client_id"
              order       = "desc"
              aggregation = "cardinality"
            }
            limit = 10
          }
          compute_query {
            facet       = "@data.__app_enrichment.client_id"
            aggregation = "cardinality"
          }
        }
      }
    }
    widget_layout {
      y      = 25
      x      = 13
      height = 27
      width  = 108
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = ""
      title_align = "left"
      live_span   = "1mo"
      request {
        log_query {
          index        = "*"
          search_query = "service:bindid-authentication-server source:bindid-authentication-server-activity-log @action2:auth_complete @action:custom"
          group_by {
            facet = "@data.bu"
            sort_query {
              order       = "desc"
              aggregation = "count"
            }
            limit = 10
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      y      = 1
      x      = 13
      height = 24
      width  = 108
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_8" {

  notify_list  = null
  description  = null
  is_read_only = false
  title        = "Nader's Screenboard 26 Jan 2021 23:18"
  url          = "/dashboard/3yk-xpu-hcr/naders-screenboard-26-jan-2021-2318"
  widget {
    timeseries_definition {
      request {
        q            = "avg:synthetics.http.response.time{check_id:vmv-g9s-fr6}.fill(null)"
        display_type = "line"
      }
      request {
        q            = "avg:synthetics.http.response.time{check_id:r4j-kt6-stn}.fill(null)"
        display_type = "line"
      }
      request {
        q            = "avg:synthetics.http.response.time{check_id:sbi-zy2-nmy}.fill(null)"
        display_type = "line"
      }
      request {
        q            = "avg:synthetics.http.response.time{check_id:z67-96e-2dm}.fill(null)"
        display_type = "line"
      }
      request {
        q            = "avg:synthetics.http.response.time{check_id:8tj-gkf-mne}.fill(null)"
        display_type = "line"
      }
      request {
        q            = "avg:synthetics.http.response.time{check_id:39a-ywh-7xg}.fill(null)"
        display_type = "line"
      }
      title_align = "left"
      title_size  = "16"
      title       = "Response Time"
    }
    widget_layout {
      y = 0
      x = 0
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_9" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Shady's Screenboard Mon, May 24, 8:50:53 pm"
  url          = "/dashboard/xzu-ure-ria/shadys-screenboard-mon-may-24-85053-pm"
  widget {
    manage_status_definition {
      sort                = "status,asc"
      count               = 50
      title_size          = "13"
      title               = "SRV - Uptime Production"
      title_align         = "left"
      hide_zero_counts    = true
      start               = 0
      summary_type        = "monitors"
      color_preference    = "background"
      query               = "Categorized - Production"
      show_last_triggered = false
      display_format      = "countsAndList"
    }
    widget_layout {
      y      = 1
      x      = 2
      height = 80
      width  = 76
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_10" {

  notify_list = []
  description = <<EOF
This dashboard provides a high-level overview of your AWS Application Load Balancers, so you can track the throughput and performance of your load balancers and backend hosts. Further reading on AWS Application ELB monitoring:

- [Monitor Amazon's Application Load Balancer with Datadog](https://www.datadoghq.com/blog/monitor-application-load-balancer/)

- [Datadog's AWS ELB integration docs](https://docs.datadoghq.com/integrations/amazon_elb/)

Clone this template dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }
  template_variable {
    default = "*"
    prefix  = "name"
    name    = "name"
  }
  template_variable {
    default = "*"
    prefix  = "targetgroup"
    name    = "targetgroup"
  }
  is_read_only = true
  title        = "BindID - Status and Errors"
  url          = "/dashboard/686-a52-dwg/bindid---status-and-errors"
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Requests per second (avg)"
      title_align = "left"
      text_align  = "left"
      precision   = 1
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.request_count{$scope,$host,$name,$targetgroup}.as_rate()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 65
      height = 12
      width  = 23
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Response time  (avg)"
      title_align = "left"
      custom_unit = "ms"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 400
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 400
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 89
      height = 12
      width  = 23
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 3xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_3xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 30
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Unhealthy hosts count (max)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.un_healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "max"
        conditional_formats {
          palette    = "white_on_red"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 41
      height = 12
      width  = 23
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Healthy hosts count (min)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "min"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "red_on_white"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 17
      height = 12
      width  = 23
    }
  }
  widget {
    image_definition {
      url    = "https://s3-ap-southeast-2.amazonaws.com/cookbook.transmit-dev.com/logo.png"
      sizing = "fit"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 12
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 2xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_2xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 14
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 4xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_4xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 14
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 5xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_5xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 30
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Response Time"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "4"
      request {
        q            = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        display_type = "area"
      }
    }
    widget_layout {
      y      = 63
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Active Connections"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.active_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 47
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "New Connections"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.new_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 47
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Processed Bytes"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.processed_bytes{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 63
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = "HTTP Responses"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 14
      x      = 0
      height = 31
      width  = 16
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = "Connections and Latencies"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 47
      x      = 0
      height = 31
      width  = 16
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Response time  (avg)"
      title_align = "left"
      custom_unit = "ms"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "max:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup}*1000"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 400
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 400
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 79
      x      = 17
      height = 12
      width  = 23
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_11" {

  notify_list  = []
  description  = null
  is_read_only = false
  title        = "Infrastructure Overview"
  url          = "/dashboard/nh8-bzn-8ck/infrastructure-overview"
  widget {
    free_text_definition {
      color      = "#4d4d4d"
      text       = "Mongo DB "
      font_size  = "auto"
      text_align = "left"
    }
    widget_layout {
      y      = 1
      x      = 78
      height = 6
      width  = 24
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Avg CPU Usage"
      title_align = "center"
      custom_unit = "%"
      precision   = 2
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.cpu.norm.guest{*}+avg:mongodb.atlas.system.cpu.norm.iowait{*}+avg:mongodb.atlas.system.cpu.norm.irq{*}+avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*}+avg:mongodb.atlas.system.cpu.norm.nice{*}+avg:mongodb.atlas.system.cpu.norm.softirq{*}+avg:mongodb.atlas.system.cpu.norm.steal{*}+avg:mongodb.atlas.system.cpu.norm.user{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_green"
          value      = 7
          comparator = "<"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 8
          comparator = "<"
        }
        conditional_formats {
          palette    = "white_on_red"
          value      = 8
          comparator = ">="
        }
      }
    }
    widget_layout {
      y      = 12
      x      = 16
      height = 17
      width  = 24
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "AVG Free Disk Space"
      title_align = "left"
      precision   = 2
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.disk.space.free{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 98500000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 97000000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 97000000000
          comparator = "<"
        }
      }
    }
    widget_layout {
      y      = 12
      x      = 40
      height = 17
      width  = 24
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Avg Total Disk IOPS"
      title_align = "center"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.disk.iops.total{*}.as_count()"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 30000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 28000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 25000
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 46
      x      = 64
      height = 18
      width  = 44
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document Reads /s"
      title_align = "center"
      marker {
        display_type = "error bold"
        value        = "y = 100"
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 98"
      }
      marker {
        display_type = "ok dashed"
        value        = "y = 95"
      }
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "avg:mongodb.atlas.metrics.document.returned{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 29
      x      = 64
      height = 17
      width  = 21
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document Writes /s"
      title_align = "center"
      marker {
        display_type = "error bold"
        value        = "y = 4"
      }
      marker {
        display_type = "warning dashed"
        value        = "y = 3.8"
      }
      marker {
        display_type = "ok dashed"
        value        = "y = 3.6"
      }
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.metrics.document.deleted{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      request {
        q              = "sum:mongodb.atlas.metrics.document.inserted{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      request {
        q              = "sum:mongodb.atlas.metrics.document.updated{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 29
      x      = 85
      height = 17
      width  = 23
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Query Efficiency"
      title_align = "center"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{*}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 29
      x      = 40
      height = 17
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Memory Usage"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "max:mongodb.atlas.mem.resident{*}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "dashed"
        }
        display_type = "line"
        metadata {
          alias_name = "Resident"
          expression = "max:mongodb.atlas.mem.resident{*}"
        }
      }
      request {
        q              = "max:mongodb.atlas.mem.virtual{*}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "orange"
          line_type  = "solid"
        }
        display_type = "line"
        metadata {
          alias_name = "Virtual"
          expression = "max:mongodb.atlas.mem.virtual{*}"
        }
      }
    }
    widget_layout {
      y      = 12
      x      = 64
      height = 17
      width  = 44
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Current Connections"
      title_align = "center"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.connections.current{*}"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 29
      x      = 16
      height = 17
      width  = 24
    }
  }
  widget {
    free_text_definition {
      color      = "#4d4d4d"
      text       = "Kubernetes"
      font_size  = "auto"
      text_align = "left"
    }
    widget_layout {
      y      = 65
      x      = 79
      height = 6
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Read requests (per second)"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.opcounters.getmore{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
      request {
        q              = "sum:mongodb.atlas.opcounters.query{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 46
      x      = 40
      height = 18
      width  = 24
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Write requests (per second)"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.opcounters.delete{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "area"
      }
      request {
        q              = "avg:mongodb.atlas.opcounters.insert{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
      request {
        q              = "sum:mongodb.atlas.opcounters.update{*}.as_rate()"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 46
      x      = 16
      height = 18
      width  = 24
    }
  }
  widget {
    trace_service_definition {
      span_name          = "mongo.query"
      title_size         = "16"
      service            = "mongo"
      title              = "MongoDB - Service Summary"
      size_format        = "medium"
      show_hits          = true
      show_latency       = true
      title_align        = "left"
      show_errors        = true
      show_breakdown     = true
      env                = "production"
      show_distribution  = true
      display_format     = "two_column"
      show_resource_list = false
    }
    widget_layout {
      y      = 12
      x      = 108
      height = 52
      width  = 64
    }
  }
  widget {
    toplist_definition {
      request {
        q = "top(avg:kubernetes.cpu.usage.total{*} by {kube_container_name}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_green"
          value      = 630000000
          comparator = "<="
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 650000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_red"
          value      = 680000000
          comparator = ">"
        }
      }
      title_align = "left"
      title_size  = "16"
      title       = "Container CPU Usage"
    }
    widget_layout {
      y      = 72
      x      = 16
      height = 18
      width  = 28
    }
  }
  widget {
    toplist_definition {
      request {
        q = "top(avg:kubernetes.cpu.usage.total{*} by {pod_name}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_green"
          value      = 1790000000
          comparator = "<="
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 1880000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_red"
          value      = 2000000000
          comparator = ">"
        }
      }
      title_align = "left"
      title_size  = "16"
      title       = "Pods CPU Usage"
    }
    widget_layout {
      y      = 94
      x      = 39
      height = 18
      width  = 29
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Nodes CPU Total Usage"
      title_align = "center"
      precision   = 2
      title_size  = "16"
      request {
        q          = "avg:kubernetes.cpu.usage.total{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 30000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 25000000
          comparator = ">="
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 20000000
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 72
      x      = 70
      height = 18
      width  = 47
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Running Containers"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:docker.containers.running{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 72
      x      = 44
      height = 18
      width  = 26
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Stopped Containers"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:docker.containers.stopped{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "yellow_on_white"
          value      = 0
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 72
      x      = 117
      height = 18
      width  = 26
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network in per node"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:kubernetes.network.rx_bytes{*} by {host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 105
      x      = 71
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network out per node"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:kubernetes.network.tx_bytes{*} by {host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 90
      x      = 118
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network errors per node"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:kubernetes.network.rx_errors{*} by {host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q              = "sum:kubernetes.network.tx_errors{*} by {host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q              = "sum:kubernetes.network_errors{*} by {host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 90
      x      = 71
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Disk reads per node"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "sum:kubernetes.io.read_bytes{*} by {replicaset,host}, avg:kubernetes_state.replicaset.replicas_ready{*} by {replicaset,host}, sum:kubernetes.io.read_bytes{*} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{*} by {replicaset,host}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 105
      x      = 118
      height = 15
      width  = 47
    }
  }
  widget {
    event_timeline_definition {
      title_size     = "20"
      title          = "Number of Kubernetes events (Last Week)"
      title_align    = "center"
      tags_execution = "and"
      live_span      = "1w"
      query          = "sources:kubernetes *"
    }
    widget_layout {
      y      = 90
      x      = 24
      height = 9
      width  = 47
    }
  }
  widget {
    event_stream_definition {
      title_size     = "16"
      title_align    = "left"
      tags_execution = "and"
      live_span      = "1w"
      query          = "sources:kubernetes *"
      event_size     = "s"
    }
    widget_layout {
      y      = 101
      x      = 24
      height = 21
      width  = 47
    }
  }
  widget {
    toplist_definition {
      request {
        q = "top(avg:kubernetes.cpu.usage.total{*} by {pod_name}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_green"
          value      = 1790000000
          comparator = "<="
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 1880000000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_red"
          value      = 2000000000
          comparator = ">"
        }
      }
      title_align = "left"
      title_size  = "16"
      title       = "Pods CPU Usage"
    }
    widget_layout {
      y      = 72
      x      = 143
      height = 18
      width  = 29
    }
  }
  widget {
    free_text_definition {
      color      = "#4d4d4d"
      text       = "AWS"
      font_size  = "auto"
      text_align = "left"
    }
    widget_layout {
      y      = 121
      x      = 86
      height = 6
      width  = 24
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "left"
      text_align       = "center"
      content          = <<EOF


EC2
EOF
      font_size        = "36"
      background_color = "white"
    }
    widget_layout {
      y      = 129
      x      = 0
      height = 8
      width  = 50
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "left"
      text_align       = "center"
      content          = <<EOF


EBS
EOF
      font_size        = "36"
      background_color = "white"
    }
    widget_layout {
      y      = 129
      x      = 51
      height = 8
      width  = 51
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "left"
      text_align       = "center"
      content          = <<EOF


S3

EOF
      font_size        = "36"
      background_color = "white"
    }
    widget_layout {
      y      = 129
      x      = 103
      height = 8
      width  = 40
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "CPU Utilization"
      title_align = "left"
      precision   = 2
      title_size  = "16"
      request {
        q          = "avg:aws.ec2.cpuutilization{*}"
        aggregator = "avg"
        conditional_formats {
          palette    = "red_on_white"
          value      = 50
          comparator = ">"
        }
        conditional_formats {
          palette    = "green_on_white"
          value      = 50
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 137
      x      = 0
      height = 12
      width  = 25
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Active Instances"
      title_align = "left"
      precision   = 2
      title_size  = "16"
      request {
        q          = "sum:aws.ec2.host_ok{*}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 137
      x      = 25
      height = 12
      width  = 25
    }
  }
  widget {
    heatmap_definition {
      title_size  = "16"
      title       = "EC2 CPU utilization per instance (%)"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ec2.cpuutilization{*} by {host}"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 149
      x      = 0
      height = 15
      width  = 50
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Avg Q lengh"
      title_align = "left"
      precision   = 4
      title_size  = "16"
      request {
        q          = "avg:aws.ebs.volume_queue_length{*}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 137
      x      = 51
      height = 12
      width  = 17
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "EBS volumes (sum/avg)"
      title_align = "left"
      precision   = 0
      live_span   = "1w"
      autoscale   = true
      request {
        q          = "sum:aws.ebs.volume_read_ops{*}/avg:aws.ebs.volume_read_ops{*}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 137
      x      = 68
      height = 12
      width  = 17
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "EBS volumes (Read & Writes)"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:aws.ebs.volume_read_ops{*}+sum:aws.ebs.volume_write_ops{*}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 137
      x      = 85
      height = 12
      width  = 17
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      title       = "S3 buckets size, past week"
      request {
        q = "max:aws.s3.bucket_size_bytes{*} by {bucketname}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 137
      x      = 103
      height = 14
      width  = 40
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      title       = "S3 buckets number of objects, past week"
      request {
        q = "max:aws.s3.number_of_objects{*} by {bucketname}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 151
      x      = 103
      height = 14
      width  = 40
    }
  }
  widget {
    heatmap_definition {
      title_size  = "16"
      title       = "EBS IOps by volume"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ebs.volume_read_ops{*} by {host,device}.as_count(), avg:aws.ebs.volume_write_ops{*} by {host,device}.as_count(), avg:aws.ebs.volume_read_ops{*} by {host,device}.as_count()+avg:aws.ebs.volume_write_ops{*} by {host,device}.as_count()"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 149
      x      = 51
      height = 15
      width  = 51
    }
  }
  widget {
    heatmap_definition {
      title_size  = "16"
      title       = "EBS queue length by volume"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ebs.volume_queue_length{*} by {host,device}"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 164
      x      = 51
      height = 15
      width  = 51
    }
  }
  widget {
    image_definition {
      url    = "/static/images/screenboard/integrations/aws.png"
      sizing = "fit"
      margin = "large"
    }
    widget_layout {
      y      = 129
      x      = 144
      height = 15
      width  = 32
    }
  }
  widget {
    event_stream_definition {
      title_size     = "13"
      title          = "AWS events (Last Week)"
      title_align    = "left"
      tags_execution = "and"
      live_span      = "1w"
      query          = "sources:aws"
      event_size     = "s"
    }
    widget_layout {
      y      = 144
      x      = 144
      height = 46
      width  = 32
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "left"
      text_align       = "center"
      content          = <<EOF


Cloudfront
EOF
      font_size        = "36"
      background_color = "white"
    }
    widget_layout {
      y      = 165
      x      = 0
      height = 8
      width  = 50
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Error Rates"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q              = "avg:aws.cloudfront.total_error_rate{*}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
        metadata {
          alias_name = "Total"
          expression = "avg:aws.cloudfront.total_error_rate{*}"
        }
      }
      request {
        q              = "avg:aws.cloudfront.4xx_error_rate{*}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "orange"
          line_type  = "solid"
        }
        display_type = "line"
        metadata {
          alias_name = "4xx"
          expression = "avg:aws.cloudfront.4xx_error_rate{*}"
        }
      }
      request {
        q              = "avg:aws.cloudfront.5xx_error_rate{*}"
        on_right_yaxis = false
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
        metadata {
          alias_name = "5xx"
          expression = "avg:aws.cloudfront.5xx_error_rate{*}"
        }
      }
    }
    widget_layout {
      y      = 185
      x      = 0
      height = 15
      width  = 50
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Requests Count"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:aws.cloudfront.requests{*}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 173
      x      = 33
      height = 12
      width  = 17
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Uploaded Bytes"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:aws.cloudfront.bytes_uploaded{*}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 173
      x      = 16
      height = 12
      width  = 17
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Downloaded Bytes"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "sum:aws.cloudfront.bytes_downloaded{*}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 173
      x      = 0
      height = 12
      width  = 16
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_12" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Chris's Screenboard Wed, Mar 17, 2:37:29 pm"
  url          = "/dashboard/wha-93n-4ws/chriss-screenboard-wed-mar-17-23729-pm"
  widget {
    event_stream_definition {
      title_size     = "16"
      title          = ""
      title_align    = "left"
      tags_execution = "and"
      live_span      = "1w"
      query          = "[Monitor Modified]"
      event_size     = "s"
    }
    widget_layout {
      y      = -1
      x      = -3
      height = 63
      width  = 96
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_13" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "Dima's Timeboard Wed, Mar 10, 6:04:22 pm"
  url          = "/dashboard/5x5-94s-srg/dimas-timeboard-wed-mar-10-60422-pm"
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      title       = ""
      request {
        q = "avg:system.cpu.user{*}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      title       = ""
      request {
        q = "avg:system.cpu.idle{*}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
  }
  layout_type = "ordered"
}


resource "datadog_dashboard" "dashboard_14" {

  notify_list  = []
  description  = ""
  is_read_only = false
  title        = "ALB Performance"
  url          = "/dashboard/jgu-vup-4wt/alb-performance"
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Connections & Latencies "
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 6
      width  = 78
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Active Connections"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.active_connection_count{*} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 6
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = <<EOF
HTTP Responses

EOF
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 80
      height = 6
      width  = 77
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Active Connections"
      title_align = "left"
      precision   = 0
      request {
        q          = "sum:aws.applicationelb.active_connection_count{*} by {host}"
        aggregator = "sum"
      }
    }
    widget_layout {
      y      = 6
      x      = 62
      height = 21
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Response Time RoundTrip"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "4"
      request {
        q = "avg:aws.applicationelb.target_response_time.average{*}*1000"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 27
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "RT Last Hour"
      title_align = "left"
      custom_unit = "ms"
      precision   = 2
      live_span   = "1h"
      request {
        q          = "avg:aws.applicationelb.target_response_time.average{*}*1000"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 27
      x      = 62
      height = 21
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 3xx Responses"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q              = "sum:aws.applicationelb.httpcode_target_3xx{*} by {host}.as_count()"
        on_right_yaxis = false
        style {
          palette = "purple"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 27
      x      = 80
      height = 21
      width  = 63
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 2xx Responses"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_2xx{*} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 6
      x      = 80
      height = 21
      width  = 63
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 4xx Responses"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_4xx{*} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 48
      x      = 80
      height = 21
      width  = 63
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 5xx Responses"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q              = "sum:aws.applicationelb.httpcode_target_5xx{*} by {host}.as_count()"
        on_right_yaxis = false
        style {
          palette = "orange"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 69
      x      = 80
      height = 21
      width  = 63
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "2xx Last Hour"
      title_align = "left"
      precision   = 2
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "sum:aws.applicationelb.httpcode_target_2xx{*} by {host}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 6
      x      = 143
      height = 21
      width  = 14
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "3xx Last Hour"
      title_align = "left"
      precision   = 2
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "sum:aws.applicationelb.httpcode_target_3xx{*} by {host}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 27
      x      = 143
      height = 21
      width  = 14
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "4xx Last Hour"
      title_align = "left"
      precision   = 2
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "sum:aws.applicationelb.httpcode_target_4xx{*} by {host}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 48
      x      = 143
      height = 21
      width  = 14
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "5xx Last Hour"
      title_align = "left"
      precision   = 2
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "sum:aws.applicationelb.httpcode_target_5xx{*} by {host}.as_count()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 69
      x      = 143
      height = 21
      width  = 14
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Healthy hosts count (min)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.healthy_host_count{*,*,*,*}"
        aggregator = "min"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "red_on_white"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 23
      x      = 158
      height = 20
      width  = 33
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Unhealthy hosts count (max)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.un_healthy_host_count{*,*,*,*}"
        aggregator = "max"
        conditional_formats {
          palette    = "white_on_red"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 53
      x      = 158
      height = 20
      width  = 33
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "RT Last Hour"
      title_align = "left"
      precision   = 2
      live_span   = "1h"
      request {
        q          = "avg:aws.applicationelb.target_response_time.average{*}*1000"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 48
      x      = 62
      height = 21
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Response Time (Avg)"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q = "avg:aws.applicationelb.target_response_time.average{*}*1000"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 48
      x      = 0
      height = 21
      width  = 62
    }
  }
  widget {
    image_definition {
      url    = "https://s3-ap-southeast-2.amazonaws.com/cookbook.transmit-dev.com/logo.png"
      sizing = "center"
    }
    widget_layout {
      y      = 1
      x      = 158
      height = 19
      width  = 33
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_15" {

  notify_list = []
  description = <<EOF
This dashboard provides a high-level overview of your AWS Application Load Balancers, so you can track the throughput and performance of your load balancers and backend hosts. Further reading on AWS Application ELB monitoring:

- [Monitor Amazon's Application Load Balancer with Datadog](https://www.datadoghq.com/blog/monitor-application-load-balancer/)

- [Datadog's AWS ELB integration docs](https://docs.datadoghq.com/integrations/amazon_elb/)

Clone this template dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "host"
    name    = "host"
  }
  template_variable {
    default = "*"
    prefix  = "name"
    name    = "name"
  }
  template_variable {
    default = "*"
    prefix  = "targetgroup"
    name    = "targetgroup"
  }
  is_read_only = true
  title        = "ALB Cloned"
  url          = "/dashboard/phj-u4q-p8e/alb-cloned"
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Requests per second (avg)"
      title_align = "left"
      text_align  = "left"
      precision   = 1
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.request_count{$scope,$host,$name,$targetgroup}.as_rate()"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 65
      height = 12
      width  = 23
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Response time  (avg)"
      title_align = "left"
      custom_unit = "ms"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = false
      request {
        q          = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 400
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 400
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 89
      height = 12
      width  = 23
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 3xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_3xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 30
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Unhealthy hosts count (max)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.un_healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "max"
        conditional_formats {
          palette    = "white_on_red"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 41
      height = 12
      width  = 23
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Healthy hosts count (min)"
      title_align = "left"
      text_align  = "left"
      precision   = 0
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.applicationelb.healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "min"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "red_on_white"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 17
      height = 12
      width  = 23
    }
  }
  widget {
    image_definition {
      url    = "/static/images/logos/amazon-alb_avatar.svg"
      sizing = "fit"
      margin = "large"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 12
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 2xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_2xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 14
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 4xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_4xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 14
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "HTTP 5xx Responses"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.httpcode_target_5xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 30
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Response Time"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "4"
      request {
        q            = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        display_type = "area"
      }
    }
    widget_layout {
      y      = 63
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Active Connections"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.active_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 47
      x      = 17
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "New Connections"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.new_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 47
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Processed Bytes"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:aws.applicationelb.processed_bytes{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 63
      x      = 65
      height = 15
      width  = 47
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = "HTTP Responses"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 14
      x      = 0
      height = 31
      width  = 16
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = "Connections and Latencies"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 47
      x      = 0
      height = 31
      width  = 16
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_16" {

  notify_list = null
  description = <<EOF
Our Kubernetes dashboard gives you broad visibility into the scale, status, and resource usage of your cluster and its containers. Further reading for Kubernetes monitoring:

- [Autoscale Kubernetes workloads with any Datadog metric](https://www.datadoghq.com/blog/autoscale-kubernetes-datadog/)

- [How to monitor Kubernetes + Docker with Datadog](https://www.datadoghq.com/blog/monitor-kubernetes-docker/)

- [Monitoring in the Kubernetes era](https://www.datadoghq.com/blog/monitoring-kubernetes-era/)

- [Monitoring Kubernetes performance metrics](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/)

- [Collecting metrics with built-in Kubernetes monitoring tools](https://www.datadoghq.com/blog/how-to-collect-and-graph-kubernetes-metrics/)

- [Monitoring Kubernetes with Datadog](https://www.datadoghq.com/blog/monitoring-kubernetes-with-datadog/)

- [Datadog's Kubernetes integration docs](https://docs.datadoghq.com/integrations/kubernetes/)

Clone this template dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "cluster_name"
    name    = "cluster"
  }
  template_variable {
    default = "*"
    prefix  = "kube_namespace"
    name    = "namespace"
  }
  template_variable {
    default = "*"
    prefix  = "kube_deployment"
    name    = "deployment"
  }
  template_variable {
    default = "*"
    prefix  = "kube_daemon_set"
    name    = "daemonset"
  }
  template_variable {
    default = "*"
    prefix  = "kube_service"
    name    = "service"
  }
  template_variable {
    default = "*"
    prefix  = "node"
    name    = "node"
  }
  template_variable {
    default = "*"
    prefix  = "label"
    name    = "label"
  }
  is_read_only = true
  title        = "Kubernetes - Overview (cloned)"
  url          = "/dashboard/3fm-usz-w9a/kubernetes---overview-cloned"
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Most memory-intensive pods"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(sum:kubernetes.memory.usage{$scope,$deployment,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')"
        style {
          palette = "cool"
        }
      }
    }
    widget_layout {
      y      = 57
      x      = 151
      height = 24
      width  = 43
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Most CPU-intensive pods"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(sum:kubernetes.cpu.usage.total{$scope,$deployment,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')"
        style {
          palette = "warm"
        }
      }
    }
    widget_layout {
      y      = 57
      x      = 107
      height = 24
      width  = 43
    }
  }
  widget {
    image_definition {
      url    = "/static/images/screenboard/integrations/kubernetes.jpg"
      sizing = "zoom"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 15
      width  = 23
    }
  }
  widget {
    check_status_definition {
      title_size  = "16"
      title       = "Kubelets up"
      title_align = "center"
      group_by    = []
      live_span   = "10m"
      check       = "kubernetes.kubelet.check"
      tags        = ["$scope", "$node", "$label", ]
      grouping    = "cluster"
    }
    widget_layout {
      y      = 0
      x      = 80
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Pods Available"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "avg"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 91
      x      = 50
      height = 14
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Pods available"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$daemonset,$service,$label,$cluster,$namespace,$node} by {deployment}"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 91
      x      = 67
      height = 14
      width  = 37
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Pods desired"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "avg"
        conditional_formats {
          value           = 0
          palette         = "custom_text"
          comparator      = ">"
          custom_fg_color = "#6a53a1"
        }
      }
    }
    widget_layout {
      y      = 76
      x      = 50
      height = 14
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Pods desired"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node} by {deployment}"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 76
      x      = 67
      height = 14
      width  = 37
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Pods unavailable"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "avg"
        conditional_formats {
          palette    = "yellow_on_white"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 106
      x      = 50
      height = 14
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Pods unavailable"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$daemonset,$service,$label,$cluster,$namespace,$node} by {deployment}"
        style {
          line_width = "normal"
          palette    = "orange"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 106
      x      = 67
      height = 14
      width  = 37
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Pods"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 16
      x      = 37
      height = 5
      width  = 67
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "[Resource utilization](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-resource-utilization6)"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 16
      x      = 107
      height = 5
      width  = 87
    }
  }
  widget {
    event_stream_definition {
      query          = "sources:kubernetes $node"
      event_size     = "s"
      tags_execution = "and"
      live_span      = "1w"
    }
    widget_layout {
      y      = 34
      x      = 0
      height = 37
      width  = 36
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Running pods per node"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      request {
        q = "sum:kubernetes.pods.running{$scope,$deployment,$daemonset,$label,$cluster,$namespace,$service,$node} by {host}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 38
      x      = 37
      height = 15
      width  = 33
    }
  }
  widget {
    hostmap_definition {
      style {
        palette      = "hostmap_blues"
        palette_flip = false
      }
      title_size      = "16"
      title           = "Memory usage per node"
      title_align     = "left"
      no_metric_hosts = false
      scope           = ["$scope", "$node", "$label", "$kube_deployment", "$kube_namespace", ]
      request {
        fill {
          q = "sum:kubernetes.memory.usage{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        }
      }
      no_group_hosts = true
    }
    widget_layout {
      y      = 22
      x      = 151
      height = 18
      width  = 43
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network errors per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.network.rx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
      request {
        q = "sum:kubernetes.network.tx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
      request {
        q = "sum:kubernetes.network_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 121
      x      = 107
      height = 16
      width  = 43
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Sum Kubernetes CPU requests per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.cpu.requests{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "warm"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 41
      x      = 107
      height = 15
      width  = 43
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Sum Kubernetes memory requests per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.memory.requests{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "cool"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 41
      x      = 151
      height = 15
      width  = 43
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Disk I/O & Network"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 82
      x      = 107
      height = 5
      width  = 87
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network in per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.network.rx_bytes{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "purple"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 88
      x      = 107
      height = 16
      width  = 43
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Network out per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.network.tx_bytes{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        style {
          palette = "green"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 105
      x      = 107
      height = 15
      width  = 43
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "[Events](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-correlate-with-events10)"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 16
      x      = 0
      height = 5
      width  = 36
    }
  }
  widget {
    event_timeline_definition {
      title_size     = "16"
      title          = "Number of Kubernetes events per node"
      title_align    = "left"
      tags_execution = "and"
      live_span      = "1d"
      query          = "sources:kubernetes $node"
    }
    widget_layout {
      y      = 22
      x      = 0
      height = 9
      width  = 36
    }
  }
  widget {
    hostmap_definition {
      style {
        palette      = "YlOrRd"
        palette_flip = false
      }
      title_size      = "16"
      title           = "CPU utilization per node"
      title_align     = "left"
      no_metric_hosts = false
      scope           = ["$scope", "$node", "$label", "$kube_deployment", "$kube_namespace", ]
      request {
        fill {
          q = "sum:kubernetes.cpu.usage.total{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        }
      }
      no_group_hosts = true
    }
    widget_layout {
      y      = 22
      x      = 107
      height = 18
      width  = 43
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "left"
      text_align       = "center"
      content          = <<EOF
Read our
[Monitoring guide for Kubernetes](https://www.datadoghq.com/blog/monitoring-kubernetes-era/).
 
Check [the agent documentation](https://docs.datadoghq.com/agent/kubernetes/) if some of the graphs are empty.
EOF
      font_size        = "14"
      background_color = "yellow"
    }
    widget_layout {
      y      = 0
      x      = 95
      height = 15
      width  = 16
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Desired"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.daemonset.desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
        conditional_formats {
          value           = 0
          palette         = "custom_text"
          comparator      = ">"
          custom_fg_color = "#6a53a1"
        }
      }
    }
    widget_layout {
      y      = 76
      x      = 0
      height = 14
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Pods desired"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.daemonset.desired{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node} by {daemonset}"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 76
      x      = 17
      height = 14
      width  = 32
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Ready"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.daemonset.ready{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
        conditional_formats {
          palette    = "green_on_white"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "red_on_white"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 91
      x      = 0
      height = 14
      width  = 16
    }
  }
  widget {
    check_status_definition {
      title_size  = "16"
      title       = "Kubelet Ping"
      title_align = "center"
      group_by    = []
      live_span   = "10m"
      check       = "kubernetes.kubelet.check.ping"
      tags        = ["*", "$node", "$label", "$scope", ]
      grouping    = "cluster"
    }
    widget_layout {
      y      = 8
      x      = 80
      height = 7
      width  = 13
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      title       = "Container states"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.container.running{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.waiting{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.terminated{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.ready{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 127
      x      = 50
      height = 14
      width  = 54
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Ready"
      title_align = "left"
      show_legend = false
      live_span   = "1h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 112
      x      = 17
      height = 14
      width  = 32
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Not ready"
      title_align = "left"
      show_legend = false
      live_span   = "1h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.replicaset.replicas_desired{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}"
        style {
          line_width = "normal"
          palette    = "orange"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 127
      x      = 17
      height = 14
      width  = 32
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Disk reads per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.io.read_bytes{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {host}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 105
      x      = 151
      height = 15
      width  = 43
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Disk writes per node"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes.io.write_bytes{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {host}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 88
      x      = 151
      height = 16
      width  = 43
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "DaemonSets"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 70
      x      = 0
      height = 5
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Deployments"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 70
      x      = 50
      height = 5
      width  = 54
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "ReplicaSets"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 106
      x      = 0
      height = 5
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Containers"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 121
      x      = 50
      height = 5
      width  = 54
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Ready"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.replicaset.replicas_ready{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
        conditional_formats {
          value           = 0
          palette         = "custom_text"
          comparator      = ">"
          custom_fg_color = "#6a53a1"
        }
      }
    }
    widget_layout {
      y      = 112
      x      = 0
      height = 14
      width  = 16
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Not ready"
      title_align = "left"
      precision   = 0
      live_span   = "5m"
      autoscale   = true
      request {
        q          = "sum:kubernetes_state.replicaset.replicas_desired{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node}"
        aggregator = "last"
        conditional_formats {
          value           = 0
          palette         = "yellow_on_white"
          comparator      = ">"
          custom_fg_color = "#6a53a1"
        }
      }
    }
    widget_layout {
      y      = 127
      x      = 0
      height = 14
      width  = 16
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Pods ready"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.daemonset.ready{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node} by {daemonset}"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 91
      x      = 17
      height = 14
      width  = 32
    }
  }
  widget {
    timeseries_definition {
      custom_link {
        link  = "https://www.google.com?search={{kube_namespace.value}}"
        label = "Search Namespace on Google"
      }
      title_size  = "16"
      title       = "Running pods per namespace"
      title_align = "left"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:kubernetes.pods.running{$scope,$cluster,$namespace,$deployment,$daemonset,$label,$node,$service} by {cluster_name,kube_namespace}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 22
      x      = 37
      height = 15
      width  = 33
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Pods in bad phase by namespaces"
      title_align = "left"
      request {
        q = "top(sum:kubernetes_state.pod.status_phase{$scope,$cluster,$namespace,$deployment,$daemonset,!phase:running,!phase:succeeded,$label,$node,$service} by {cluster_name,kube_namespace,phase}, 100, 'last', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 0
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 0
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 54
      x      = 37
      height = 15
      width  = 33
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      marker {
        display_type = "ok dashed"
        value        = "y = 0"
        label        = "y = 0"
      }
      show_legend = false
      title       = "CrashloopBackOff by Pod"
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.container.waiting{$cluster,$namespace,$deployment,reason:crashloopbackoff,$scope,$daemonset,$label,$node,$service} by {pod_name}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 54
      x      = 71
      height = 15
      width  = 33
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Pods running by namespace"
      title_align = "left"
      request {
        q = "top(sum:kubernetes.pods.running{$scope,$namespace,$deployment,$cluster,$daemonset,$label,$node,$service} by {cluster_name,kube_namespace}, 100, 'max', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 2000
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 1500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 3000
          comparator = "<="
        }
      }
    }
    widget_layout {
      y      = 22
      x      = 71
      height = 15
      width  = 33
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Pods in ready state by node"
      title_align = "left"
      request {
        q = "top(sum:kubernetes_state.pod.ready{$scope,$cluster,$namespace,$deployment,condition:true,$daemonset,$label,$node,$service} by {kubernetes_cluster,host,nodepool}, 10, 'last', 'desc')"
        conditional_formats {
          palette    = "white_on_green"
          value      = 24
          comparator = "<="
        }
        conditional_formats {
          palette    = "white_on_red"
          value      = 32
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 24
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 38
      x      = 71
      height = 15
      width  = 33
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Clusters"
      title_align = "left"
      precision   = 0
      request {
        q          = "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name})"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 24
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Namespaces"
      title_align = "left"
      precision   = 0
      request {
        q          = "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace})"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 38
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Deployments"
      title_align = "left"
      precision   = 0
      request {
        q          = "count_nonzero(avg:kubernetes_state.deployment.replicas{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace,kube_deployment})"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 8
      x      = 52
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Services"
      title_align = "left"
      precision   = 0
      request {
        q          = "sum:kubernetes_state.service.count{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 52
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "DaemonSets"
      title_align = "left"
      precision   = 0
      request {
        q          = "count_nonzero(avg:kubernetes_state.daemonset.desired{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace,kube_daemon_set})"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 8
      x      = 38
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Nodes"
      title_align = "left"
      precision   = 0
      request {
        q          = "sum:kubernetes_state.node.count{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 8
      x      = 24
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      custom_link {
        link  = "https://app.datadoghq.com/screen/integration/30322/kubernetes-pods-overview"
        label = "View Pods overview"
      }
      title_size  = "16"
      title       = "Pods"
      title_align = "left"
      precision   = 0
      request {
        q          = "sum:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 0
      x      = 66
      height = 7
      width  = 13
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Containers"
      title_align = "left"
      precision   = 0
      request {
        q          = "sum:kubernetes.containers.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 8
      x      = 66
      height = 7
      width  = 13
    }
  }
  widget {
    timeseries_definition {
      title_size = "16"
      yaxis {
        include_zero = true
        max          = "auto"
        scale        = "linear"
        min          = "auto"
        label        = ""
      }
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      title       = "Network errors per pod"
      legend_size = "0"
      request {
        q = "sum:kubernetes.network.rx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      request {
        q = "sum:kubernetes.network.tx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 121
      x      = 151
      height = 16
      width  = 43
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_17" {

  notify_list = null
  description = <<EOF
This dashboard visualizes high-level resource metrics from your EC2 instances, so you can monitor the performance of your AWS compute infrastructure. Further reading on AWS EC2 monitoring:

- [Datadog's guide to key AWS EC2 metrics](https://www.datadoghq.com/blog/ec2-monitoring/)

- [How to collect AWS EC2 metrics using AWS CloudWatch](https://www.datadoghq.com/blog/collecting-ec2-metrics/)

- [How to monitor AWS EC2 with Datadog](https://www.datadoghq.com/blog/monitoring-ec2-instances-with-datadog/)

- [Datadog's AWS EC2 integration docs](https://docs.datadoghq.com/integrations/amazon_ec2/)

Clone this template AWS EC2 dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "region"
    name    = "region"
  }
  template_variable {
    default = "*"
    prefix  = "autoscaling_group"
    name    = "autoscaling_group"
  }
  template_variable {
    default = "*"
    prefix  = "image"
    name    = "image_id"
  }
  is_read_only = true
  title        = "AWS EC2 (cloned)"
  url          = "/dashboard/3g7-6kz-e9d/aws-ec2-cloned"
  widget {
    event_stream_definition {
      title_size     = "13"
      title          = "EC2 events"
      title_align    = "left"
      tags_execution = "and"
      live_span      = "1w"
      query          = "sources:ec2"
      event_size     = "s"
    }
    widget_layout {
      y      = 44
      x      = 0
      height = 34
      width  = 38
    }
  }
  widget {
    query_value_definition {
      title_size  = "13"
      title       = "Active EC2 instances (max)"
      title_align = "left"
      text_align  = "center"
      precision   = 2
      live_span   = "1h"
      autoscale   = true
      request {
        q          = "sum:aws.ec2.host_ok{$scope,$region,$autoscaling_group,$image_id}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 13
      x      = 20
      height = 10
      width  = 18
    }
  }
  widget {
    image_definition {
      url    = "https://app.datadoghq.com/static/images/saas_logos/bot/amazon_ec2.png"
      sizing = "center"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 11
      width  = 38
    }
  }
  widget {
    toplist_definition {
      title_size  = "13"
      title       = "Active EC2 instances (max) by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(sum:aws.ec2.host_ok{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'max', 'desc')"
        style {
          palette = "grey"
        }
      }
    }
    widget_layout {
      y      = 25
      x      = 0
      height = 18
      width  = 38
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Network in by instance type (top 10)"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "top(avg:aws.ec2.network_in{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          line_width = "normal"
          palette    = "blue"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 31
      x      = 113
      height = 23
      width  = 42
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = "CPU"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 40
      height = 23
      width  = 12
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "I/O"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 25
      x      = 40
      height = 5
      width  = 71
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Network"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 25
      x      = 113
      height = 5
      width  = 71
    }
  }
  widget {
    toplist_definition {
      title_size  = "13"
      title       = "Network in by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(avg:aws.ec2.network_in{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          palette = "blue"
        }
      }
    }
    widget_layout {
      y      = 31
      x      = 156
      height = 23
      width  = 28
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Network out by instance type (top 10)"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "top(avg:aws.ec2.network_out{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          line_width = "normal"
          palette    = "red"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 55
      x      = 113
      height = 23
      width  = 42
    }
  }
  widget {
    toplist_definition {
      title_size  = "13"
      title       = "Network out by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(avg:aws.ec2.network_out{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          palette = "red"
        }
      }
    }
    widget_layout {
      y      = 55
      x      = 156
      height = 23
      width  = 28
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "CPU utilization by instance type (top 10)"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "top(avg:aws.ec2.cpuutilization{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 0
      x      = 53
      height = 23
      width  = 79
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Writes by instance type (top 10)"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "top(avg:aws.ec2.disk_write_bytes{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 55
      x      = 40
      height = 23
      width  = 42
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Reads by instance type (top 10)"
      title_align = "left"
      show_legend = false
      live_span   = "4h"
      legend_size = "0"
      request {
        q = "top(avg:aws.ec2.disk_read_bytes{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 31
      x      = 40
      height = 23
      width  = 42
    }
  }
  widget {
    toplist_definition {
      title_size  = "13"
      title       = "Reads by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(avg:aws.ec2.disk_read_bytes{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          palette = "green"
        }
      }
    }
    widget_layout {
      y      = 31
      x      = 83
      height = 23
      width  = 28
    }
  }
  widget {
    toplist_definition {
      title_size  = "13"
      title       = "Writes by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(avg:aws.ec2.disk_write_bytes{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          palette = "purple"
        }
      }
    }
    widget_layout {
      y      = 55
      x      = 83
      height = 23
      width  = 28
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = false
      tick_edge        = "bottom"
      text_align       = "left"
      content          = "Remember to [enable Detailed Monitoring](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-new.html) on your Amazon EC2 Instances from the AWS console to make sure your metrics are reported in one-minute intervals"
      font_size        = "14"
      background_color = "yellow"
    }
    widget_layout {
      y      = 0
      x      = 162
      height = 23
      width  = 22
    }
  }
  widget {
    check_status_definition {
      title_size  = "13"
      title       = "EC2 Service Status"
      title_align = "center"
      live_span   = "30m"
      check       = "aws.status"
      tags        = ["service:ec2", ]
      grouping    = "cluster"
    }
    widget_layout {
      y      = 13
      x      = 0
      height = 10
      width  = 18
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "CPU utilization by instance type"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(avg:aws.ec2.cpuutilization{$scope,$region,$autoscaling_group,$image_id} by {instance-type}, 10, 'mean', 'desc')"
        style {
          palette = "orange"
        }
      }
    }
    widget_layout {
      y      = 0
      x      = 133
      height = 23
      width  = 28
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_18" {

  notify_list = null
  description = <<EOF
This dashboard provides an overview of the resource utilization, throughput, and performance of your MongoDB Atlas databases so you can identify and troubleshoot performance issues in one place. For further reading on monitoring MongoDB Atlas: 

- [How to monitor MongoDB Atlas with Datadog](https://www.datadoghq.com/blog/monitor-atlas-performance-metrics-with-datadog/)

- [Datadog's MongoDB Atlas integration docs](https://docs.datadoghq.com/integrations/mongodb_atlas/#overview). 

Clone this template dashboard to make changes and add your own graph widgets. (cloned) (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "organizationname"
    name    = "organization"
  }
  template_variable {
    default = "*"
    prefix  = "projectname"
    name    = "project"
  }
  template_variable {
    default = "*"
    prefix  = "replicasetname"
    name    = "replica-set"
  }
  template_variable {
    default = "*"
    prefix  = "shardedclustername"
    name    = "sharded-cluster"
  }
  template_variable {
    default = "*"
    prefix  = "processstate"
    name    = "process-state"
  }
  template_variable {
    default = "*"
    prefix  = "processtype"
    name    = "process-type"
  }
  is_read_only = true
  title        = "MongoDB Atlas - Overview (cloned) (cloned)"
  url          = "/dashboard/r6g-mv8-qpp/mongodb-atlas---overview-cloned-cloned"
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Connections"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 39
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Max memory usage"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.mem.resident{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.mem.virtual{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 7
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document reads"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.metrics.document.returned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 23
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Query efficiency"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 47
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Read requests (per second)"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.opcounters.getmore{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.query{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 7
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Operations latency"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, avg:mongodb.atlas.oplatencies.writes.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 47
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "IOPS"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.system.disk.iops.reads{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.system.disk.iops.writes{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 23
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Disk space free"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.disk.space.free{$replica-set,$scope,$process-type,$process-state,$sharded-cluster,$project,$organization}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 26
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Process memory usage"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.mem.resident{$replica-set,$project,$sharded-cluster,$process-type,$process-state,$scope,$organization}"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 10
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "CPU usage (%)"
      title_align = "left"
      custom_unit = "%"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">="
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<"
        }
      }
    }
    widget_layout {
      y      = 10
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Connection count"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 42
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "IOPS"
      title_align = "left"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.system.disk.iops.total{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_count()"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 26
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Read latency (avg)"
      title_align = "left"
      custom_unit = "ms"
      precision   = 0
      title_size  = "16"
      request {
        q          = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 100
          comparator = ">="
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 100
          comparator = "<"
        }
      }
    }
    widget_layout {
      y      = 42
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Data size"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.stats.totalstoragesize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.stats.totaldatasize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 39
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Disk space used"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.system.disk.space.free{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.system.disk.space.used{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 23
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Max CPU usage (%)"
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y > 100"
      }
      marker {
        display_type = "warning dashed"
        value        = "y > 60"
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 7
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Top hosts by CPU usage"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$sharded-cluster,$process-state,$process-type,$project,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<="
        }
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 71
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Top hosts by disk space used"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.disk.space.percentused{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<="
        }
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 55
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    image_definition {
      url    = "/static/images/saas_logos/bot/mongodb_atlas.png"
      sizing = "center"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 9
      width  = 19
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Health status"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 20
      height = 9
      width  = 25
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Thoughput"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 47
      height = 6
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Write requests (per second)"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.opcounters.delete{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), avg:mongodb.atlas.opcounters.insert{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.update{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 7
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Resource utilization "
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 118
      height = 6
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document writes"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.metrics.document.deleted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.inserted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.updated{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 23
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Performance"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 39
      x      = 47
      height = 7
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Total cursors"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.cursors.totalopen{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 63
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Replication headroom"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.replset.replicationheadroom{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 63
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "IOPS usage (%)"
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y > 100"
      }
      marker {
        display_type = "warning dashed"
        value        = "y > 50"
      }
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.system.disk.iops.percentutilization{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 55
      x      = 118
      height = 15
      width  = 34
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_19" {

  notify_list = null
  description = <<EOF
This dashboard provides an overview of core AWS services—including EC2, EBS, and ELB—so you can see at a glance the health and performance of your AWS cloud infrastructure. Further reading on AWS monitoring:

- [Key metrics for AWS monitoring](https://www.datadoghq.com/blog/aws-monitoring/)

- [Datadog's AWS integration docs](https://docs.datadoghq.com/integrations/amazon_web_services/)

Clone this template dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = "account_id"
    name    = "account"
  }
  template_variable {
    default = "*"
    prefix  = "region"
    name    = "region"
  }
  template_variable {
    default = "*"
    prefix  = "scope"
    name    = "scope"
  }
  is_read_only = true
  title        = "AWS (Overview) (cloned)"
  url          = "/dashboard/f2v-3v5-mwu/aws-overview-cloned"
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Active EC2 instances"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "sum:aws.ec2.host_ok{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 53
      x      = 122
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "EBS volumes"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "sum:aws.ebs.volume_read_ops{$account,$region,$scope}/avg:aws.ebs.volume_read_ops{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 8
      x      = 34
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Unhealthy hosts"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "avg:aws.elb.un_healthy_host_count{$account,$region,$scope}"
        aggregator = "max"
        conditional_formats {
          palette    = "green_on_white"
          value      = 1
          comparator = "<"
        }
        conditional_formats {
          palette    = "red_on_white"
          value      = 1
          comparator = ">="
        }
      }
    }
    widget_layout {
      y      = 8
      x      = 122
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Healthy hosts"
      title_align = "left"
      text_align  = "right"
      precision   = 0
      title_size  = "13"
      request {
        q          = "sum:aws.elb.healthy_host_count{$account,$region,$scope}"
        aggregator = "max"
        conditional_formats {
          palette    = "red_on_white"
          value      = 1
          comparator = "<"
        }
        conditional_formats {
          palette    = "green_on_white"
          value      = 1
          comparator = ">="
        }
      }
    }
    widget_layout {
      y      = 8
      x      = 110
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Min utilization"
      title_align = "left"
      custom_unit = "%"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "avg:aws.ec2.cpuutilization{$account,$region,$scope}"
        aggregator = "min"
        conditional_formats {
          palette    = "red_on_white"
          value      = 10
          comparator = "<"
        }
        conditional_formats {
          palette    = "green_on_white"
          value      = 10
          comparator = ">="
        }
      }
    }
    widget_layout {
      y      = 53
      x      = 110
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Max utilization"
      title_align = "left"
      custom_unit = "%"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "avg:aws.ec2.cpuutilization{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 62
      x      = 110
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Requests"
      title_align = "left"
      custom_unit = "/s"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "sum:aws.elb.request_count{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 8
      x      = 84
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Latency"
      title_align = "left"
      custom_unit = "ms"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "1000*avg:aws.elb.latency{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 8
      x      = 96
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Worst Q length"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "max:aws.ebs.volume_queue_length{$account,$region,$scope}"
        aggregator = "max"
        conditional_formats {
          palette    = "red_on_white"
          value      = 20
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 8
      x      = 72
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "Avg Q length"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "avg:aws.ebs.volume_queue_length{$account,$region,$scope}"
        aggregator = "max"
        conditional_formats {
          palette    = "white_on_red"
          value      = 20
          comparator = ">"
        }
      }
    }
    widget_layout {
      y      = 8
      x      = 60
      height = 8
      width  = 11
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "ELB requests per second"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.elb.request_count{$region,$account,$scope} by {availability-zone}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 17
      x      = 84
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "ELB latency (ms)"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "1000*avg:aws.elb.latency{$region,$account,$scope} by {availability-zone}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 35
      x      = 84
      height = 17
      width  = 49
    }
  }
  widget {
    query_value_definition {
      autoscale   = true
      title       = "EBS overall IOps"
      title_align = "left"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "sum:aws.ebs.volume_read_ops{$account,$region,$scope}+sum:aws.ebs.volume_write_ops{$account,$region,$scope}"
        aggregator = "max"
      }
    }
    widget_layout {
      y      = 8
      x      = 46
      height = 8
      width  = 11
    }
  }
  widget {
    query_value_definition {
      autoscale   = false
      title       = "Average utilization"
      title_align = "left"
      custom_unit = "%"
      text_align  = "center"
      precision   = 0
      title_size  = "13"
      request {
        q          = "avg:aws.ec2.cpuutilization{$account,$region,$scope}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 62
      x      = 122
      height = 8
      width  = 11
    }
  }
  widget {
    heatmap_definition {
      title_size  = "13"
      title       = "EC2 CPU utilization by instance (%)"
      title_align = "left"
      show_legend = false
      live_span   = "1d"
      legend_size = "0"
      request {
        q = "avg:aws.ec2.cpuutilization{$account,$region,$scope} by {host}"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 71
      x      = 97
      height = 17
      width  = 36
    }
  }
  widget {
    heatmap_definition {
      title_size  = "13"
      title       = "EBS IOps by volume"
      title_align = "left"
      show_legend = false
      live_span   = "1d"
      legend_size = "0"
      request {
        q = "avg:aws.ebs.volume_read_ops{$account,$region,$scope} by {host,device}.as_count(), avg:aws.ebs.volume_write_ops{$account,$region,$scope} by {host,device}.as_count(), avg:aws.ebs.volume_read_ops{$account,$region,$scope} by {host,device}.as_count()+avg:aws.ebs.volume_write_ops{$account,$region,$scope} by {host,device}.as_count()"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 17
      x      = 34
      height = 17
      width  = 49
    }
  }
  widget {
    heatmap_definition {
      title_size  = "13"
      title       = "EBS queue length by volume"
      title_align = "left"
      show_legend = false
      live_span   = "1d"
      legend_size = "0"
      request {
        q = "avg:aws.ebs.volume_queue_length{$account,$region,$scope} by {host,device}"
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 35
      x      = 34
      height = 17
      width  = 49
    }
  }
  widget {
    image_definition {
      url    = "/static/images/screenboard/integrations/aws.png"
      sizing = "fit"
      margin = "large"
    }
    widget_layout {
      y      = 1
      x      = 1
      height = 15
      width  = 32
    }
  }
  widget {
    event_stream_definition {
      title_size     = "13"
      title          = "AWS events"
      title_align    = "left"
      tags_execution = "and"
      query          = "sources:aws "
      event_size     = "s"
    }
    widget_layout {
      y      = 17
      x      = 1
      height = 89
      width  = 32
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "ELBs"
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 1
      x      = 84
      height = 6
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = <<EOF
EC2 
Instances
EOF
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 53
      x      = 97
      height = 17
      width  = 12
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = <<EOF
EBS 
volumes
EOF
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 1
      x      = 34
      height = 6
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "right"
      text_align       = "center"
      content          = <<EOF
Lambda
Functions
EOF
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 53
      x      = 34
      height = 35
      width  = 12
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Lambda execution errors by function"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.lambda.errors{$region,$account,$scope} by {functionname}.as_count()"
        style {
          line_width = "normal"
          palette    = "red"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 89
      x      = 84
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Lambda invocations by function"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "top(sum:aws.lambda.invocations{$region,$account,$scope} by {functionname}.as_count(), 20, 'sum', 'desc')"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 89
      x      = 34
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Lambda execution duration by function"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.lambda.duration.sum{$account,$region,$scope} by {functionname}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 53
      x      = 47
      height = 17
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "S3 Buckets"
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 1
      x      = 134
      height = 6
      width  = 99
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "S3 buckets size, past week"
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      legend_size = "0"
      request {
        q = "max:aws.s3.bucket_size_bytes{$account,$region,$scope} by {bucketname}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 8
      x      = 134
      height = 18
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "S3 buckets number of objects, past week"
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      legend_size = "0"
      request {
        q = "max:aws.s3.number_of_objects{$account,$region,$scope} by {bucketname}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
    }
    widget_layout {
      y      = 27
      x      = 134
      height = 18
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "S3 all requests"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.s3.all_requests{$account,$region,$scope} by {bucketname}.as_count()"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 8
      x      = 184
      height = 18
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "Lambda throttled invocation attempts by function"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:docker.cpu.throttled{$account,$region,$scope} by {availability-zone}*1000"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 71
      x      = 47
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "S3 4xx errors"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.s3.4xx_errors{$account,$region,$scope} by {bucketname}.as_count()"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 27
      x      = 184
      height = 18
      width  = 49
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = <<EOF
RDS
Instances
EOF
      font_size        = "24"
      background_color = "pink"
    }
    widget_layout {
      y      = 46
      x      = 134
      height = 6
      width  = 99
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "RDS connections by instance, top 10"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "top10(max:aws.rds.database_connections{$region,$account,$scope} by {dbinstanceidentifier})"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 53
      x      = 134
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "RDS replication lag by instance, top 10"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "top10(avg:aws.rds.replica_lag{$account,$region,$scope} by {dbinstanceidentifier})"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 71
      x      = 184
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "RDS CPU by instance (%), top 10"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "top10(avg:aws.rds.cpuutilization{$account,$region,$scope} by {dbinstanceidentifier})"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 71
      x      = 134
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "13"
      title       = "RDS available RAM (MiB) by instance, bottom 10"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "bottom10(avg:aws.rds.freeable_memory{$account,$region,$scope} by {dbinstanceidentifier})"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "line"
      }
    }
    widget_layout {
      y      = 53
      x      = 184
      height = 17
      width  = 49
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "ELB 5xx Errors"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.elb.httpcode_target_5xx{*} by {availability-zone}.as_count()"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "bars"
      }
    }
    widget_layout {
      y      = 89
      x      = 134
      height = 17
      width  = 49
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_20" {

  notify_list = null
  description = <<EOF
This dashboard provides an overview of the resource utilization, throughput, and performance of your MongoDB Atlas databases so you can identify and troubleshoot performance issues in one place. For further reading on monitoring MongoDB Atlas: 

- [How to monitor MongoDB Atlas with Datadog](https://www.datadoghq.com/blog/monitor-atlas-performance-metrics-with-datadog/)

- [Datadog's MongoDB Atlas integration docs](https://docs.datadoghq.com/integrations/mongodb_atlas/#overview). 

Clone this template dashboard to make changes and add your own graph widgets. (cloned)
EOF
  template_variable {
    default = "*"
    prefix  = null
    name    = "scope"
  }
  template_variable {
    default = "*"
    prefix  = "organizationname"
    name    = "organization"
  }
  template_variable {
    default = "*"
    prefix  = "projectname"
    name    = "project"
  }
  template_variable {
    default = "*"
    prefix  = "replicasetname"
    name    = "replica-set"
  }
  template_variable {
    default = "*"
    prefix  = "shardedclustername"
    name    = "sharded-cluster"
  }
  template_variable {
    default = "*"
    prefix  = "processstate"
    name    = "process-state"
  }
  template_variable {
    default = "*"
    prefix  = "processtype"
    name    = "process-type"
  }
  is_read_only = true
  title        = "MongoDB Atlas - Overview (cloned)"
  url          = "/dashboard/57p-cx4-uxm/mongodb-atlas---overview-cloned"
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Connections"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 39
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Max memory usage"
      title_align = "left"
      show_legend = false
      request {
        q = "max:mongodb.atlas.mem.resident{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.mem.virtual{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 7
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document reads"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:mongodb.atlas.metrics.document.returned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 23
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Query efficiency"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "dog_classic"
          line_type  = "solid"
        }
        display_type = "line"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 47
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Read requests (per second)"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:mongodb.atlas.opcounters.getmore{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.query{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 7
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Operations latency"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, avg:mongodb.atlas.oplatencies.writes.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "line"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 47
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "IOPS"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.system.disk.iops.reads{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "green"
          line_type  = "solid"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.system.disk.iops.writes{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "line"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 23
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Disk space free"
      title_align = "left"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.system.disk.space.free{$replica-set,$scope,$process-type,$process-state,$sharded-cluster,$project,$organization}"
        aggregator = "avg"
      }
    }
    widget_layout {
      y      = 26
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Process memory usage"
      title_align = "left"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.mem.resident{$replica-set,$project,$sharded-cluster,$process-type,$process-state,$scope,$organization}"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 10
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "CPU usage (%)"
      title_align = "left"
      custom_unit = "%"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">="
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<"
        }
      }
    }
    widget_layout {
      y      = 10
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Connection count"
      title_align = "left"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 42
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "IOPS"
      title_align = "left"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.system.disk.iops.total{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_count()"
        aggregator = "last"
      }
    }
    widget_layout {
      y      = 26
      x      = 23
      height = 15
      width  = 22
    }
  }
  widget {
    query_value_definition {
      title_size  = "16"
      title       = "Read latency (avg)"
      title_align = "left"
      custom_unit = "ms"
      precision   = 0
      autoscale   = true
      request {
        q          = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "avg"
        conditional_formats {
          palette    = "white_on_red"
          value      = 500
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 100
          comparator = ">="
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 100
          comparator = "<"
        }
      }
    }
    widget_layout {
      y      = 42
      x      = 0
      height = 15
      width  = 22
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Data size"
      title_align = "left"
      show_legend = false
      request {
        q = "max:mongodb.atlas.stats.totalstoragesize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.stats.totaldatasize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 39
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Disk space used"
      title_align = "left"
      show_legend = false
      request {
        q = "max:mongodb.atlas.system.disk.space.free{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.system.disk.space.used{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          line_width = "normal"
          palette    = "cool"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 23
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Max CPU usage (%)"
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y > 100"
      }
      marker {
        display_type = "warning dashed"
        value        = "y > 60"
      }
      show_legend = false
      request {
        q = "max:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 7
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Top hosts by CPU usage"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$sharded-cluster,$process-state,$process-type,$project,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<="
        }
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 71
      x      = 118
      height = 15
      width  = 34
    }
  }
  widget {
    toplist_definition {
      title_size  = "16"
      title       = "Top hosts by disk space used"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.disk.space.percentused{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          palette    = "white_on_red"
          value      = 80
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_yellow"
          value      = 60
          comparator = ">"
        }
        conditional_formats {
          palette    = "white_on_green"
          value      = 60
          comparator = "<="
        }
        style {
          palette = "dog_classic"
        }
      }
    }
    widget_layout {
      y      = 55
      x      = 153
      height = 15
      width  = 34
    }
  }
  widget {
    image_definition {
      url    = "/static/images/saas_logos/bot/mongodb_atlas.png"
      sizing = "center"
    }
    widget_layout {
      y      = 0
      x      = 0
      height = 9
      width  = 19
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Health status"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 20
      height = 9
      width  = 25
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Thoughput"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 47
      height = 6
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Write requests (per second)"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:mongodb.atlas.opcounters.delete{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), avg:mongodb.atlas.opcounters.insert{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.update{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 7
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Resource utilization "
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 0
      x      = 118
      height = 6
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Document writes"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:mongodb.atlas.metrics.document.deleted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.inserted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.updated{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
        style {
          line_width = "normal"
          palette    = "purple"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 23
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    note_definition {
      tick_pos         = "50%"
      show_tick        = true
      tick_edge        = "bottom"
      text_align       = "center"
      content          = "Performance"
      font_size        = "18"
      background_color = "gray"
    }
    widget_layout {
      y      = 39
      x      = 47
      height = 7
      width  = 69
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Total cursors"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:mongodb.atlas.cursors.totalopen{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          line_width = "normal"
          palette    = "grey"
          line_type  = "solid"
        }
        display_type = "bars"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 63
      x      = 47
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "Replication headroom"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.replset.replicationheadroom{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 63
      x      = 82
      height = 15
      width  = 34
    }
  }
  widget {
    timeseries_definition {
      title_size  = "16"
      title       = "IOPS usage (%)"
      title_align = "left"
      marker {
        display_type = "error dashed"
        value        = "y > 100"
      }
      marker {
        display_type = "warning dashed"
        value        = "y > 50"
      }
      show_legend = false
      request {
        q = "avg:mongodb.atlas.system.disk.iops.percentutilization{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          line_width = "normal"
          palette    = "warm"
          line_type  = "solid"
        }
        display_type = "area"
      }
      legend_size = "0"
    }
    widget_layout {
      y      = 55
      x      = 118
      height = 15
      width  = 34
    }
  }
  layout_type = "free"
}


resource "datadog_dashboard" "dashboard_21" {

  notify_list = null
  description = "Created by Terraform"
  template_variable {
    default = "*"
    prefix  = "name"
    name    = "host"
  }
  is_read_only = true
  title        = "System Metrics per instance"
  url          = "/dashboard/qv5-jtq-u89/system-metrics-per-instance"
  widget {
    timeseries_definition {
      yaxis {
      }
      title = "Free disk space in percent"
      request {
        q = "avg:system.disk.used{$host}/avg:system.disk.total{$host}*100"
        style {
          palette = "dog_classic"
        }
        display_type = "line"
      }
    }
  }
  widget {
    timeseries_definition {
      yaxis {
      }
      title = "CPU Utilization"
      request {
        q = "avg:aws.ec2.cpuutilization.maximum{$host}"
        style {
          palette = "dog_classic"
        }
        display_type = "line"
      }
    }
  }
  widget {
    timeseries_definition {
      yaxis {
      }
      title = "Free memory in percent"
      request {
        q = "avg:system.mem.free{$host}/avg:system.mem.total{$host}*100"
        style {
          palette = "dog_classic"
        }
        display_type = "line"
      }
    }
  }
  layout_type = "ordered"
}


