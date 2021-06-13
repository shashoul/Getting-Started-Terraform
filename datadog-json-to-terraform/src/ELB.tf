resource "datadog_monitor" ELB_1 {

 name = "Terraform - ELB Monitor - Count 4XX errors on auth server"
 type = "log alert"
 query = "logs(\"service:elb status:warn @http.url_details.path:\\\"/api/v2/oidc/bindid-oidc/token\\\"\").index(\"*\").rollup(\"count\").last(\"15m\") >= 5"
 message = <<EOF
Monitor - Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token



Summary:P1 - {{value}} Count 4XX errors on auth server: api/v2/oidc/bindid-oidc/token
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:auth server: api/v2/oidc/bindid-oidc/token
Service:Number of 4XX Errors
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 tags = ["Ring1",]
 notify_audit = false
 locked = false
 timeout_h = 0
 include_tags = true
 monitor_thresholds {
 critical = 5.0
 } 
 new_host_delay = 300
 notify_no_data = false
 renotify_interval = 0
 enable_logs_sample = true
 priority = 1
}


