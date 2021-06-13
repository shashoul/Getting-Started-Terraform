# variable "conf" {
#   type = list(object({
#     name      = string,
#     query     = string,
#     critical  = string,
#     warning   = string,
#     recovered = string
#   }))
#   default = []

#   validation {
#     # condition     = var.conf[0]["critical"] == null || var.conf[0]["critical"] < 0
#     condition = alltrue([
#       for entry in var.conf : entry["critical"] != null
#     ])
#     error_message = "Critical value not valid."
#   }

#   #   validation {
#   #     # condition     = var.conf[0]["critical"] == null || var.conf[0]["critical"] < 0
#   #     condition     = var.conf[0].critical != null
#   #     error_message = "Critical value not valid."
#   #   }

# }

locals {
  #   conf = csvdecode(file("monitors.csv"))
  # conf = csvdecode(file("monitors_file.csv"))
  conf = csvdecode(file("development_monitors.csv"))
}
# dynamic "validation" {
#     for_each = var.conf
#     content {
#       condition     = validation.critical == "" || validation.critical < 0
#       error_message = ""
#     }
#   }

# variable "mytestname" {

#   validation {
#     condition     = length(regexall("test$", var.mytestname)) > 0
#     error_message = "Should end in test."
#   }
# }

# variable "image_id" {
#   type        = string
#   description = "The id of the machine image (AMI) to use for the server."

#   default = ""

#   validation {
#     # condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
#     condition     = can(regex("^ami-", var.image_id))
#     error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
#   }
# }