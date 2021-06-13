# variable "conf" {
#   type = list(object({
#     name         = string
#     compute_type = string
#     compute_path = string
#     filter_query = string
#     group_by     = string
#   }))

#   default = [
#     {
#       name         = "test.terraform.shady"
#       compute_type = "count"
#       compute_path = ""
#       filter_query = "@error_category:\"OIDC /complete with errors\""
#       group_by     = " @http.status_code @http.method status"
#     }
#   ]

# }

locals {
  #   conf = [
  #     {
  #       name         = "test1.terraform.shady"
  #       filter_query = "@error_category:\"OIDC /complete with errors\""
  #       compute_type = "count"
  #       compute_path = ""
  #       group_by     = " @http.status_code @http.method status"
  #     },
  #     {
  #       name         = "test2.terraform.shady"
  #       filter_query = "@error_category:\"500: End users\""
  #       compute_type = "count"
  #       compute_path = ""
  #       group_by     = ""
  #     }
  #   ]
  conf = csvdecode(file("logmetrics.csv"))
}