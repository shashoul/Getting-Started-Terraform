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


resource "datadog_synthetics_test" synthetics_2 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for Assets Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 


Summary:Failed HTTP Check on assets.bindid-sandbox.io/Acme.png
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - assets.bindid-sandbox.io/Acme.png
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on assets.bindid-sandbox.io/Acme.png"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://assets.bindid-sandbox.io/Acme.png"
 method = "GET"
 } 
 assertion {
 operator = "is"
 type = "statusCode"
 target = 200
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "image/png"
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


resource "datadog_synthetics_test" synthetics_3 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for Developer Service has failed @slack-bindid-srv-uptime-alerts  @webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on developer.bindid.io
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - developer.bindid.io
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on developer.bindid.io"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://developer.bindid.io"
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


resource "datadog_synthetics_test" synthetics_4 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for IDP Service has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on signin.bindid-sandbox.io/authorize
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - signin.bindid-sandbox.io/authorize
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on signin.bindid-sandbox.io/authorize?client_id=bid_demo_acme&redirect_uri=https:%2F%2Fdemo.bindid-sandbox.io%2F_complete%2Facme&nonce=734586662&state=392980498&bindid_aux_link_title=More%20ways%20to%20verify&bindid_aux_link=https:%2F%2Fdemo.bindid-sandbox.io%2Fother_login&bindid_custom_message=Login%20to%20Acme&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://signin.bindid-sandbox.io/authorize?client_id=bid_demo_acme&redirect_uri=https:%2F%2Fdemo.bindid-sandbox.io%2F_complete%2Facme&nonce=734586662&state=392980498&bindid_aux_link_title=More%20ways%20to%20verify&bindid_aux_link=https:%2F%2Fdemo.bindid-sandbox.io%2Fother_login&bindid_custom_message=Login%20to%20Acme&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
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


resource "datadog_synthetics_test" synthetics_5 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
Health Check for Auth Server has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on ts.bindid-sandbox.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid-sandbox.io/api/v2/status
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on ts.bindid-sandbox.io/api/v2/status - 200 status code check"
 type = "api"
 subtype = "http"
 request_headers = {
 Authorization = "TSToken status ;tid=status"
 }
 request_definition {
 url = "https://ts.bindid-sandbox.io/api/v2/status"
 method = "GET"
 } 
 assertion {
 operator = "doesNotContain"
 type = "body"
 target = "\"status\": 1"
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "application/json"
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
 tick_every = 30
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_6 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for Demo Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on demo.bindid-sandbox.io/initial demoIdentifier=acme 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - demo.bindid-sandbox.io/initial?demoIdentifier=acme
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on demo.bindid-sandbox.io/initial?demoIdentifier=acme"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://demo.bindid-sandbox.io/initial?demoIdentifier=acme"
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


resource "datadog_synthetics_test" synthetics_7 {

 status = "live"
 tags = []
 locations = ["aws:us-east-2",]
 message = <<EOF
Health Check for Auth Server has failed
Monitor to exclude DNS lookup: https://app.datadoghq.com/monitors/32593392

@webhook-XiteIt

Summary:High Response Time on ts.bindid-sandbox.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid-sandbox.io/api/v2/status
Service:Failed Health - Response Time Check
Value:Response Time is High 
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on ts.bindid-sandbox.io/api/v2/status - Response time check"
 type = "api"
 subtype = "http"
 request_headers = {
 Authorization = "TSToken status ;tid=status"
 }
 request_definition {
 url = "https://ts.bindid-sandbox.io/api/v2/status"
 method = "GET"
 } 
 assertion {
 operator = "doesNotContain"
 type = "body"
 target = "\"status\": 1"
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "application/json"
 } 
 assertion {
 operator = "lessThan"
 type = "responseTime"
 target = 250
 } 
 options_list {
 monitor_options {
 renotify_interval = 0
 } 
 tick_every = 30
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_8 {

 status = "live"
 tags = []
 locations = ["aws:ca-central-1",]
 message = <<EOF
Health Check for Admin Sandbox Service failed
Monitor to exclude DNS lookup: https://app.datadoghq.com/monitors/32593296
@webhook-XiteIt

Summary:Response Time is High on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid-sandbox.io/version
Service:Failed Health - Response Time Check
Value:Response Time is High
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on admin.bindid-sandbox.io/version - Response time check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://admin.bindid-sandbox.io/version"
 method = "GET"
 } 
 assertion {
 operator = "lessThan"
 type = "responseTime"
 target = 250
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "text/plain; charset=utf-8"
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


resource "datadog_synthetics_test" synthetics_9 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on backoffice.bindid-sandbox.io/api/auth/google
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:backoffice.bindid-sandbox.io/api/auth/google
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on backoffice.bindid-sandbox.io/api/auth/google - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://backoffice.bindid-sandbox.io/api/auth/google"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_10 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on my.bindid-sandbox.io/manage/login

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:my.bindid-sandbox.io/manage/login
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on my.bindid-sandbox.io/manage/login - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://my.bindid-sandbox.io/manage/login"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_11 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on aux.bindid-sandbox.io/ciba

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:aux.bindid-sandbox.io/ciba
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on aux.bindid-sandbox.io/ciba - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://aux.bindid-sandbox.io/ciba"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_12 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:ca-central-1",]
 message = <<EOF
Health Check for Admin Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on admin.bindid-sandbox.io/version 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - admin.bindid.io/version
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on admin.bindid.io/version - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://admin.bindid.io/version"
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


resource "datadog_synthetics_test" synthetics_13 {

 status = "live"
 tags = ["Ring1","Sandbox",]
 locations = ["aws:us-east-2",]
 message = <<EOF
Health Check for Admin Sandbox Service failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on mobile.bindid-sandbox.io
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - mobile.bindid-sandbox.io
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on mobile.bindid-sandbox.io - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://mobile.bindid-sandbox.io"
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


resource "datadog_synthetics_test" synthetics_14 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on aux.bindid.io/ciba

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:aux.bindid.io/ciba
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on aux.bindid.io/ciba - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://aux.bindid.io/ciba"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_15 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on backoffice.bindid.io/api/auth/google
Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:backoffice.bindid.io/api/auth/google
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on backoffice.bindid.io/api/auth/google - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://backoffice.bindid.io/api/auth/google"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_16 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for Demo Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on demo.bindid.io/initial demoIdentifier=acme 
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - demo.bindid.io/initial?demoIdentifier=acme
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on demo.bindid.io/initial?demoIdentifier=acme"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://demo.bindid.io/initial?demoIdentifier=acme"
 method = "GET"
 } 
 assertion {
 operator = "is"
 type = "statusCode"
 target = 302
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


resource "datadog_synthetics_test" synthetics_17 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:us-east-2",]
 message = <<EOF
 @slack-bindid-srv-uptime-alerts @webhook-Uptime-XiteIt 

Summary:P(not-defined) - {{http.status_code}} Status Code {{Value}} on my.bindid.io/manage/login

Critical Threshold:{{threshold}}
Warning Threshold:-

Host:Synthetics
Service:my.bindid.io/manage/login
Value:{{value}}
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on my.bindid.io/manage/login - 200 status code check"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://my.bindid.io/manage/login"
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
 tick_every = 60
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_18 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:us-east-2",]
 message = <<EOF
Health Check for Auth Server has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on ts.bindid.io/api/v2/status
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - ts.bindid.io/api/v2/status
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on ts.bindid.io/api/v2/status - 200 status code check"
 type = "api"
 subtype = "http"
 request_headers = {
 Authorization = "TSToken status ;tid=status"
 }
 request_definition {
 url = "https://ts.bindid.io/api/v2/status"
 method = "GET"
 } 
 assertion {
 operator = "doesNotContain"
 type = "body"
 target = "\"status\": 1"
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "application/json"
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
 tick_every = 30
 min_failure_duration = 0
 min_location_failed = 1
 } 
}


resource "datadog_synthetics_test" synthetics_19 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for Assets Service has failed @slack-bindid-srv-uptime-alerts
@webhook-Uptime-XiteIt 


Summary:Failed HTTP Check on assets.bindid.io/app_c50756a4_TransmitLogo.jpg
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - assets.bindid.io//app_c50756a4_TransmitLogo.jpg
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on assets.bindid.io/app_c50756a4_TransmitLogo.jpg"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://assets.bindid.io/app_c50756a4_TransmitLogo.jpg"
 method = "GET"
 } 
 assertion {
 operator = "is"
 type = "statusCode"
 target = 200
 } 
 assertion {
 operator = "is"
 property = "content-type"
 type = "header"
 target = "image/jpeg"
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


resource "datadog_synthetics_test" synthetics_20 {

 status = "live"
 tags = ["Ring1","Production",]
 locations = ["aws:eu-west-1",]
 message = <<EOF
Health Check for IDP Service has failed @slack-bindid-srv-uptime-alerts

@webhook-Uptime-XiteIt 

Summary:Failed HTTP Check on signin.bindid.io/authorize
Critical Threshold:-
Warning Threshold:-

Host:Synthetic Check - signin.bindid.io/authorize
Service:Failed Health - 200 Status Code Check
Value:200 Status Code Check has Failed
Severity:{{#is_alert}}Critical{{/is_alert}}{{#is_warning}}Warning{{/is_warning}}{{#is_no_data}}No Data{{/is_no_data}}{{#is_recovery}}Recovered{{/is_recovery}}
EOF
 name = "Test on signin.bindid.io/authorize?client_id=be415353.c50756a4.dev_36434736.bindid.io&redirect_uri=https%3A%2F%2Fdemo.bindid.io%2Fsynthetic-monitoring-request&nonce=666666666&state=123456789&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
 type = "api"
 subtype = "http"
 request_definition {
 url = "https://signin.bindid.io/authorize?client_id=be415353.c50756a4.dev_36434736.bindid.io&redirect_uri=https%3A%2F%2Fdemo.bindid.io%2Fsynthetic-monitoring-request&nonce=666666666&state=123456789&scope=openid%20bindid_network_info&display=page&prompt=login&response_type=code"
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


