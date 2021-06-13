resource "datadog_dashboard" "k8s_overview_dashboard" {

  title       = "Shady Terraform Test !!! Kubernetes - Overview (cloned)"
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
  widget {
    widget_layout {
      x      = 151
      y      = 57
      width  = 43
      height = 24
    }
    toplist_definition {
      title       = "Most memory-intensive pods"
      title_size  = "16"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(sum:kubernetes.memory.usage{$scope,$deployment,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')"
        style {
          palette = "cool"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 57
      width  = 43
      height = 24
    }
    toplist_definition {
      title       = "Most CPU-intensive pods"
      title_size  = "16"
      title_align = "left"
      live_span   = "4h"
      request {
        q = "top(sum:kubernetes.cpu.usage.total{$scope,$deployment,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')"
        style {
          palette = "warm"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 0
      width  = 23
      height = 15
    }
    image_definition {
      url    = "/static/images/screenboard/integrations/kubernetes.jpg"
      sizing = "zoom"
    }
  }
  widget {
    widget_layout {
      x      = 80
      y      = 0
      width  = 13
      height = 7
    }
    check_status_definition {
      title       = "Kubelets up"
      title_size  = "16"
      title_align = "center"
      live_span   = "10m"
      check       = "kubernetes.kubelet.check"
      grouping    = "cluster"
      group_by    = []
      tags        = ["$scope", "$node", "$label", ]
    }
  }
  widget {
    widget_layout {
      x      = 50
      y      = 91
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Pods Available"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
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
      x      = 67
      y      = 91
      width  = 37
      height = 14
    }
    timeseries_definition {
      title       = "Pods available"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$daemonset,$service,$label,$cluster,$namespace,$node} by {deployment}"
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
      x      = 50
      y      = 76
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Pods desired"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "avg"
        conditional_formats {
          custom_fg_color = "#6a53a1"
          comparator      = ">"
          palette         = "custom_text"
          value           = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 67
      y      = 76
      width  = 37
      height = 14
    }
    timeseries_definition {
      title       = "Pods desired"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node} by {deployment}"
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
      x      = 50
      y      = 106
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Pods unavailable"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "avg"
        conditional_formats {
          comparator = ">"
          palette    = "yellow_on_white"
          value      = 0
        }
        conditional_formats {
          comparator = "<="
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
      x      = 67
      y      = 106
      width  = 37
      height = 14
    }
    timeseries_definition {
      title       = "Pods unavailable"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$daemonset,$service,$label,$cluster,$namespace,$node} by {deployment}"
        style {
          palette    = "orange"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 37
      y      = 16
      width  = 67
      height = 5
    }
    note_definition {
      content          = "Pods"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 16
      width  = 87
      height = 5
    }
    note_definition {
      content          = "[Resource utilization](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-resource-utilization6)"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 34
      width  = 36
      height = 37
    }
    event_stream_definition {
      live_span      = "1w"
      query          = "sources:kubernetes $node"
      tags_execution = "and"
      event_size     = "s"
    }
  }
  widget {
    widget_layout {
      x      = 37
      y      = 38
      width  = 33
      height = 15
    }
    timeseries_definition {
      title       = "Running pods per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      request {
        q = "sum:kubernetes.pods.running{$scope,$deployment,$daemonset,$label,$cluster,$namespace,$service,$node} by {host}"
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
      x      = 151
      y      = 22
      width  = 43
      height = 18
    }
    hostmap_definition {
      title       = "Memory usage per node"
      title_size  = "16"
      title_align = "left"
      request {
        fill {
          q = "sum:kubernetes.memory.usage{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        }
      }
      no_metric_hosts = false
      no_group_hosts  = true
      scope           = ["$scope", "$node", "$label", "$kube_deployment", "$kube_namespace", ]
      style {
        palette      = "hostmap_blues"
        palette_flip = false
      }
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 121
      width  = 43
      height = 16
    }
    timeseries_definition {
      title       = "Network errors per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
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
      x      = 107
      y      = 41
      width  = 43
      height = 15
    }
    timeseries_definition {
      title       = "Sum Kubernetes CPU requests per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.cpu.requests{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "warm"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 151
      y      = 41
      width  = 43
      height = 15
    }
    timeseries_definition {
      title       = "Sum Kubernetes memory requests per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.memory.requests{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "cool"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 82
      width  = 87
      height = 5
    }
    note_definition {
      content          = "Disk I/O & Network"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 88
      width  = 43
      height = 16
    }
    timeseries_definition {
      title       = "Network in per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.network.rx_bytes{$scope,$deployment,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}"
        style {
          palette = "purple"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 105
      width  = 43
      height = 15
    }
    timeseries_definition {
      title       = "Network out per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.network.tx_bytes{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        style {
          palette = "green"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 16
      width  = 36
      height = 5
    }
    note_definition {
      content          = "[Events](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-correlate-with-events10)"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 22
      width  = 36
      height = 9
    }
    event_timeline_definition {
      title          = "Number of Kubernetes events per node"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1d"
      query          = "sources:kubernetes $node"
      tags_execution = "and"
    }
  }
  widget {
    widget_layout {
      x      = 107
      y      = 22
      width  = 43
      height = 18
    }
    hostmap_definition {
      title       = "CPU utilization per node"
      title_size  = "16"
      title_align = "left"
      request {
        fill {
          q = "sum:kubernetes.cpu.usage.total{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
        }
      }
      no_metric_hosts = false
      no_group_hosts  = true
      scope           = ["$scope", "$node", "$label", "$kube_deployment", "$kube_namespace", ]
      style {
        palette      = "YlOrRd"
        palette_flip = false
      }
    }
  }
  widget {
    widget_layout {
      x      = 95
      y      = 0
      width  = 16
      height = 15
    }
    note_definition {
      content          = <<EOF
Read our
[Monitoring guide for Kubernetes](https://www.datadoghq.com/blog/monitoring-kubernetes-era/).
 
Check [the agent documentation](https://docs.datadoghq.com/agent/kubernetes/) if some of the graphs are empty.
EOF
      background_color = "yellow"
      font_size        = "14"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 76
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Desired"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.daemonset.desired{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
        conditional_formats {
          custom_fg_color = "#6a53a1"
          comparator      = ">"
          palette         = "custom_text"
          value           = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 76
      width  = 32
      height = 14
    }
    timeseries_definition {
      title       = "Pods desired"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.daemonset.desired{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node} by {daemonset}"
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
      x      = 0
      y      = 91
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Ready"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.daemonset.ready{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
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
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 80
      y      = 8
      width  = 13
      height = 7
    }
    check_status_definition {
      title       = "Kubelet Ping"
      title_size  = "16"
      title_align = "center"
      live_span   = "10m"
      check       = "kubernetes.kubelet.check.ping"
      grouping    = "cluster"
      group_by    = []
      tags        = ["*", "$node", "$label", "$scope", ]
    }
  }
  widget {
    widget_layout {
      x      = 50
      y      = 127
      width  = 54
      height = 14
    }
    timeseries_definition {
      title       = "Container states"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.container.running{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.waiting{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.terminated{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
        style {
          palette    = "grey"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
      request {
        q = "sum:kubernetes_state.container.ready{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node}"
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
      x      = 17
      y      = 112
      width  = 32
      height = 14
    }
    timeseries_definition {
      title       = "Ready"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "1h"
      request {
        q = "sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}"
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
      x      = 17
      y      = 127
      width  = 32
      height = 14
    }
    timeseries_definition {
      title       = "Not ready"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "1h"
      request {
        q = "sum:kubernetes_state.replicaset.replicas_desired{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node} by {replicaset}"
        style {
          palette    = "orange"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "area"
      }
    }
  }
  widget {
    widget_layout {
      x      = 151
      y      = 105
      width  = 43
      height = 15
    }
    timeseries_definition {
      title       = "Disk reads per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.io.read_bytes{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {host}"
        style {
          palette    = "grey"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "line"
      }
    }
  }
  widget {
    widget_layout {
      x      = 151
      y      = 88
      width  = 43
      height = 16
    }
    timeseries_definition {
      title       = "Disk writes per node"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.io.write_bytes{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {replicaset,host}-avg:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$label,$cluster,$deployment,$node} by {host}"
        style {
          palette    = "grey"
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
      y      = 70
      width  = 49
      height = 5
    }
    note_definition {
      content          = "DaemonSets"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 50
      y      = 70
      width  = 54
      height = 5
    }
    note_definition {
      content          = "Deployments"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 106
      width  = 49
      height = 5
    }
    note_definition {
      content          = "ReplicaSets"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 50
      y      = 121
      width  = 54
      height = 5
    }
    note_definition {
      content          = "Containers"
      background_color = "gray"
      font_size        = "18"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 112
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Ready"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.replicaset.replicas_ready{$scope,$deployment,$daemonset,$cluster,$label,$namespace,$service,$node}"
        aggregator = "last"
        conditional_formats {
          custom_fg_color = "#6a53a1"
          comparator      = ">"
          palette         = "custom_text"
          value           = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 0
      y      = 127
      width  = 16
      height = 14
    }
    query_value_definition {
      title       = "Not ready"
      title_size  = "16"
      title_align = "left"
      live_span   = "5m"
      request {
        q          = "sum:kubernetes_state.replicaset.replicas_desired{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$daemonset,$service,$namespace,$deployment,$label,$cluster,$node}"
        aggregator = "last"
        conditional_formats {
          custom_fg_color = "#6a53a1"
          comparator      = ">"
          palette         = "yellow_on_white"
          value           = 0
        }
      }
      autoscale = true
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 17
      y      = 91
      width  = 32
      height = 14
    }
    timeseries_definition {
      title       = "Pods ready"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes_state.daemonset.ready{$scope,$deployment,$daemonset,$service,$namespace,$label,$cluster,$node} by {daemonset}"
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
      x      = 37
      y      = 22
      width  = 33
      height = 15
    }
    timeseries_definition {
      title       = "Running pods per namespace"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:kubernetes.pods.running{$scope,$cluster,$namespace,$deployment,$daemonset,$label,$node,$service} by {cluster_name,kube_namespace}"
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
      custom_link {
        link  = "https://www.google.com?search={{kube_namespace.value}}"
        label = "Search Namespace on Google"
      }
    }
  }
  widget {
    widget_layout {
      x      = 37
      y      = 54
      width  = 33
      height = 15
    }
    toplist_definition {
      title       = "Pods in bad phase by namespaces"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(sum:kubernetes_state.pod.status_phase{$scope,$cluster,$namespace,$deployment,$daemonset,!phase:running,!phase:succeeded,$label,$node,$service} by {cluster_name,kube_namespace,phase}, 100, 'last', 'desc')"
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
    }
  }
  widget {
    widget_layout {
      x      = 71
      y      = 54
      width  = 33
      height = 15
    }
    timeseries_definition {
      title       = "CrashloopBackOff by Pod"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      request {
        q = "sum:kubernetes_state.container.waiting{$cluster,$namespace,$deployment,reason:crashloopbackoff,$scope,$daemonset,$label,$node,$service} by {pod_name}"
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
        label        = "y = 0"
        value        = "y = 0"
        display_type = "ok dashed"
      }
    }
  }
  widget {
    widget_layout {
      x      = 71
      y      = 22
      width  = 33
      height = 15
    }
    toplist_definition {
      title       = "Pods running by namespace"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(sum:kubernetes.pods.running{$scope,$namespace,$deployment,$cluster,$daemonset,$label,$node,$service} by {cluster_name,kube_namespace}, 100, 'max', 'desc')"
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 2000
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 1500
        }
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 3000
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 71
      y      = 38
      width  = 33
      height = 15
    }
    toplist_definition {
      title       = "Pods in ready state by node"
      title_size  = "16"
      title_align = "left"
      request {
        q = "top(sum:kubernetes_state.pod.ready{$scope,$cluster,$namespace,$deployment,condition:true,$daemonset,$label,$node,$service} by {kubernetes_cluster,host,nodepool}, 10, 'last', 'desc')"
        conditional_formats {
          comparator = "<="
          palette    = "white_on_green"
          value      = 24
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_red"
          value      = 32
        }
        conditional_formats {
          comparator = ">"
          palette    = "white_on_yellow"
          value      = 24
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 24
      y      = 0
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Clusters"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name})"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 38
      y      = 0
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Namespaces"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace})"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 52
      y      = 8
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Deployments"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "count_nonzero(avg:kubernetes_state.deployment.replicas{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace,kube_deployment})"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 52
      y      = 0
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Services"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:kubernetes_state.service.count{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 38
      y      = 8
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "DaemonSets"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "count_nonzero(avg:kubernetes_state.daemonset.desired{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster} by {cluster_name,kube_namespace,kube_daemon_set})"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 24
      y      = 8
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Nodes"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:kubernetes_state.node.count{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 66
      y      = 0
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Pods"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:kubernetes.pods.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
      custom_link {
        link  = "https://app.datadoghq.com/screen/integration/30322/kubernetes-pods-overview"
        label = "View Pods overview"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 66
      y      = 8
      width  = 13
      height = 7
    }
    query_value_definition {
      title       = "Containers"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:kubernetes.containers.running{$scope,$label,$node,$service,$daemonset,$deployment,$namespace,$cluster}"
        aggregator = "avg"
      }
      precision = 0
    }
  }
  widget {
    widget_layout {
      x      = 151
      y      = 121
      width  = 43
      height = 16
    }
    timeseries_definition {
      title       = "Network errors per pod"
      title_size  = "16"
      title_align = "left"
      show_legend = false
      legend_size = "0"
      live_span   = "4h"
      request {
        q = "sum:kubernetes.network.rx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}"
        style {
          palette    = "warm"
          line_type  = "solid"
          line_width = "normal"
        }
        display_type = "bars"
      }
      request {
        q = "sum:kubernetes.network.tx_errors{$scope,$deployment,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}"
        style {
          palette    = "warm"
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
    }
  }
  template_variable {
    name    = "scope"
    default = "*"
  }
  template_variable {
    name    = "cluster"
    default = "*"
    prefix  = "cluster_name"
  }
  template_variable {
    name    = "namespace"
    default = "*"
    prefix  = "kube_namespace"
  }
  template_variable {
    name    = "deployment"
    default = "*"
    prefix  = "kube_deployment"
  }
  template_variable {
    name    = "daemonset"
    default = "*"
    prefix  = "kube_daemon_set"
  }
  template_variable {
    name    = "service"
    default = "*"
    prefix  = "kube_service"
  }
  template_variable {
    name    = "node"
    default = "*"
    prefix  = "node"
  }
  template_variable {
    name    = "label"
    default = "*"
    prefix  = "label"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}