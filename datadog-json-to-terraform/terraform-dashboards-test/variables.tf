# resource "null_resource" "example1" {
#   provisioner "local-exec" {
#     command = "python3 example.py"
#   }
# }

variable "todo_id" {
  type    = number
  default = 12
}

data "external" "todo" {
  program = ["python3", "example.py"]
  query = {
    id = var.todo_id
  }
}

locals {
  #   todo = jsondecode(data.external.todo.result.monitors)
  todo = jsondecode(file("temp.json"))
}

output "todo" {
  value = local.todo
}