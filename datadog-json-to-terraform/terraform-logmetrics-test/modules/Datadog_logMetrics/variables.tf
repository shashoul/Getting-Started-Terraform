variable "conf" {
  type = list(object({
    name         = string
    filter_query = string
    compute_type = string
    compute_path = string
    group_by     = string
  }))

  default = []

  ##########################################################################
  # Validation section.
  ##########################################################################

  # [name]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["name"] != ""
    ])
    error_message = "Input Error: 'name' - Log Metrics name is required."
  }

  # [filter_query]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["filter_query"] != ""
    ])
    error_message = "Input Error: 'filter_query' - Log Metrics filter query is required."
  }

  # [compute_type]
  validation {
    condition = alltrue([
      for entry in var.conf : entry["compute_type"] != ""
    ])
    error_message = "Input Error: 'compute_type' - Log Metrics compute aggregation_type is required."
  }

}