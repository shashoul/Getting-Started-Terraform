resource "datadog_dashboard" "business_dashboard" {

  title       = "Shady Terraform Test !!! Top Active Business Units"
  description = ""
  widget {
    widget_layout {
      x      = 13
      y      = 25
      width  = 108
      height = 27
    }
    timeseries_definition {
      title       = ""
      title_size  = "16"
      title_align = "left"
      show_legend = true
      live_span   = "1w"
      request {
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
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 1
      width  = 108
      height = 24
    }
    toplist_definition {
      title       = ""
      title_size  = "16"
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
  }
  layout_type  = "free"
  is_read_only = false
  notify_list  = []
}