#####
#
# logmetrics
#
#####
# resource "datadog_logs_metric" "logmetrics_terraform_test" {

#   compute {
#     aggregation_type = "count"
#   }
#   filter {
#     query = "@error_category:\"OIDC /complete with errors\""
#   }
#   group_by {
#     path     = "@http.method"
#     tag_name = "@http.method"
#   }
#   group_by {
#     path     = "@http.status_code"
#     tag_name = "@http.status_code"
#   }
#   group_by {
#     path     = "status"
#     tag_name = "status"
#   }
#   name = "test.terraform.shady"
# }


# resource "datadog_logs_metric" "log_metric" {
#   for_each = toset(keys({ for k, v in local.conf : k => v }))

#   name = local.conf[each.value].name

#   compute {
#     aggregation_type = local.conf[each.value].compute_type
#     path             = local.conf[each.value].compute_path #== "" ? "" : var.conf[each.value].compute_path
#   }

#   filter {
#     query = local.conf[each.value].filter_query
#   }

#   dynamic "group_by" {
#     for_each = split(" ", trimspace(local.conf[each.value].group_by))
#     content {
#       path     = group_by.value
#       tag_name = replace(group_by.value, "@", "")
#     }
#   }
#   # dynamic group_by {
#   #   content {
#   #     path = 
#   #   }
#   # }

# }

module "LogMetrics" {
  source = "./modules/Datadog_logMetrics"
  conf   = local.conf
}

output "LogMetrics" {
  value = module.LogMetrics
}