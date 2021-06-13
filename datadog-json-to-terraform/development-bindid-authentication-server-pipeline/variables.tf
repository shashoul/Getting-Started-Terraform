
# locals {
#   category_processors = [
#     {
#       name       = "Api Audience",
#       target     = "api_audience"
#       definition = csvdecode(file("api_audience.csv"))
#     },
#     {
#       name       = "Error Category"
#       target     = "error_category"
#       definition = csvdecode(file("error_category.csv"))
#     }
#   ]
# }

locals {

  category_processors_csv = csvdecode(file("category_processors.csv"))

  category_processors = [
    for entry in toset([for category in local.category_processors_csv : { name = category.name, target = category.target }]) :
    { name   = entry.name,
      target = entry.target,
      definition = [
        for def in local.category_processors_csv : { name = def.category_name, filter_query = def.filter_query } if def.name == entry.name
      ]
    }
  ]

}