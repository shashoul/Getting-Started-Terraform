#####
#
# synthetics
#
#####
resource "datadog_synthetics_test" synthetics_1 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
Health Check for Admin Sandbox Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid-sandbox.io/version
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on admin.bindid-sandbox.io/version - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://admin.bindid-sandbox.io/version"
 method = "GET"
 } 
 assertion {
 operator = "is"
 type = "statusCode"
 target = 200
 } 
 options_list {
 monitor_options {
 renotify_interval = 0
 } 
 tick_every = 900
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


