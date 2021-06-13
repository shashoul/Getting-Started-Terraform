#####
#
# dashboard
#
#####
resource "datadog_dashboard" "dashboard_cloudfront" {

  notify_list = []
  description = ""
  template_variable {
    default = "*"
    prefix  = ""
    name    = "var"
  }
  is_read_only = false
  title        = "Terraform Shady Test - CloudFront Edge Hits"
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


