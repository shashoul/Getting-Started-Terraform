resource "datadog_dashboard" "mongodb_dashboard_test" {

  title       = "Shady Terraform Test ... Infrastructure Overview"
  description = ""
  widget {
    widget_layout {
      x      = 8
      y      = 7
      width  = 24
      height = 17
    }
    query_value_definition {
      title       = "Avg CPU Usage"
      title_size  = "16"
      title_align = "center"
      request {
        q          = "avg:mongodb.atlas.system.cpu.norm.guest{*}+avg:mongodb.atlas.system.cpu.norm.iowait{*}+avg:mongodb.atlas.system.cpu.norm.irq{*}+avg:mongodb.atlas.system.cpu.mongoprocess.norm.kernel{*}+avg:mongodb.atlas.system.cpu.norm.nice{*}+avg:mongodb.atlas.system.cpu.norm.softirq{*}+avg:mongodb.atlas.system.cpu.norm.steal{*}+avg:mongodb.atlas.system.cpu.norm.user{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = "<"
          palette    = "white_on_green"
          value      = 7
        }
        conditional_formats {
          comparator = "<"
          palette    = "white_on_yellow"
          value      = 8
        }
        conditional_formats {
          comparator = ">="
          palette    = "white_on_red"
          value      = 8
        }
      }
      autoscale   = true
      custom_unit = "%"
      precision   = 2
    }
  }
  widget {
    widget_layout {
      x      = 32
      y      = 7
      width  = 24
      height = 17
    }
    query_value_definition {
      title       = "AVG Free Disk Space"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.system.disk.space.free{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 98500000000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 97000000000
        }
        conditional_formats {
          comparator = "<"
          palette    = "white_on_green"
          value      = 97000000000
        }
      }
      autoscale = true
      precision = 2
    }
  }
  widget {
    widget_layout {
      x      = 100
      y      = 7
      width  = 64
      height = 52
    }
    trace_service_definition {
      title              = "Mongo - Service Summary"
      title_size         = "16"
      title_align        = "left"
      env                = "development"
      service            = "mongo"
      span_name          = "mongo.query"
      show_hits          = true
      show_errors        = true
      show_latency       = true
      show_breakdown     = true
      show_distribution  = true
      show_resource_list = false
      size_format        = "medium"
      display_format     = "one_column"
    }
  }
  widget {
    widget_layout {
      x      = 56
      y      = 41
      width  = 44
      height = 18
    }
    query_value_definition {
      title       = "Avg Total Disk IOPS"
      title_size  = "16"
      title_align = "center"
      request {
        q          = "avg:mongodb.atlas.system.disk.iops.total{*}.as_count()"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 30000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 28000
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 25000
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 56
      y      = 24
      width  = 21
      height = 17
    }
    timeseries_definition {
      title       = "Document Reads /s"
      title_size  = "16"
      title_align = "center"
      show_legend = false
      request {
        q              = "avg:mongodb.atlas.metrics.document.returned{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        value        = "y = 100"
        display_type = "error bold"
      }
      marker {
        value        = "y = 98"
        display_type = "warning dashed"
      }
      marker {
        value        = "y = 95"
        display_type = "ok dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 77
      y      = 24
      width  = 23
      height = 17
    }
    timeseries_definition {
      title       = "Document Writes /s"
      title_size  = "16"
      title_align = "center"
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.metrics.document.deleted{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
      request {
        q              = "sum:mongodb.atlas.metrics.document.inserted{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
      request {
        q              = "sum:mongodb.atlas.metrics.document.updated{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
      yaxis {
        scale        = "linear"
        label        = ""
        include_zero = true
        min          = "auto"
        max          = "auto"
      }
      marker {
        value        = "y = 4"
        display_type = "error bold"
      }
      marker {
        value        = "y = 3.8"
        display_type = "warning dashed"
      }
      marker {
        value        = "y = 3.6"
        display_type = "ok dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 32
      y      = 24
      width  = 24
      height = 17
    }
    timeseries_definition {
      title       = "Query Efficiency"
      title_size  = "16"
      title_align = "center"
      show_legend = false
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{*}"
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
      x      = 56
      y      = 7
      width  = 44
      height = 17
    }
    timeseries_definition {
      title       = "Memory Usage"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "max:mongodb.atlas.mem.resident{*}"
        on_right_yaxis = false
        metadata {
          expression = "max:mongodb.atlas.mem.resident{*}"
          alias_name = "Resident"
        }
        style {
          palette    = "purple"
          line_type  = "dashed"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q              = "max:mongodb.atlas.mem.virtual{*}"
        on_right_yaxis = false
        metadata {
          expression = "max:mongodb.atlas.mem.virtual{*}"
          alias_name = "Virtual"
        }
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
      x      = 8
      y      = 24
      width  = 24
      height = 17
    }
    query_value_definition {
      title       = "Current Connections"
      title_size  = "16"
      title_align = "center"
      request {
        q          = "avg:mongodb.atlas.connections.current{*}"
        aggregator = "last"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 8
      y      = 68
      width  = 28
      height = 18
    }
    toplist_definition {
      title       = "Container CPU Usage"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(avg:kubernetes.cpu.usage.total{*} by {kube_container_name}, 10, 'mean', 'desc')"
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 630000000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 650000000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 680000000
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 135
      y      = 68
      width  = 29
      height = 18
    }
    toplist_definition {
      title       = "Pods CPU Usage"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(avg:kubernetes.cpu.usage.total{*} by {pod_name}, 10, 'mean', 'desc')"
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 1790000000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 1880000000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 2000000000
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 62
      y      = 68
      width  = 47
      height = 18
    }
    query_value_definition {
      title       = "Nodes CPU Total Usage"
      title_size  = "16"
      title_align = "center"
      request {
        q          = "avg:kubernetes.cpu.usage.total{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 30000000
        }
        conditional_formats {
          comparator = ">="
          palette    = "white_on_yellow"
          value      = 25000000
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 20000000
        }
      }
      autoscale = true
      precision = 2
    }
  }
  widget {
    widget_layout {
      x      = 74
      y      = 0
      width  = 24
      height = 6
    }
    free_text_definition {
      text       = "Mongo DB "
      color      = "#4d4d4d"
      font_size  = "auto"
      text_align = "left"
    }
  }
  widget {
    widget_layout {
      x      = 71
      y      = 60
      width  = 24
      height = 6
    }
    free_text_definition {
      text       = "Kubernetes"
      color      = "#4d4d4d"
      font_size  = "auto"
      text_align = "left"
    }
  }
  widget {
    widget_layout {
      x      = 32
      y      = 41
      width  = 24
      height = 18
    }
    timeseries_definition {
      title       = "Read requests (per second)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.opcounters.getmore{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
      request {
        q              = "sum:mongodb.atlas.opcounters.query{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
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
      x      = 8
      y      = 41
      width  = 24
      height = 18
    }
    timeseries_definition {
      title       = "Write requests (per second)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:mongodb.atlas.opcounters.delete{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "grey"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
      request {
        q              = "avg:mongodb.atlas.opcounters.insert{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
      request {
        q              = "sum:mongodb.atlas.opcounters.update{*}.as_rate()"
        on_right_yaxis = false
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
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
      x      = 36
      y      = 68
      width  = 26
      height = 18
    }
    query_value_definition {
      title       = "Running Containers"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:docker.containers.running{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "green_on_white"
          value      = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 109
      y      = 68
      width  = 26
      height = 18
    }
    query_value_definition {
      title       = "Stopped Containers"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:docker.containers.stopped{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "yellow_on_white"
          value      = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 62
      y      = 101
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Network in per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:kubernetes.network.rx_bytes{*} by {host}"
        on_right_yaxis = false
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
      x      = 109
      y      = 86
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Network out per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:kubernetes.network.tx_bytes{*} by {host}"
        on_right_yaxis = false
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
      x      = 62
      y      = 86
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Network errors per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:kubernetes.network.rx_errors{*} by {host}"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q              = "sum:kubernetes.network.tx_errors{*} by {host}"
        on_right_yaxis = false
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q              = "sum:kubernetes.network_errors{*} by {host}"
        on_right_yaxis = false
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
      x      = 109
      y      = 101
      width  = 47
      height = 15
    }
    timeseries_definition {
      title       = "Disk reads per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "sum:kubernetes.io.read_bytes{*} by {replicaset,host}, avg:kubernetes_state.replicaset.replicas_ready{*} by {replicaset,host}, sum:kubernetes.io.read_bytes{*} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{*} by {replicaset,host}"
        on_right_yaxis = false
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
      x      = 77
      y      = 117
      width  = 24
      height = 6
    }
    free_text_definition {
      text       = "AWS"
      color      = "#4d4d4d"
      font_size  = "auto"
      text_align = "left"
    }
  }
  widget {
    widget_layout {
      x      = 15
      y      = 86
      width  = 47
      height = 9
    }
    event_timeline_definition {
      title          = "Number of Kubernetes events"
      title_size     = "20"
      title_align    = "center"
      query          = "sources:kubernetes *"
      tags_execution = "and"
    }
  }
  widget {
    widget_layout {
      x      = 15
      y      = 97
      width  = 47
      height = 21
    }
    event_stream_definition {
      title_size     = "16"
      title_align    = "left"
      query          = "sources:kubernetes *"
      tags_execution = "and"
      event_size     = "s"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 133
      width  = 25
      height = 12
    }
    query_value_definition {
      title       = "CPU Utilization"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:aws.ec2.cpuutilization{*}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "red_on_white"
          value      = 50
        }
        conditional_formats {
          comparator = "<="
          palette    = "green_on_white"
          value      = 50
        }
      }
      autoscale = true
      precision = 2
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 125
      width  = 50
      height = 8
    }
    note_definition {
      content          = <<EOF


EC2
EOF
      background_color = "white"
      font_size        = "36"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 25
      y      = 133
      width  = 25
      height = 12
    }
    query_value_definition {
      title       = "Active Instances"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.ec2.host_ok{*}"
        aggregator = "avg"
      }
      autoscale = true
      precision = 2
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 145
      width  = 50
      height = 15
    }
    heatmap_definition {
      title       = "EC2 CPU utilization per instance (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ec2.cpuutilization{*} by {host}"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 51
      y      = 125
      width  = 51
      height = 8
    }
    note_definition {
      content          = <<EOF


EBS
EOF
      background_color = "white"
      font_size        = "36"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 51
      y      = 133
      width  = 17
      height = 12
    }
    query_value_definition {
      title       = "Avg Q lengh"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:aws.ebs.volume_queue_length{*}"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 68
      y      = 133
      width  = 17
      height = 12
    }
    query_value_definition {
      title       = "EBS volumes (sum/avg)"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.ebs.volume_read_ops{*}/avg:aws.ebs.volume_read_ops{*}"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 85
      y      = 133
      width  = 17
      height = 12
    }
    query_value_definition {
      title       = "EBS volumes (Read & Writes)"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.ebs.volume_read_ops{*}+sum:aws.ebs.volume_write_ops{*}"
        aggregator = "max"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 51
      y      = 145
      width  = 51
      height = 15
    }
    heatmap_definition {
      title       = "EBS IOps by volume"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ebs.volume_read_ops{*} by {host,device}.as_count(), avg:aws.ebs.volume_write_ops{*} by {host,device}.as_count(), avg:aws.ebs.volume_read_ops{*} by {host,device}.as_count()+avg:aws.ebs.volume_write_ops{*} by {host,device}.as_count()"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 51
      y      = 160
      width  = 51
      height = 15
    }
    heatmap_definition {
      title       = "EBS queue length by volume"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q = "avg:aws.ebs.volume_queue_length{*} by {host,device}"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 103
      y      = 125
      width  = 40
      height = 8
    }
    note_definition {
      content          = <<EOF


S3

EOF
      background_color = "white"
      font_size        = "36"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 103
      y      = 133
      width  = 40
      height = 14
    }
    timeseries_definition {
      title       = "S3 buckets size, past week"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      request {
        q = "max:aws.s3.bucket_size_bytes{*} by {bucketname}"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
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
      x      = 103
      y      = 148
      width  = 40
      height = 14
    }
    timeseries_definition {
      title       = "S3 buckets number of objects, past week"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      live_span   = "1w"
      request {
        q = "max:aws.s3.number_of_objects{*} by {bucketname}"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
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
      y      = 161
      width  = 50
      height = 8
    }
    note_definition {
      content          = <<EOF


Cloudfront
EOF
      background_color = "white"
      font_size        = "36"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 33
      y      = 169
      width  = 17
      height = 12
    }
    query_value_definition {
      title       = "Requests Count"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.cloudfront.requests{*}.as_count()"
        aggregator = "avg"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 16
      y      = 169
      width  = 17
      height = 12
    }
    query_value_definition {
      title       = "Uploaded Bytes"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.cloudfront.bytes_uploaded{*}.as_count()"
        aggregator = "avg"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 169
      width  = 16
      height = 12
    }
    query_value_definition {
      title       = "Downloaded Bytes"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.cloudfront.bytes_downloaded{*}.as_count()"
        aggregator = "avg"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 180
      width  = 50
      height = 15
    }
    timeseries_definition {
      title       = "Error Rates"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q              = "avg:aws.cloudfront.total_error_rate{*}"
        on_right_yaxis = false
        metadata {
          expression = "avg:aws.cloudfront.total_error_rate{*}"
          alias_name = "Total"
        }
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q              = "avg:aws.cloudfront.4xx_error_rate{*}"
        on_right_yaxis = false
        metadata {
          expression = "avg:aws.cloudfront.4xx_error_rate{*}"
          alias_name = "4xx"
        }
        style {
          palette    = "orange"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q              = "avg:aws.cloudfront.5xx_error_rate{*}"
        on_right_yaxis = false
        metadata {
          expression = "avg:aws.cloudfront.5xx_error_rate{*}"
          alias_name = "5xx"
        }
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
      x      = 144
      y      = 140
      width  = 32
      height = 46
    }
    event_stream_definition {
      title          = "AWS events (Last Week)"
      title_size     = "13"
      title_align    = "left"
      live_span      = "1w"
      query          = "sources:aws"
      tags_execution = "and"
      event_size     = "s"
    }
  }
  widget {
    widget_layout {
      x      = 144
      y      = 125
      width  = 32
      height = 15
    }
    image_definition {
      url    = "/static/images/screenboard/integrations/aws.png"
      sizing = "fit"
      margin = "large"
    }
  }
  layout_type  = "free"
  is_read_only = false
  notify_list  = []
}