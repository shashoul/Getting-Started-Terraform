# #####
# #
# # logmetrics
# #
# #####
# resource "datadog_logs_metric" "logmetrics_1" {

#   compute {
#     aggregation_type = "distribution"
#     path             = "@duration"
#   }
#   filter {
#     query = "@error_category:\"OIDC /complete with errors\""
#   }
#   group_by {
#     path     = "status"
#     tag_name = "status"
#   }
#   group_by {
#     path     = "@aws.awslogs.logGroup"
#     tag_name = "aws.awslogs.loggroup"
#   }
#   name = "test.terraform.shady"
# }


