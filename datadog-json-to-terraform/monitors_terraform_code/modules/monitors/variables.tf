###
# Monitors configuration definition.
###
variable "conf" {
  type = list(object({
    name                              = string
    priority                          = string
    type                              = string
    query                             = string
    operator                          = string
    threshold_critical                = string
    threshold_warning                 = string
    threshold_critical_recovery       = string
    message                           = string
    tags                              = string
    escalation_message                = string
    locked                            = string
    new_host_delay                    = string
    notify_audit                      = string
    notify_no_data                    = string
    renotify_interval                 = string
    require_full_window               = string
    timeout_h                         = string
    evaluation_delay                  = string
    no_data_timeframe                 = string
    include_tags                      = string
    enable_logs_sample                = string
    threshold_windows_recovery_window = string
    threshold_windows_trigger_window  = string
  }))

  default = []

  ###
  # Validation section.
  ##

  # [name]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["name"] != ""
    ])
    error_message = "Input Error: 'name' - Monitor's name is required."
  }

  # [priority]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["priority"] == "" ? true : can(tonumber(entry["priority"])) && (tonumber(entry["priority"]) >= 1 && tonumber(entry["priority"]) <= 5)
    ])
    error_message = "Input Error: 'priority' - Number from 1 (high) to 5 (low)."
  }

  # [type]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["type"] != "" &&
      contains(["query alert", "trace-analytics alert", "composite", "service check", "event alert", "process alert", "log alert", "metric alert", "rum alert", "slo alert", "event-v2 alert"], entry["type"])
    ])
    error_message = "Input Error: 'type' - Monitor's type should be one of the following ['query alert','trace-analytics alert','composite','service check','event alert','process alert','log alert','metric alert','rum alert','slo alert','event-v2 alert'] ."
  }

  # [query]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["query"] != ""
    ])
    error_message = "Input Error: 'query' - Monitor's query is required."
  }

  # [operator]
  validation {
    condition = alltrue([
      for entry in var.conf : contains([">", ">=", "<", "<="], entry["operator"])
    ])
    error_message = "Input Error: 'operator' can be one of the following ['>','>=','<','<=']."
  }

  # [threshold_critical]
  validation {
    condition = alltrue([
      for entry in var.conf : can(tonumber(entry["threshold_critical"]))
    ])
    error_message = "Input Error: 'threshold_critical' -  Must be a Number."
  }

  # [threshold_warning]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["threshold_warning"] == "" ? true : can(tonumber(entry["threshold_warning"]))
    ])
    error_message = "Input Error: 'threshold_critical' - Must be A Number."
  }

  # [threshold_critical_recovery]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["threshold_critical_recovery"] == "" ? true : can(tonumber(entry["threshold_critical_recovery"]))
    ])
    error_message = "Input Error: 'threshold_critical_recovery' - Must be A Number."
  }

  # [message]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["message"] != ""
    ])
    error_message = "Input Error: 'message' - Monitor's message is required."
  }

  # [locked]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["locked"] == "" ? true : can(tobool(lower(entry["locked"])))
    ])
    error_message = "Input Error: 'locked' - Mush be A boolean (true or false)."
  }

  # validation {
  #   # condition     = var.conf[0]["critical"] == null || var.conf[0]["critical"] < 0
  #   #can(regexall([0-9],entry["critical"]))
  #   condition = alltrue([
  #     for entry in var.conf : can(tonumber(entry["threshold_critical"]))
  #   ])
  #   error_message = "Input Error: 'threshold_critical' -  Must be a Number."
  # }

  # [new_host_delay]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["new_host_delay"] == "" ? true : can(tonumber(entry["new_host_delay"])) && tonumber(entry["new_host_delay"]) >= 0
    ])
    error_message = "Input Error: 'new_host_delay' - Must be A Number(non negative)."
  }

  # [notify_audit]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["notify_audit"] == "" ? true : can(tobool(lower(entry["notify_audit"])))
    ])
    error_message = "Input Error: 'notify_audit' - Mush be A boolean (true or false)."
  }

  # [notify_no_data]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["notify_no_data"] == "" ? true : can(tobool(lower(entry["notify_no_data"])))
    ])
    error_message = "Input Error: 'notify_no_data' - Mush be A boolean (true or false)."
  }

  # [renotify_interval]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["renotify_interval"] == "" ? true : can(tonumber(entry["renotify_interval"]))
    ])
    error_message = "Input Error: 'renotify_interval' - Must be A Number ."
  }

  # [require_full_window]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["require_full_window"] == "" ? true : can(tobool(lower(entry["require_full_window"])))
    ])
    error_message = "Input Error: 'require_full_window' - Mush be A boolean (true or false)."
  }

  # [timeout_h]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["timeout_h"] == "" ? true : can(tonumber(entry["timeout_h"]))
    ])
    error_message = "Input Error: 'timeout_h' - Must be A Number ."
  }

  # [evaluation_delay]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["evaluation_delay"] == "" ? true : can(tonumber(entry["evaluation_delay"])) && tonumber(entry["evaluation_delay"]) >= 0
    ])
    error_message = "Input Error: 'evaluation_delay' - Must be A Number(non negative)."
  }

  # [no_data_timeframe]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["no_data_timeframe"] == "" ? true : can(tonumber(entry["no_data_timeframe"]))
    ])
    error_message = "Input Error: 'renotify_ino_data_timeframenterval' - Must be A Number ."
  }

  # [include_tags]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["include_tags"] == "" ? true : can(tobool(lower(entry["include_tags"])))
    ])
    error_message = "Input Error: 'include_tags' - Mush be A boolean (true or false)."
  }

  # [enable_logs_sample]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["enable_logs_sample"] == "" ? true : can(tobool(lower(entry["enable_logs_sample"])))
    ])
    error_message = "Input Error: 'enable_logs_sample' - Mush be A boolean (true or false)."
  }

  # validation {
  #   condition = alltrue([
  #     for entry in var.conf : contains(["","true","false"],entry["enable_logs_sample"])
  #   ])
  #   error_message = "Must be boolean."
  # }

  #   validation {
  #     # condition     = var.conf[0]["critical"] == null || var.conf[0]["critical"] < 0
  #     condition     = var.conf[0].critical != null
  #     error_message = "Critical value not valid."
  #   }

}

# locals {
#   conf = csvdecode(file("monitors.csv"))
# }
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

#####
# Default configuration.
####
variable "default_conf" {
  default = {
    "threshold_warning"           = null
    "threshold_critical_recovery" = null
    "tags"                        = []
    "notify_audit"                = false
    "locked"                      = false
    "timeout_h"                   = 0
    "include_tags"                = true
    "no_data_timeframe"           = 10
    "require_full_window"         = false
    "new_host_delay"              = 300
    "notify_no_data"              = false
    "renotify_interval"           = 0
    "evaluation_delay"            = 900
    "enable_logs_sample"          = false
    "priority"                    = null
  }
}