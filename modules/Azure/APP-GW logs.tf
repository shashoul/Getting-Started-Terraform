resource "datadog_logs_custom_pipeline" "azure_app_gw" {
  filter {
    query = "source:azure-application-gateway"
  }
  name       = "Azure Application Gateway"
  is_enabled = true
  processor {
    date_remapper {
      sources    = ["timeStamp"]
      name       = "timestamp"
      is_enabled = true
    }
  }
  processor {
    user_agent_parser {
      sources    = ["properties.userAgent"]
      target     = "http.useragent_details"
      is_encoded = false
      name       = "HTTP user agent"
      is_enabled = true
    }
  }
  processor {
    url_parser {
      name    = "URL parser"
      sources = ["properties.originalRequestUriWithArgs"]
      target  = "http.url_details"
      is_enabled = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.httpMethod"]
      source_type          = "attribute"
      target               = "http.method"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP method"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.userAgent"]
      source_type          = "attribute"
      target               = "http.useragent"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP user agent"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.httpStatus"]
      source_type          = "attribute"
      target               = "http.status_code"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP status"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.host"]
      source_type          = "attribute"
      target               = "http.url_details.host"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP host"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.clientIP"]
      source_type          = "attribute"
      target               = "network.client.ip"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
      name                 = "Client IP"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.httpVersion"]
      source_type          = "attribute"
      target               = "http.version"
      target_type          = "attribute"
      target_format        = "string"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP version"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.clientPort"]
      source_type          = "attribute"
      target               = "network.client.port"
      target_type          = "attribute"
      target_format        = "integer"
      preserve_source      = false
      override_on_conflict = false
      name                 = "HTTP host"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.receivedBytes"]
      source_type          = "attribute"
      target               = "network.bytes_read"
      target_type          = "attribute"
      target_format        = "integer"
      preserve_source      = false
      override_on_conflict = false
      name                 = "Bytes read"
      is_enabled           = true
    }
  }
  processor {
    attribute_remapper {
      sources              = ["properties.sentBytes"]
      source_type          = "attribute"
      target               = "network.bytes_written"
      target_type          = "attribute"
      target_format        = "integer"
      preserve_source      = false
      override_on_conflict = false
      name                 = "Bytes written"
      is_enabled           = true
    }
  }
}
