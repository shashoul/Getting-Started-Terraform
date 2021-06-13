resource "datadog_dashboard" "rum_mobile_dashboard" {

  title       = "Shady Terraform Test !!! RUM - Mobile"
  description = "Overview for all your RUM mobile applications."
  widget {
    query_value_definition {
      title = "Sessions"
      request {
        aggregator = "avg"
        rum_query {
          index        = "*"
          search_query = "@type:session $source $country $version $env $service $applicationId $OS $pathGroup $device"
          compute_query {
            aggregation = "count"
          }
        }
      }
      autoscale = true
      precision = 2
    }
    widget_layout {
      x      = 0
      y      = 0
      width  = 2
      height = 1
    }
  }
  widget {
    timeseries_definition {
      title       = "Screen views by device"
      show_legend = false
      legend_size = "0"
      request {
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "@device.type"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 10
          }
          compute_query {
            aggregation = "count"
          }
        }
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
    widget_layout {
      x      = 2
      y      = 0
      width  = 10
      height = 2
    }
  }
  widget {
    query_value_definition {
      title = "Screen views"
      request {
        aggregator = "avg"
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          compute_query {
            aggregation = "count"
          }
        }
      }
      autoscale = true
      precision = 2
    }
    widget_layout {
      x      = 0
      y      = 1
      width  = 2
      height = 1
    }
  }
  widget {
    toplist_definition {
      title = "🌍 Screen views by country"
      request {
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "@geo.country"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 10
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      x      = 0
      y      = 2
      width  = 3
      height = 3
    }
  }
  widget {
    toplist_definition {
      title = "📱Screen views by device"
      request {
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "@device.type"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 5
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      x      = 3
      y      = 2
      width  = 3
      height = 3
    }
  }
  widget {
    toplist_definition {
      title = "📲Screen views by app version"
      request {
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "version"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 10
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      x      = 6
      y      = 2
      width  = 3
      height = 3
    }
  }
  widget {
    toplist_definition {
      title = "⚙️Screen views by OS version"
      request {
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "@os.version"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 5
          }
          compute_query {
            aggregation = "count"
          }
        }
      }
    }
    widget_layout {
      x      = 9
      y      = 2
      width  = 3
      height = 3
    }
  }
  widget {
    query_table_definition {
      title = "Summary for most visited screens"
      request {
        conditional_formats {
          metric     = "avg:@view.error.count"
          comparator = ">"
          palette    = "yellow_on_white"
          value      = 1
        }
        rum_query {
          index        = "*"
          search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
          group_by {
            facet = "@view.url_path_group"
            sort_query {
              aggregation = "count"
              order       = "desc"
            }
            limit = 50
          }
        }
      }
      custom_link {
        link  = "/dash/integration/rum_resources?tpl_var_pathGroup={{@view.url_details.path_group.value}}"
        label = "View resources for {{@view.url_details.path_group.value}}"
      }
    }
    widget_layout {
      x      = 0
      y      = 5
      width  = 12
      height = 4
    }
  }
  widget {
    note_definition {
      content          = "**Tip**: Click on any **path group** in the widget above for more search options: **'Set `$pathGroup`'** will filter all the data on this dashboard, while **'View resources'** will go to the [RUM resources dashboard](/dash/integration/rum_resources)."
      background_color = "yellow"
      font_size        = "14"
      text_align       = "center"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "left"
    }
    widget_layout {
      x      = 0
      y      = 9
      width  = 12
      height = 1
    }
  }
  widget {
    group_definition {
      title       = "Errors and crashes"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title       = "Proportion of screens with errors"
          show_legend = false
          legend_size = "0"
          request {
            rum_query {
              index        = "*"
              search_query = "@type:view $source $pathGroup $country $version $env $service $applicationId $OS $device"
              compute_query {
                aggregation = "count"
              }
            }
            style {
              palette    = "dog_classic"
              line_type  = "solid"
              line_width = "thick"
            }
            display_type = "bars"
          }
          request {
            rum_query {
              index        = "*"
              search_query = "@type:view @view.error.count:>0 $source $pathGroup $country $version $env $service $applicationId $OS $device"
              compute_query {
                aggregation = "count"
              }
            }
            style {
              palette    = "red"
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
        widget_layout {
          x      = 0
          y      = 0
          width  = 6
          height = 2
        }
      }
      widget {
        query_value_definition {
          title = "Error count"
          request {
            aggregator = "avg"
            rum_query {
              index        = "*"
              search_query = "@type:error $source $pathGroup $country $version $env $service $applicationId $OS $device"
              compute_query {
                aggregation = "count"
              }
            }
          }
          autoscale = true
          precision = 2
        }
        widget_layout {
          x      = 6
          y      = 0
          width  = 2
          height = 2
        }
      }
      widget {
        toplist_definition {
          title = "Errors by type"
          request {
            rum_query {
              index        = "*"
              search_query = "@type:error $source $pathGroup $country $version $env $service $applicationId $OS $device"
              group_by {
                facet = "@error.source"
                sort_query {
                  aggregation = "count"
                  order       = "desc"
                }
                limit = 10
              }
              compute_query {
                aggregation = "count"
              }
            }
          }
        }
        widget_layout {
          x      = 8
          y      = 0
          width  = 4
          height = 2
        }
      }
      widget {
        query_value_definition {
          title = "Crashes count"
          request {
            aggregator = "avg"
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
            rum_query {
              index        = "*"
              search_query = "@type:error @error.is_crash:true $source $pathGroup $service $env $version $country $applicationId $OS $device"
              compute_query {
                aggregation = "count"
              }
            }
          }
          autoscale = true
          precision = 2
        }
        widget_layout {
          x      = 0
          y      = 2
          width  = 2
          height = 2
        }
      }
      widget {
        toplist_definition {
          title = "Crashes by application version"
          request {
            conditional_formats {
              comparator = ">"
              palette    = "white_on_red"
              value      = 0
            }
            rum_query {
              index        = "*"
              search_query = "@type:error $source $pathGroup $country $version $env $service $applicationId $OS @error.is_crash:true $device"
              group_by {
                facet = "version"
                sort_query {
                  aggregation = "count"
                  order       = "desc"
                }
                limit = 10
              }
              compute_query {
                aggregation = "count"
              }
            }
          }
        }
        widget_layout {
          x      = 2
          y      = 2
          width  = 4
          height = 2
        }
      }
      widget {
        toplist_definition {
          title = "Resources with most errors"
          request {
            rum_query {
              index        = "*"
              search_query = "(@resource.status_code:>400 OR @error.resource.status_code:>400) $source $pathGroup $country $version $env $service $applicationId $OS $device"
              group_by {
                facet = "@resource.url"
                sort_query {
                  aggregation = "count"
                  order       = "desc"
                }
                limit = 10
              }
              compute_query {
                aggregation = "count"
              }
            }
          }
        }
        widget_layout {
          x      = 6
          y      = 2
          width  = 6
          height = 2
        }
      }
    }
  }
  template_variable {
    name    = "source"
    default = "*"
    prefix  = "source"
  }
  template_variable {
    name    = "pathGroup"
    default = "*"
    prefix  = "@view.url_path_group"
  }
  template_variable {
    name    = "service"
    default = "*"
    prefix  = "service"
  }
  template_variable {
    name    = "env"
    default = "*"
    prefix  = "env"
  }
  template_variable {
    name    = "version"
    default = "*"
    prefix  = "version"
  }
  template_variable {
    name    = "country"
    default = "*"
    prefix  = "@geo.country"
  }
  template_variable {
    name    = "applicationId"
    default = "*"
    prefix  = "@application.id"
  }
  template_variable {
    name    = "OS"
    default = "*"
    prefix  = "@os.name"
  }
  template_variable {
    name    = "device"
    default = "*"
    prefix  = "@device.type"
  }
  layout_type  = "ordered"
  is_read_only = true
  notify_list  = []
}