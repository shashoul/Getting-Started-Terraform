# output "todo" {
#   value = local.todo
# }

# resource "null_resource" "example2" {
#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "python3 ./configuration/name_generator.py"
#   }
# }

output "info" {
  value = local.key
}

output "conf" {
  value = local.environment_settings.data
}

output "points" {
  value = local.environment_settings.data.points["p3"]
}

output "result" {
  value = var.result
}

output "var1" {
  value = var.var1
}

output "A1" {
  value = var.A1
}

output "alb_services" {
  value = local.conf.AWS.alb_services
}

output "ec2_services" {
  value = local.conf.AWS.ec2_services
}

output "nat_services" {
  value = local.conf.AWS.nat_services
}

output "natComp_services" {
  value = local.conf.AWS.natComp_services
}