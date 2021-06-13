resource "datadog_dashboard" "resource_name" {

  title       = "SRV - Uptime Dashboard"
  description = ""
  widget {
    widget_layout {
      x      = 1
      y      = 13
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "500: Backend & Management Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" OR \"status: [500]\" -\"uri: [/api/v2/auth/*]\" -\"uri: [/api/v2/oidc/bindid-oidc/complete]\" -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket)"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 29
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "500: End-Users Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" (\"uri: [/api/v2/auth/*]\" OR \"uri: [/api/v2/oidc/bindid-oidc/complete]\")) -\"rejection: MethodRejection\" -\"client returned from error\" -cannot_consume_ticket"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 3 "
        value        = "y = 3"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 93
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Cloudfront - 4XX Error Rate is High"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:aws.cloudfront.4xx_error_rate{environment:production}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 50 "
        value        = "y = 50"
        display_type = "error dashed"
      }
      marker {
        label        = " y > 30 "
        value        = "y = 30"
        display_type = "warning dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 93
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Cloudfront - 5XX Error Rate is High"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:aws.cloudfront.5xx_error_rate{*}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5% "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 93
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "ELB Monitor - Count 4XX errors on auth server"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "service:elb status:warn @http.url_details.path:\"/api/v2/oidc/bindid-oidc/token\""
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 45
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "FIDO Registration Failures"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "\"assertion_error_code:9\""
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 45
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid HTTP Method: Frontend/End-User Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" \"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 61
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Management Console Bad Logins"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/*]\" \"Bad administrator session\") OR (\"uri: [/api/v2/mng-ui/*]\" \"Bad credentials provided\"))"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 29
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Number of \"Alias already set\" Errors Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server api_error_code alias_already_set"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 61
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Recovery Journey Invocations Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "״Request started״ ״anonymous_invoke״ ״policy_request_id״ ״ama-rejection-recovery״"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 45
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Ticket consumption errors"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "cannot_consume_ticket ERROR 401"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 29
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "User Cancellation"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\") ((\"uri: [/api/v2/auth/assert?aid=bindid-ama*]\" \"errorCode: [4001]\" \"you denied the request\") OR (\"uri: [/api/v2/auth/assert?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\") OR (\"uri: [/api/v2/auth/login?aid=bindid-oidc*]\" \"errorCode: [4001]\" \"Authentication cancelled by the user\"))"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 61
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "User not found for backend/management support APIs Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server ((\"uri: [/api/v2/mng-ui/support/user*]\" \"User not found\") OR (\"uri: [/api/v2/mng-ui/reports/user*]\" \"User not found\"))"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 51
      y      = 5
      width  = 24
      height = 6
    }
    free_text_definition {
      text       = "slack-bindid-srv-uptime-alerts"
      color      = "#000"
      font_size  = "56"
      text_align = "left"
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 13
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "4XX: Backend & Management - Uncategorized"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [400]\" OR \"statusCode: [401]\" OR \"statusCode: [404]\" OR \"status: [400]\" OR \"status: [401]\") -\"uri: [/api/v2/auth/*]\" -\"client returned from error\" -cannot_consume_ticket -(\"uri: [/api/v2/mng-ui/support/user*]\" \"User not found\") -(\"uri: [/api/v2/mng-ui/reports/user*]\" \"User not found\") -(\"uri: [/api/v2/mng-ui/*]\" \"Bad administrator session\") -(\"uri: [/api/v2/mng-ui/*]\" \"Bad credentials provided\") -\"uri: [/api/v2/oidc/bindid-oidc/complete]\" -\"Unknown authorization code\" -(\"uri: [/api/v2/oidc/bindid-oidc/token]\" \"error: invalid_client\") -(\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\" \"api_error_code: invalid_auth\") -(\"uri: [/api/v2/oidc/*]\" \"error: invalid_request\") -\"api_error_code: alias_already_set\" -(\"uri: [/api/v2/oidc/bindid-oidc/token]\" invalid_grant \"Invalid redirect uri\") -(\"uri: [/api/v2/oidc/bindid-oidc/token]\" unsupported_grant_type \"Unsupported grant type\") -(\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" invalid_client \"Invalid client credentials\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 109
      width  = 47
      height = 16
    }
    timeseries_definition {
      title       = "AWS ALB - 4XX Error Rate is High"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:aws.applicationelb.httpcode_target_4xx{environment:production}.as_count()"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 50 rsps "
        value        = "y = 50"
        display_type = "error dashed"
      }
      marker {
        label        = " y > 30 rsps "
        value        = "y = 30"
        display_type = "warning dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 93
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "AWS ALB - 5XX Error Rate is High Status"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:aws.applicationelb.httpcode_target_5xx{environment:production}.as_count()"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 10 rsps "
        value        = "y = 10"
        display_type = "error dashed"
      }
      marker {
        label        = " y > 7 rsps "
        value        = "y = 7"
        display_type = "warning dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 13
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Backend & Management - unsupported_grant"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" unsupported_grant_type \"Unsupported grant type\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 13
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Backend & Management – invalid_grant"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" invalid_grant \"Invalid redirect uri\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 29
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "End User - invalid_client"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/authorize*]\" invalid_client \"Invalid client credentials\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 61
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid HTTP Method: Backend/Management"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"statusCode: [500]\" -\"uri: [/api/v2/auth/*]\" \"rejection: MethodRejection\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 45
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid Request - Invalid redirect URI on /authorize"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Invalid redirect uri\""
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 97
      y      = 77
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid Request - Missing client_id on /authorize"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server \"uri: [/api/v2/oidc/bindid-oidc/authorize?*]\" invalid_request \"Missing \" client_id"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 5 "
        value        = "y = 5"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 77
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid authentication to BindID Backend API"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api]\" \"api_error_code: invalid_auth\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 77
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Invalid client credentials on /token"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        log_query {
          index        = "*"
          search_query = "source:bindid-authentication-server (\"uri: [/api/v2/oidc/bindid-oidc/token]\" \"error: invalid_client\")"
          compute_query {
            aggregation = "count"
          }
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y >= 1 "
        value        = "y = 1"
        display_type = "error dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 109
      width  = 47
      height = 16
    }
    timeseries_definition {
      title       = "Test on admin.bindid-sandbox.io/version - Response time check"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:synthetics.http.response.time{url:https://admin.bindid-sandbox.io/version}, avg:synthetics.http.dns.time{url:https://admin.bindid-sandbox.io/version}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 50 rsps "
        value        = "y = 50"
        display_type = "error dashed"
      }
      marker {
        label        = " y > 30 rsps "
        value        = "y = 30"
        display_type = "warning dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 145
      y      = 77
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
      title_size  = "16"
      title_align = "left"
      show_legend = true
      request {
        q = "avg:synthetics.http.response.time{url:https://ts.bindid-sandbox.io/api/v2/status}, avg:synthetics.http.dns.time{url:https://ts.bindid-sandbox.io/api/v2/status}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        label        = " y > 50 rsps "
        value        = "y = 50"
        display_type = "error dashed"
      }
      marker {
        label        = " y > 30 rsps "
        value        = "y = 30"
        display_type = "warning dashed"
      }
    }
  }
  template_variable {
    name    = "var"
    default = "*"
  }
  layout_type  = "free"
  is_read_only = false
  notify_list  = []
}