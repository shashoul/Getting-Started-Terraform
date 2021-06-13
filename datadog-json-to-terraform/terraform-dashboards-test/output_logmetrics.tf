resource "datadog_logs_metric" "logmetrics_1" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "cannot_consume_ticket ERROR 401"
  }
  name = "cannot.consume"
}


resource "datadog_logs_metric" "logmetrics_2" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "Client returned with error Session rejected by server"
  }
  name = "client.returned.error"
}


resource "datadog_logs_metric" "logmetrics_3" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "service:elb status:warn @http.url_details.path:\"/api/v2/oidc/bindid-oidc/token\""
  }
  name = "count.error.auth"
}


resource "datadog_logs_metric" "logmetrics_4" {

  compute {
    aggregation_type = "distribution"
    path             = "ingest_size_in_bytes"
  }
  filter {
    query = "*"
  }
  group_by {
    path     = "service"
    tag_name = "service"
  }
  group_by {
    path     = "datadog_index"
    tag_name = "datadog_index"
  }
  name = "datadog.estimated_usage.logs.ingested_bytes"
}


resource "datadog_logs_metric" "logmetrics_5" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "*"
  }
  group_by {
    path     = "datadog_is_excluded"
    tag_name = "datadog_is_excluded"
  }
  group_by {
    path     = "service"
    tag_name = "service"
  }
  group_by {
    path     = "status"
    tag_name = "status"
  }
  group_by {
    path     = "datadog_index"
    tag_name = "datadog_index"
  }
  name = "datadog.estimated_usage.logs.ingested_events"
}


resource "datadog_logs_metric" "logmetrics_6" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "Request started anonymous_invoke policy_request_id ama-rejection-recovery"
  }
  name = "recovery.journey.invocations"
}


resource "datadog_logs_metric" "logmetrics_7" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "service:aws @http.url_details.path:\"/registration-result\" @http.useragent_details.browser.family:Other"
  }
  name = "registration.result.no.browser.count"
}


resource "datadog_logs_metric" "logmetrics_8" {

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "service:cloudfront -@http.url_details.path:(\\/favicon* OR \"/robots.txt\" OR \\/apple-touch-icon*) @http.ident:*bindid.io @http.status_code:[400 TO 499]"
  }
  name = "test.eldan"
}


