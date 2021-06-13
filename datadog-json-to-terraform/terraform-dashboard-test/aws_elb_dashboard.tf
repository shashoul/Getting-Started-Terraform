resource "datadog_dashboard" "aws_elb_dashboard_test" {

  title       = "Shady Terraform Test ... AWS ApplicationELB"
  description = <<EOF
This dashboard provides a high-level overview of your AWS Application Load Balancers, so you can track the throughput and performance of your load balancers and backend hosts. Further reading on AWS Application ELB monitoring:

- [Monitor Amazon's Application Load Balancer with Datadog](https://www.datadoghq.com/blog/monitor-application-load-balancer/)

- [Datadog's AWS ELB integration docs](https://docs.datadoghq.com/integrations/amazon_elb/)

Clone this template dashboard to make changes and add your own graph widgets.
EOF
  widget {
    widget_layout {
      x      = 65
      y      = 0
      width  = 23
      height = 12
    }
    query_value_definition {
      title       = "Requests per second (avg)"
      title_size  = "13"
      title_align = "left"
      live_span   = "1h"
      request {
        q          = "sum:aws.applicationelb.request_count{$scope,$host,$name,$targetgroup}.as_rate()"
        aggregator = "avg"
      }
      autoscale  = true
      text_align = "left"
      precision  = 1
    }
  }
  widget {
    widget_layout {
      x      = 89
      y      = 0
      width  = 23
      height = 12
    }
    query_value_definition {
      title       = "Response time  (avg)"
      title_size  = "13"
      title_align = "left"
      live_span   = "1h"
      request {
        q          = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 500
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 400
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 400
        }
      }
      autoscale   = false
      custom_unit = "ms"
      text_align  = "left"
      precision   = 0
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 30
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "HTTP 3xx Responses"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.httpcode_target_3xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 41
      y      = 0
      width  = 23
      height = 12
    }
    query_value_definition {
      title       = "Unhealthy hosts count (max)"
      title_size  = "13"
      title_align = "left"
      live_span   = "1h"
      request {
        q          = "sum:aws.applicationelb.un_healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "max"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 0
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 0
        }
      }
      autoscale  = true
      text_align = "left"
      precision  = 0
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 0
      width  = 23
      height = 12
    }
    query_value_definition {
      title       = "Healthy hosts count (min)"
      title_size  = "13"
      title_align = "left"
      live_span   = "1h"
      request {
        q          = "sum:aws.applicationelb.healthy_host_count{$scope,$host,$name,$targetgroup}"
        aggregator = "min"
        conditional_formats {
          comparator = ">"
          palette    = "green_on_white"
          value      = 0
        }
        conditional_formats {
          comparator = "<="
          palette    = "red_on_white"
          value      = 0
        }
      }
      autoscale  = true
      text_align = "left"
      precision  = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 0
      width  = 16
      height = 12
    }
    image_definition {
      url    = "/static/images/logos/amazon-alb_avatar.svg"
      sizing = "fit"
      margin = "large"
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 14
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "HTTP 2xx Responses"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.httpcode_target_2xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 65
      y      = 14
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "HTTP 4xx Responses"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.httpcode_target_4xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 65
      y      = 30
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "HTTP 5xx Responses"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.httpcode_target_5xx{$scope,$host,$name,$targetgroup} by {host}.as_count()"
        style {
          palette = "warm"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 63
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Response Time"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "4"
      live_span   = "4h"
      request {
        q            = "avg:aws.applicationelb.target_response_time.average{$scope,$host,$name,$targetgroup} * 1000"
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 47
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Active Connections"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.active_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 65
      y      = 47
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "New Connections"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.new_connection_count{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 65
      y      = 63
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Processed Bytes"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:aws.applicationelb.processed_bytes{$scope,$host,$name,$targetgroup} by {host}"
        style {
          palette = "dog_classic"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 14
      width  = 16
      height = 31
    }
    note_definition {
      content          = "HTTP Responses"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 47
      width  = 16
      height = 31
    }
    note_definition {
      content          = "Connections and Latencies"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  template_variable {
    name    = "scope"
    default = "*"
  }
  template_variable {
    name    = "host"
    default = "*"
    prefix  = "host"
  }
  template_variable {
    name    = "name"
    default = "*"
    prefix  = "name"
  }
  template_variable {
    name    = "targetgroup"
    default = "*"
    prefix  = "targetgroup"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}