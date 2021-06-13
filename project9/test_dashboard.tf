resource "datadog_dashboard" "test_dashboard" {

  title       = "Load Test"
  description = ""
  widget {
    group_definition {
      title       = "Transmit Application"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "System CPU Utilization in % - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:system.cpu.user{$host,$region}+avg:system.cpu.system{$host,$region}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "EC2 CPU Utilization in % - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.cpuutilization{$host,$region} by {name}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "CPU Credit Balance - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.cpucredit_balance{$host,$region} by {name}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "AWS EC2 EBS disk read iops - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.ebsread_ops{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "AWS EC2 EBS disk write iops - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.ebswrite_ops{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "Free Memory in % - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "(avg:system.mem.free{$host,$region}/avg:system.mem.total{$host,$region})*100"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "AWS EC2 Network Bytes In - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.network_in{$host,$region}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "JVM CPU Load - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:jvm.cpu_load.process{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "AWS EC2 Network Bytes Out - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.network_out{$host,$region}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "JVM GC Metrics - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:jvm.gc.major_collection_time{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "avg:jvm.gc.minor_collection_time{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          request {
            q = "avg:jvm.gc.major_collection_count{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "avg:jvm.gc.minor_collection_count{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "JVM Heap Memory - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:jvm.heap_memory{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "System load - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:system.load.1{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "avg:system.load.5{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "avg:system.load.15{$host}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "System I/O wait - host"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:system.cpu.iowait{$host,$region}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        hostmap_definition {
          title = "AWS EC2 Host Health"
          request {
            fill {
              q = "avg:aws.ec2.host_ok{environment:development} by {host}"
            }
          }
          node_type       = "host"
          no_metric_hosts = true
          no_group_hosts  = true
          group           = ["availability-zone", ]
          scope           = ["environment:development", ]
          style {
            palette      = "green_to_orange"
            palette_flip = false
          }
        }
      }
    }
  }
  widget {
    group_definition {
      title       = "Load Balancer"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "ALB Response Time (in milliseconds) - loadbalancer"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.applicationelb.target_response_time.average{$loadbalancer}*1000"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "ALB HTTP 4xx & 5xx Responses - loadbalancer"
          show_legend = false
          legend_size = "0"
          request {
            q = "sum:aws.applicationelb.httpcode_target_4xx{*} by {host}.as_count()"
            style {
              palette    = "warm"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "sum:aws.applicationelb.httpcode_target_5xx{*} by {host}.as_count()"
            style {
              palette    = "warm"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "ALB - 3XX, 4XX and 5XX"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.applicationelb.httpcode_elb_3xx{$loadbalancer}.as_count(), avg:aws.applicationelb.httpcode_elb_4xx{$loadbalancer}.as_count(), avg:aws.applicationelb.httpcode_elb_5xx{$loadbalancer}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "bars"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
    }
  }
  widget {
    group_definition {
      title       = "Mongo"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "MongoDB number of connections - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.connections.current{$mongo} by {hostnameport}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "MongoDB Opcounter - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.opcounters.getmore{$mongo}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "avg:mongodb.atlas.opcounters.command{$mongo}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "MongoDB free disk space in % - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.system.disk.space.percentfree{$mongo}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "MongoDB Connections number - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.connections.current{*} by {hostnameport}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        query_value_definition {
          title = "MongoDB number of connections - mongo"
          request {
            q          = "avg:mongodb.atlas.connections.current{$mongo} by {host}"
            aggregator = "avg"
          }
          autoscale = true
          precision = 2
        }
      }
      widget {
        timeseries_definition {
          title       = "MongoDB Write IOPS - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.system.disk.iops.writes{$mongo} by {hostnameport}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "MongoDB Read IOPS - mongo"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:mongodb.atlas.system.disk.iops.reads{$mongo} by {hostnameport}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
    }
  }
  widget {
    group_definition {
      title       = "Client"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "AWS EC2 Network Bytes Out - client"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.network_out{$client}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "AWS EC2 Network Bytes In - client"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.network_in{$client}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "CPU Utilization - client"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:aws.ec2.cpuutilization.maximum{$client}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
    }
  }
  widget {
    group_definition {
      title       = "APM"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "APM - Hit/error count on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "sum:trace.akka_http.request.hits{$environment}.as_count()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          request {
            q = "sum:trace.akka_http.request.errors{$environment}.as_count()"
            style {
              palette    = "warm"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - Latency on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "p50:trace.akka_http.request{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "p75:trace.akka_http.request{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "p90:trace.akka_http.request{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "p95:trace.akka_http.request{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "p99:trace.akka_http.request{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          request {
            q = "max:trace.akka_http.request{$environment}.rollup(max)"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "line"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - Total Time Spent by service on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "sum:trace.akka_http.request.duration.by_service{$environment} by {sublayer_service}.rollup(sum).fill(zero)"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - Apdex on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:trace.akka_http.request.apdex.by.service{$environment}"
            style {
              palette    = "cool"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - Hit/error rate on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "sum:trace.akka_http.request.hits{$environment}.as_rate()"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          request {
            q = "sum:trace.akka_http.request.errors{$environment}.as_rate()"
            style {
              palette    = "warm"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - Error ratio on service unnamed-java-app in env none"
          show_legend = false
          legend_size = "0"
          request {
            q = "100*sum:trace.akka_http.request.errors{$environment} by {http.status_code}.as_rate().rollup(sum, 60)/sum:trace.akka_http.request.hits{$environment}.as_rate().rollup(sum, 60)"
            style {
              palette    = "warm"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
      widget {
        timeseries_definition {
          title       = "APM - HTTP request duration"
          show_legend = false
          legend_size = "0"
          request {
            q = "avg:trace.akka_http.request.duration{$environment}"
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "normal"
            }
            display_type = "area"
          }
          event {
            q              = "'load-test-execution build'"
            tags_execution = "and"
          }
        }
      }
    }
  }
  template_variable {
    name    = "host"
    default = "*"
    prefix  = "name"
  }
  template_variable {
    name    = "region"
    default = "*"
    prefix  = "region"
  }
  template_variable {
    name    = "mongo"
    default = "*"
    prefix  = "hostnameport"
  }
  template_variable {
    name    = "client"
    default = "*"
    prefix  = "name"
  }
  template_variable {
    name    = "loadbalancer"
    default = "*"
    prefix  = "loadbalancer"
  }
  template_variable {
    name    = "environment"
    default = "*"
    prefix  = "environment"
  }
  layout_type  = "ordered"
  is_read_only = false
  notify_list  = []
}