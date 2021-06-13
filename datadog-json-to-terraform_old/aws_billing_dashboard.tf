resource "datadog_dashboard" "aws_billing_dashboard" {

  title       = "Shady Terraform Test !!! - AWS Billing"
  description = <<EOF
This dashboard pulls in current and forecasted cost data from AWS to show your spending on each AWS account and service you're using. For more information about AWS billing, see:

- [Datadog's AWS Billing integration documentation](https://docs.datadoghq.com/integrations/aws_billing/)

- [Monitoring your AWS billing](https://docs.datadoghq.com/integrations/faq/how-do-i-monitor-my-aws-billing-details/)

- [Monitoring your CloudWatch usage](https://docs.datadoghq.com/integrations/faq/using-datadog-s-aws-billing-integration-to-monitor-your-cloudwatch-usage/)

Clone this template dashboard to make changes and add your own graph widgets.
EOF
  widget {
    widget_layout {
      x      = 18
      y      = 83
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Top Actual Spend"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.actual_spend{$account_id} by {budget_name}, 20, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 110
      y      = 47
      width  = 18
      height = 6
    }
    note_definition {
      content          = "See the AWS [documentation](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/budgets-view.html)"
      background_color = "white"
      font_size        = "14"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "left"
    }
  }
  widget {
    widget_layout {
      x      = 23
      y      = 111
      width  = 62
      height = 5
    }
    note_definition {
      content          = "Note: Datadog needs the 'budgets:ViewBudget' permission to gather this data. See our [documentation](https://app.datadoghq.com/account/settings#integrations/amazon_billing)"
      background_color = "yellow"
      font_size        = "14"
      text_align       = "left"
      show_tick        = false
      tick_pos         = "50%"
      tick_edge        = "top"
    }
  }
  widget {
    widget_layout {
      x      = 18
      y      = 56
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Top Forecasted Spend"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.forecasted_spend{$account_id} by {budget_name}, 20, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 47
      width  = 107
      height = 7
    }
    note_definition {
      content          = "Budgets"
      background_color = "blue"
      font_size        = "36"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "bottom"
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 83
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Least Actual Spend Remaining"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.budget_limit{$account_id} by {budget_name} - sum:aws.billing.actual_spend{$account_id} by {budget_name}, 20, 'mean', 'asc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 49
      y      = 56
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Least Forecasted Spend Remaining"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.budget_limit{$account_id} by {budget_name} - sum:aws.billing.forecasted_spend{$account_id} by {budget_name}, 20, 'mean', 'asc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 80
      y      = 83
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Actual Spend to Limit %"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.actual_spend{$account_id} by {budget_name} / sum:aws.billing.budget_limit{$account_id} by {budget_name} * 100, 20, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 80
      y      = 56
      width  = 28
      height = 25
    }
    toplist_definition {
      title       = "Forecasted Spend to Limit %"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.forecasted_spend{$account_id} by {budget_name} / sum:aws.billing.budget_limit{$account_id} by {budget_name} * 100, 20, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 83
      width  = 13
      height = 25
    }
    note_definition {
      content          = <<EOF
#
#
##
# Actual
EOF
      background_color = "white"
      font_size        = "24"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 1
      width  = 18
      height = 15
    }
    image_definition {
      url    = "/static/images/logos/amazon-billing_large.svg"
      sizing = "center"
    }
  }
  widget {
    widget_layout {
      x      = 1
      y      = 56
      width  = 13
      height = 25
    }
    note_definition {
      content          = <<EOF
#
#
##
# Forecasted
EOF
      background_color = "white"
      font_size        = "24"
      text_align       = "center"
      show_tick        = true
      tick_pos         = "50%"
      tick_edge        = "right"
    }
  }
  widget {
    widget_layout {
      x      = 23
      y      = 1
      width  = 40
      height = 39
    }
    toplist_definition {
      title       = "Estimated Charges by Account"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.estimated_charges{$account_id,$service} by {account_id}, 10, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    widget_layout {
      x      = 68
      y      = 1
      width  = 40
      height = 39
    }
    toplist_definition {
      title       = "Estimated Charges by Service"
      title_size  = "16"
      title_align = "left"
      live_span   = "1d"
      request {
        q = "top(sum:aws.billing.estimated_charges{$account_id,$service} by {servicename}, 10, 'mean', 'desc')"
        style {
          palette = "dog_classic"
        }
      }
    }
  }
  template_variable {
    name    = "account_id"
    default = "*"
    prefix  = "account_id"
  }
  template_variable {
    name    = "service"
    default = "*"
    prefix  = "servicename"
  }
  layout_type  = "free"
  is_read_only = true
  notify_list  = []
}