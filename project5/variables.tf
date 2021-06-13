# data "external" "droplet_name" {
#   program = ["python3", "${path.module}/configuration/name_generator.py"]
# }

# locals {
# #   todo = data.external.droplet_name.result["name"]
#   todo = jsondecode(data.external.droplet_name.result["info"])
#   key = local.todo.AA

# }

# data "external" "settings" {
#   program = ["python3", "${path.module}/configuration/name_generator.py"]
# }

locals {
  key = var.result
#   environment_settings = jsondecode(file("${path.module}/configuration.json"))
  environment_settings = jsondecode(file("../configuration/configuration.json"))
#   settings = jsondecode(data.external.settings)
  conf = jsondecode(file("../configuration/development.json"))
}

