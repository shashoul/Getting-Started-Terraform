resource "datadog_dashboard" "aws_mq_dashboard" {

  title       = "Shady Terraform Test !!! Amazon MQ"
  description = <<EOF
This dashboard visualizes the activity level of your Amazon MQ broker, so you can understand the volume of your messaging and see whether consumers are keeping up with producers. For more information about Amazon MQ:

- [Amazon MQ integration documentation](https://docs.datadoghq.com/integrations/amazon_mq/)

- [Monitoring Amazon MQ with Datadog](https://www.datadoghq.com/blog/monitor-amazonmq-metrics-with-datadog/)

Clone this template dashboard to make changes and add your own graph widgets.
EOF
  widget {
    widget_layout {
      x      = 1
      y      = 15
      width  = 18
      height = 10
    }
    query_value_definition {
      title       = "Total producers"
      title_size  = "16"
      title_align = "left"
      live_span   = "30m"
      request {
        q          = "sum:aws.amazonmq.producer_count.maximum{$scope}.as_count()"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 26
      width  = 18
      height = 10
    }
    query_value_definition {
      title       = "Total consumers"
      title_size  = "16"
      title_align = "left"
      live_span   = "30m"
      request {
        q          = "sum:aws.amazonmq.consumer_count.maximum{$scope}.as_count()"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 34
      y      = 1
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "CPU utilization per broker (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.amazonmq.cpu_utilization{$scope,$broker} by {broker}"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 124
      y      = 56
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Queue size per queue (messages)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.amazonmq.queue_size{$scope,$broker,$queue,$topic} by {queue}.as_count()"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 34
      y      = 19
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Heap usage per broker (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.amazonmq.heap_usage{$scope,$broker} by {broker}"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 34
      y      = 38
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Total messages sent per destination"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.enqueue_count{$scope,$broker,$queue,$topic} by {queue}.as_count()), exclude_null(sum:aws.amazonmq.enqueue_count{$scope,$broker,$queue,$topic} by {topic}.as_count())"
        style {
          palette    = "green"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 34
      y      = 56
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Total messages received per destination"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.dequeue_count{$scope,$broker,$queue,$topic} by {topic}.as_count()),exclude_null(sum:aws.amazonmq.dequeue_count{$scope,$broker,$queue,$topic} by {queue}.as_count())"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 21
      y      = 1
      width  = 12
      height = 35
    }
    note_definition {
      content          = "Broker resource metrics"
      background_color = "blue"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 79
      y      = 19
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Total consumers per broker"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:aws.amazonmq.total_consumer_count{$scope,$broker} by {broker}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 79
      y      = 1
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Storage limit usage per broker (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.amazonmq.store_percent_usage{$scope,$broker} by {broker}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 124
      y      = 1
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Network in per broker (bytes)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.amazonmq.network_in{$scope,$broker} by {broker}"
        style {
          palette    = "green"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 124
      y      = 19
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Network out per broker (bytes)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:aws.amazonmq.network_out{$scope,$broker} by {broker}"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 21
      y      = 38
      width  = 12
      height = 53
    }
    note_definition {
      content          = "Destination metrics"
      background_color = "blue"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 124
      y      = 38
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Expired count per destination (messages)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.expired_count{$scope,$broker,$queue,$topic} by {topic}.as_count()),exclude_null(sum:aws.amazonmq.expired_count{$scope,$broker,$queue,$topic} by {queue}.as_count())"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 1
      width  = 18
      height = 12
    }
    image_definition {
      url    = "/static/images/logos/amazon-mq_avatar.svg"
      sizing = "fit"
      margin = "large"
    }
  }
  widget {
    widget_layout {
      x      = 79
      y      = 56
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Subscribed consumers per destination"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {topic}.as_count()),exclude_null(sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {queue}.as_count())"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 79
      y      = 38
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Producers per destination"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {topic}.as_count()),exclude_null(sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {queue}.as_count())"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 46
      width  = 18
      height = 9
    }
    query_value_definition {
      title       = "Clean shutdown"
      title_size  = "16"
      title_align = "left"
      live_span   = "30m"
      request {
        q          = "max:aws.amazonmq.journal_files_for_fast_recovery{$scope,$broker,$queue,$topic}"
        aggregator = "max"
      }
      autoscale = true
      precision = 2
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 56
      width  = 18
      height = 9
    }
    query_value_definition {
      title       = "Unclean shutdown"
      title_size  = "16"
      title_align = "left"
      live_span   = "30m"
      request {
        q          = "max:aws.amazonmq.journal_files_for_full_recovery{*}"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 38
      width  = 18
      height = 7
    }
    note_definition {
      content          = "Journal files to be replayed on broker restart"
      background_color = "pink"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 124
      y      = 74
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Broker message latency per destination (ms)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(avg:aws.amazonmq.enqueue_time{$scope,$broker,$queue,$topic} by {topic}),exclude_null(avg:aws.amazonmq.enqueue_time{$scope,$broker,$queue,$topic} by {queue})"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 34
      y      = 74
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Total messages sent to consumers"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(sum:aws.amazonmq.dispatch_count{$scope,$broker,$topic,$queue} by {topic}.as_count()),exclude_null(sum:aws.amazonmq.dispatch_count{$scope,$broker,$topic,$queue} by {queue}.as_count())"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 79
      y      = 74
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Avg memory limit usage per destination (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "exclude_null(avg:aws.amazonmq.memory_usage{$scope,$broker,$queue,$topic} by {topic}),exclude_null(avg:aws.amazonmq.memory_usage{$scope,$broker,$queue,$topic} by {topic})"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  template_variable {
    name    = "scope"
    default = "*"
  }
  template_variable {
    name    = "broker"
    default = "*"
    prefix  = "broker"
  }
  template_variable {
    name    = "queue"
    default = "*"
    prefix  = "queue"
  }
  template_variable {
    name    = "topic"
    default = "*"
    prefix  = "topic"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}