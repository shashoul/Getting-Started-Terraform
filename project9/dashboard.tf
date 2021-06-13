resource "datadog_dashboard" "MongoDB_Atlas" {

  title       = "Shady Terraform Test... MongoDB Atlas - Overview"
  description = <<EOF
This dashboard provides an overview of the resource utilization, throughput, and performance of your MongoDB Atlas databases so you can identify and troubleshoot performance issues in one place. For further reading on monitoring MongoDB Atlas: 

- [How to monitor MongoDB Atlas with Datadog](https://www.datadoghq.com/blog/monitor-atlas-performance-metrics-with-datadog/)

- [Datadog's MongoDB Atlas integration docs](https://docs.datadoghq.com/integrations/mongodb_atlas/#overview). 

Clone this template dashboard to make changes and add your own graph widgets. 
EOF
  widget {
    widget_layout {
      x      = 153
      y      = 39
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Connections"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          palette    = "grey"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 153
      y      = 7
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Max memory usage"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.mem.resident{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.mem.virtual{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
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
      x      = 47
      y      = 23
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Document reads"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.metrics.document.returned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
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
      x      = 47
      y      = 47
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Query efficiency"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedobjectsperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.metrics.queryexecutor.scannedperreturned{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 47
      y      = 7
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Read requests (per second)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.opcounters.getmore{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.query{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          palette    = "green"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 47
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Operations latency"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, avg:mongodb.atlas.oplatencies.writes.avg{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
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
      x      = 118
      y      = 23
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "IOPS"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.system.disk.iops.reads{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          palette    = "green"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q = "avg:mongodb.atlas.system.disk.iops.writes{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
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
      x      = 0
      y      = 26
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "Disk space free"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.system.disk.space.free{$replica-set,$scope,$process-type,$process-state,$sharded-cluster,$project,$organization}"
        aggregator = "avg"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 23
      y      = 10
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "Process memory usage"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.mem.resident{$replica-set,$project,$sharded-cluster,$process-type,$process-state,$scope,$organization}"
        aggregator = "last"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 10
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "CPU usage (%)"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}+avg:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 80
        }
        conditional_formats {
          comparator = ">="
          palette    = "white_on_yellow"
          value      = 60
        }
        conditional_formats {
          comparator = "<"
          palette    = "white_on_green"
          value      = 60
        }
      }
      autoscale   = true
      custom_unit = "%"
      precision   = 0
    }
  }
  widget {
    widget_layout {
      x      = 23
      y      = 42
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "Connection count"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.connections.current{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "last"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 23
      y      = 26
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "IOPS"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.system.disk.iops.total{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_count()"
        aggregator = "last"
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 42
      width  = 22
      height = 15
    }
    query_value_definition {
      title       = "Read latency (avg)"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "avg:mongodb.atlas.oplatencies.reads.avg{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 500
        }
        conditional_formats {
          comparator = ">="
          palette    = "white_on_yellow"
          value      = 100
        }
        conditional_formats {
          comparator = "<"
          palette    = "white_on_green"
          value      = 100
        }
      }
      autoscale   = true
      custom_unit = "ms"
      precision   = 0
    }
  }
  widget {
    widget_layout {
      x      = 118
      y      = 39
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Data size"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.stats.totalstoragesize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.stats.totaldatasize{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 153
      y      = 23
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Disk space used"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.system.disk.space.free{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}, max:mongodb.atlas.system.disk.space.used{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 118
      y      = 7
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Max CPU usage (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "max:mongodb.atlas.system.cpu.norm.guest{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.iowait{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.irq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.kernel{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.nice{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.softirq{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.steal{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}, max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
      marker {
        value        = "y > 100"
        display_type = "error dashed"
      }
      marker {
        value        = "y > 60"
        display_type = "warning dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 118
      y      = 71
      width  = 34
      height = 15
    }
    toplist_definition {
      title       = "Top hosts by CPU usage"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.cpu.norm.user{$scope,$replica-set,$sharded-cluster,$process-state,$process-type,$project,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 80
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 60
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 60
        }
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 153
      y      = 55
      width  = 34
      height = 15
    }
    toplist_definition {
      title       = "Top hosts by disk space used"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(max:mongodb.atlas.system.disk.space.percentused{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization} by {hostnameport}, 10, 'mean', 'desc')"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 80
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 60
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 60
        }
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 0
      width  = 19
      height = 9
    }
    image_definition {
      url    = "/static/images/logos/mongodb-atlas_large.svg"
      sizing = "center"
    }
  }
  widget {
    widget_layout {
      x      = 20
      y      = 0
      width  = 25
      height = 9
    }
    note_definition {
      content          = "Health status"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 47
      y      = 0
      width  = 69
      height = 6
    }
    note_definition {
      content          = "Thoughput"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 7
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Write requests (per second)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.opcounters.delete{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), avg:mongodb.atlas.opcounters.insert{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate(), sum:mongodb.atlas.opcounters.update{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_rate()"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 118
      y      = 0
      width  = 69
      height = 6
    }
    note_definition {
      content          = "Resource utilization "
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 23
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Document writes"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.metrics.document.deleted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.inserted{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count(), sum:mongodb.atlas.metrics.document.updated{$scope,$replica-set,$project,$sharded-cluster,$process-state,$process-type,$organization}.as_count()"
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
      x      = 47
      y      = 39
      width  = 69
      height = 7
    }
    note_definition {
      content          = "Performance"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 47
      y      = 63
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Total cursors"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:mongodb.atlas.cursors.totalopen{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          palette    = "grey"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
    }
  }
  widget {
    widget_layout {
      x      = 82
      y      = 63
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "Replication headroom"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.replset.replicationheadroom{$scope,$organization,$project,$replica-set,$sharded-cluster,$process-state,$process-type}"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 118
      y      = 55
      width  = 34
      height = 15
    }
    timeseries_definition {
      title       = "IOPS usage (%)"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "avg:mongodb.atlas.system.disk.iops.percentutilization{$scope,$replica-set,$project,$sharded-cluster,$process-type,$process-state,$organization}.as_rate()"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
      marker {
        value        = "y > 100"
        display_type = "error dashed"
      }
      marker {
        value        = "y > 50"
        display_type = "warning dashed"
      }
    }
  }
  template_variable {
    name    = "scope"
    default = "*"
  }
  template_variable {
    name    = "organization"
    default = "*"
    prefix  = "organizationname"
  }
  template_variable {
    name    = "project"
    default = "*"
    prefix  = "projectname"
  }
  template_variable {
    name    = "replica-set"
    default = "*"
    prefix  = "replicasetname"
  }
  template_variable {
    name    = "sharded-cluster"
    default = "*"
    prefix  = "shardedclustername"
  }
  template_variable {
    name    = "process-state"
    default = "*"
    prefix  = "processstate"
  }
  template_variable {
    name    = "process-type"
    default = "*"
    prefix  = "processtype"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}