resource "datadog_logs_custom_pipeline" "pipeline_test2" {

  name       = "AWS S3 access logs"
  is_enabled = true
  filter {
    query = "source:s3"
  }
  processor {
    grok_parser {
      name       = "Parsing S3 Access logs"
      is_enabled = true
      source     = "message"
      samples    = ["79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be mybucket [06/Feb/2014:00:00:38 +0000] 192.0.2.3 79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be 3E57427F3EXAMPLE REST.GET.VERSIONING - \"GET /mybucket?versioning HTTP/1.1\" 200 - 113 - 7 - \"-\" \"S3Console/0.4\" -", "79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be mybucket [06/Feb/2014:00:00:38 +0000] 192.0.2.3 79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be 891CE47D2EXAMPLE REST.GET.LOGGING_STATUS - \"GET /mybucket?logging HTTP/1.1\" 200 - 242 - 11 - \"-\" \"S3Console/0.4\" -", "79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be mybucket [06/Feb/2014:00:00:38 +0000] 192.0.2.3 79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be A1206F460EXAMPLE REST.GET.BUCKETPOLICY - \"GET /mybucket?policy HTTP/1.1\" 404 NoSuchBucketPolicy 297 - 38 - \"-\" \"S3Console/0.4\" -", ]
      grok {
        support_rules = <<EOF
_s3_bucket_owner %%{notSpace:s3.bucket_owner}
_s3_bucket %%{notSpace:s3.bucket}
_s3_operation %%{notSpace:s3.operation}
_s3_error_code %%{notSpace:s3.error_code:nullIf("-")}
_request_processing_time %%{integer:http.request_processing_time}
_request_id %%{notSpace:http.request_id}
_request_version_id %%{notSpace:http.request_version_id:nullIf("-")}
_bytes_written %%{integer:network.bytes_written}
_bytes_read %%{integer:network.bytes_read}
_object_size %%{integer:network.object_size}
_client_ip %%{ipOrHost:network.client.ip}
_client_id %%{notSpace:network.client.id}
_version HTTP\/%%{regex("\\d+\\.\\d+"):http.version}
_url %%{notSpace:http.url}
_ident %%{notSpace:http.ident:nullIf("-")}
_user_agent %%{regex("[^\\\"]*"):http.useragent}
_referer %%{notSpace:http.referer:nullIf("-")}
_status_code %%{integer:http.status_code}
_method %%{word:http.method}
_duration %%{integer:duration:scale(1000000)}
_date_access \[%%{date("dd/MMM/yyyy:HH:mm:ss Z"):date_access}\]

EOF
        match_rules   = <<EOF
s3.access %%{_s3_bucket_owner} %%{_s3_bucket} %%{_date_access} (?>%%{_client_ip}|-) %%{_client_id} %%{_request_id} %%{_s3_operation} %%{notSpace} "(?>%%{_method} |)%%{_url}(?> %%{_version}|)" %%{_status_code} %%{_s3_error_code} (?>%%{_bytes_written}|-) (?>%%{_object_size}|-) %%{_duration} (?>%%{_request_processing_time}|-) "%%{_referer}" "%%{_user_agent}" %%{_request_version_id}.*

s3.fallback %%{_s3_bucket_owner} %%{_s3_bucket} %%{_date_access} (?>%%{_client_ip}|-) %%{_client_id} %%{_request_id} %%{_s3_operation}.*

EOF
      }
    }
  }
  processor {
    user_agent_parser {
      name       = ""
      is_enabled = true
      sources    = ["http.useragent", ]
      target     = "http.useragent_details"
      is_encoded = false
    }
  }
  processor {
    url_parser {
      name                     = ""
      is_enabled               = true
      sources                  = ["http.url", ]
      target                   = "http.url_details"
      normalize_ending_slashes = false
    }
  }
  processor {
    date_remapper {
      name       = "Define Date_access as the official timestamp of the log"
      is_enabled = true
      sources    = ["date_access", ]
    }
  }
  processor {
    category_processor {
      name       = "Categorise status code"
      is_enabled = true
      category {
        filter {
          query = "@http.status_code:[200 TO 299]"
        }
        name = "OK"
      }
      category {
        filter {
          query = "@http.status_code:[300 TO 399]"
        }
        name = "notice"
      }
      category {
        filter {
          query = "@http.status_code:[400 TO 499]"
        }
        name = "warning"
      }
      category {
        filter {
          query = "@http.status_code:[500 TO 599]"
        }
        name = "error"
      }
      target = "http.status_category"
    }
  }
  processor {
    status_remapper {
      name       = "Set the log status based on the status code value"
      is_enabled = true
      sources    = ["http.status_category", ]
    }
  }
}