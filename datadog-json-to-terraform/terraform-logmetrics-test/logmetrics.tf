# #####
# #
# # logmetrics
# #
# #####
# resource "datadog_logs_metric" "logmetrics_1" {

#   compute {
#     aggregation_type = "count"
#   }
#   filter {
#     query = "Client returned with error Session rejected by server"
#   }
#   name = "client.returned.error"
# }


# resource "datadog_logs_metric" "logmetrics_2" {

#   compute {
#     aggregation_type = "count"
#   }
#   filter {
#     query = "service:elb status:warn @http.url_details.path:\"/api/v2/oidc/bindid-oidc/token\""
#   }
#   name = "count.error.auth"
# }


# resource "datadog_logs_metric" "logmetrics_3" {

#   compute {
#     aggregation_type = "distribution"
#     path             = "ingest_size_in_bytes"
#   }
#   filter {
#     query = "*"
#   }
#   group_by {
#     path     = "service"
#     tag_name = "service"
#   }
#   group_by {
#     path     = "datadog_index"
#     tag_name = "datadog_index"
#   }
#   name = "datadog.estimated_usage.logs.ingested_bytes"
# }

# resource "datadog_logs_metric" "logmetrics_4" {

#   compute {
#     aggregation_type = "distribution"
#     path             = ""
#   }
#   filter {
#     query = "*"
#   }
#   group_by {
#     path     = "service"
#     tag_name = "service"
#   }
#   group_by {
#     path     = "datadog_index"
#     tag_name = "datadog_index"
#   }
#   name = "datadog.estimated_usage.logs.ingested_bytes.test"
# }


