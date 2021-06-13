resource "datadog_dashboard" "jvm_overview_dashboard" {

  title       = "Shady Terraform Test !!! Continuous Profiler JVM overview"
  description = "Metrics gathered from Datadog Continuous Profiler on all Java Virtual Machine applications"
  widget {
    widget_layout {
      x      = 0
      y      = 0
      width  = 81
      height = 6
    }
    note_definition {
      content          = "# Service Performance"
      background_color = "gray"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 7
      width  = 12
      height = 18
    }
    note_definition {
      content          = "## CPU"
      background_color = "blue"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 7
      width  = 28
      height = 18
    }
    toplist_definition {
      title       = "CPU - Cores"
      title_size  = "16"
      title_align = "left"
      request {
      }
      custom_link {
        link  = "https://app.datadoghq.com/apm/service/{{service.value}}"
        label = "service page"
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 26
      width  = 12
      height = 18
    }
    note_definition {
      content          = <<EOF
## Memory Allocation

Heap Memory allocated, that may be subsequently freed by GC.
EOF
      background_color = "orange"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 26
      width  = 28
      height = 18
    }
    toplist_definition {
      title       = "Memory Allocation - Bytes per second"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 26
      width  = 39
      height = 18
    }
    timeseries_definition {
      title       = "Memory Allocation - Bytes per second"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "orange"
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
      x      = 0
      y      = 45
      width  = 12
      height = 14
    }
    note_definition {
      content          = <<EOF
## Contention

Time threads spent locked. Less is better
EOF
      background_color = "yellow"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 45
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "JVM Locks wait time - % of time"
      title_size  = "16"
      title_align = "left"
      request {
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 5
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 0
      width  = 67
      height = 6
    }
    note_definition {
      content          = "# Code level performance"
      background_color = "gray"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 7
      width  = 39
      height = 18
    }
    timeseries_definition {
      title       = "CPU - Cores"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "blue"
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
      x      = 42
      y      = 45
      width  = 39
      height = 14
    }
    timeseries_definition {
      title       = "Locks wait time - Seconds"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "warm"
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
      x      = 0
      y      = 60
      width  = 12
      height = 29
    }
    note_definition {
      content          = <<EOF
## Garbage Collection / VM operations

Operations that stop all threads of applications. Less is better
EOF
      background_color = "green"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 60
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "GC total pause - % of time"
      title_size  = "16"
      title_align = "left"
      request {
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 5
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 60
      width  = 39
      height = 14
    }
    timeseries_definition {
      title       = "GC total pause - % of time"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "green"
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
      y      = 75
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "GC pause time max - Seconds"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 75
      width  = 39
      height = 14
    }
    timeseries_definition {
      title       = "GC pause time max - Seconds"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "green"
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
      x      = 82
      y      = 7
      width  = 28
      height = 18
    }
    toplist_definition {
      title       = "JVM CPU - by method"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 26
      width  = 28
      height = 18
    }
    toplist_definition {
      title       = "JVM allocation Bytes - by Method"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 111
      y      = 7
      width  = 38
      height = 18
    }
    timeseries_definition {
      title       = "JVM CPU - by method"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "blue"
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
      x      = 111
      y      = 26
      width  = 38
      height = 18
    }
    timeseries_definition {
      title       = "JVM allocation Bytes - by type"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "orange"
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
      x      = 82
      y      = 60
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "Top Operations by Avg Duration (%)"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 45
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "JVM locks sum - by method"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 111
      y      = 45
      width  = 38
      height = 14
    }
    timeseries_definition {
      title       = "JVM Locks - by method"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "warm"
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
      x      = 111
      y      = 60
      width  = 38
      height = 14
    }
    timeseries_definition {
      title       = "Top Operations by Avg Duration (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "green"
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
      x      = 111
      y      = 75
      width  = 38
      height = 14
    }
    timeseries_definition {
      title       = "Top Operations by Max Duration"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "green"
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
      x      = 82
      y      = 75
      width  = 28
      height = 14
    }
    toplist_definition {
      title       = "Top Operations by Max Duration"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 106
      width  = 12
      height = 15
    }
    note_definition {
      content          = <<EOF
## Network I/O

Time spent locked socket reading or writing
EOF
      background_color = "gray"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 106
      width  = 39
      height = 15
    }
    timeseries_definition {
      title       = "Total Read Duration - % of time"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "grey"
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
      y      = 106
      width  = 28
      height = 15
    }
    toplist_definition {
      title       = "Total Read Duration - % of time"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 106
      width  = 28
      height = 15
    }
    toplist_definition {
      title       = "Total Write Duration - % of time"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 111
      y      = 106
      width  = 38
      height = 15
    }
    timeseries_definition {
      title       = "Total Write Duration - % of time"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "grey"
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
      x      = 0
      y      = 90
      width  = 12
      height = 15
    }
    note_definition {
      content          = <<EOF
## Exceptions

Thrown Exceptions (caught + uncaught). 
Less is better.
EOF
      background_color = "pink"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 13
      y      = 90
      width  = 28
      height = 15
    }
    toplist_definition {
      title       = "Total Exceptions"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 42
      y      = 90
      width  = 39
      height = 15
    }
    timeseries_definition {
      title       = "Total Exceptions"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "warm"
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
      x      = 82
      y      = 90
      width  = 28
      height = 15
    }
    toplist_definition {
      title       = "Total Exceptions - by Class"
      title_size  = "16"
      title_align = "left"
      request {
      }
    }
  }
  widget {
    widget_layout {
      x      = 111
      y      = 90
      width  = 38
      height = 15
    }
    timeseries_definition {
      title       = "Total Exceptions - by Class"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        on_right_yaxis = false
        style {
          palette    = "warm"
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
  template_variable {
    name    = "env"
    default = "*"
    prefix  = "env"
  }
  template_variable {
    name    = "service"
    default = "*"
    prefix  = "service"
  }
  template_variable {
    name    = "version"
    default = "*"
    prefix  = "version"
  }
  template_variable {
    name    = "host"
    default = "*"
    prefix  = "host"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}