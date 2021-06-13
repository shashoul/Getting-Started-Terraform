resource "datadog_logs_custom_pipeline" "bindid_authentication_server" {

  name       = "bindid-authentication-server"
  is_enabled = true
  filter {
    query = "source:bindid-authentication-server"
  }

  processor {
    grok_parser {
      name       = "binid-authentication-server-log-parser"
      is_enabled = true
      source     = "message"
      samples    = ["2021-04-02 08:32:40.160 DEBUG c.t.c.p.e.Classifiers:40 - 2892115191688515477 342565592643546944 - [] [7ca08a_4319713] [BID_e83a-ea19-40ae-afaf-1aa48c070340] [transmit-akka.actor.default-dispatcher-5] Expression evaluated to true; expression: [FieldLiteral(ExpressionField(response.status == 200,InjectedRealm(DefaultRealmId)))], result: [Success]", "2021-04-02 08:32:22.401 DEBUG c.t.c.h.HttpUtils$:151 - 2946111874947228986 572993811394358254 - [] [7ca08a_4319659] [BID_e83a-ea19-40ae-afaf-1aa48c070340] [transmit-akka.actor.default-dispatcher-5] Received response; url: [https://http-intake.logs.datadoghq.com/v1/input], method: [POST], code: [200] took: [58]", "2021-04-02 08:32:34.828 DEBUG c.t.c.h.HttpUtils$:57 - 6252927043405491503 7134353032431869550 - [] [7ca08a_4319697] [BID_e83a-ea19-40ae-afaf-1aa48c070340] [transmit-akka.actor.default-dispatcher-4] Sending request; url: [https://http-intake.logs.datadoghq.com/v1/input], method: [POST], headers: [List((DD-API-KEY,a9c148505325b952e0fdd768261b6d18))], body: [Some({\"failure\":false,\"device_id\":\"6561ac5e-af8d-4ed6-996a-687fcf2279cf\",\"policy_id\":\"idp_init\",\"session_id\":\"3b091501-11e3-4c08-b296-f3fae87a25a2\",\"device_os_type\":\"Mac OS X\",\"hostname\":\"ts-sandbox-auth-control-5b5b979f7c-xdtq6\",\"device_hw_id\":\"0a8086199f0f7024edd00d5380c8fcb4\",\"device_session_id\":\"91d06084-ac10-4c90-978d-39c14862e2b3\",\"device_model\":\"Chrome 89.0\",\"ddtags\":\"env:sandbox,buid:ac1e3db9-aa8c-4f56-96fa-1d4bd148dd6d,event_action:assertion_start,event_app:bindid-oidc,event_journey:idp_init\",\"data\":{\"__app_enrichment\":{\"session_id\":\"a15fc388-11ae-4245-8f13-d180979295a3\",\"client_id\":\"bid_demo_acme\"},\"assertion_id\":\"cV8bmSMqY0ou2yMXCUp18BjK\",\"device_public_key\":true},\"uri\":\"/api/v2/auth/assert?aid=bindid-oidc&did=6561ac5e-af8d-4ed6-996a-687fcf2279cf&sid=91d06084-ac10-4c90-978d-39c14862e2b3&locale=nl-NL\",\"ddsource\":\"bindid-authentication-server-activity-log\",\"service\":\"bindid-authentication-server\",\"action2\":\"wait_for_ticket\",\"user_id\":\"ac1e3db9-aa8c-4f56-96fa-1d4bd148dd6d\",\"time_lo_res\":1617352320000,\"status\":\"INFO\",\"action3\":\"action\",\"category\":\"user\",\"client_version\":\"6.0.0\",\"message\":\"Activity log assertion_start:wait_for_ticket:action, application: bindid-oidc, journey: idp_init\",\"time\":1617352354827,\"flow_id\":\"BID_e83a-ea19-40ae-afaf-1aa48c070340\",\"action\":\"assertion_start\",\"policy_version_id\":\"default_version\",\"client_ip\":\"136.143.103.234\",\"application_id\":\"bindid-oidc\",\"session_type\":\"web_anonymous\"})]", "2021-04-02 06:01:44.237 ERROR c.t.s.r.Routes:252 - 3318246130399841545 2684922623442837070 - [] [7ca08a_4297432] [BID_d9c6-3832-42e2-884f-c2d10bb318c1] [transmit-akka.actor.default-dispatcher-4] Request rejected; method: [POST], uri: [/api/v2/auth/login?aid=bindid-ama&did=8ae32b66-6fa1-4e39-a176-f9ac1d05cba0&locale=en-GB], statusCode: [401], errorCode: [4001], errorMessage: [Session rejected 'b0e97df0-75bb-4dbd-9481-026d8617c287'], data: [Some(RejectedAuthenticationResponseData(None,Some({\"source\":{\"action_type\":\"consume_ticket\",\"type\":\"action\"},\"reason\":{\"type\":\"cannot_consume_ticket\",\"data\":\"Ticket already consumed; tId: [ce7a91ed-4f9c-4a10-804a-e95beb13ee4c]\"}}),None))], sdk headers: [List()], millis: [127]", "2021-04-01 18:01:43.431 ERROR c.t.s.r.Routes:252 - 7835947361980812494 1517019791026302667 - [] [7ca08a_4198608] [BID_75b2-ed7c-4c54-a485-9e6fe6d2600d] [transmit-akka.actor.default-dispatcher-6] Request rejected; method: [POST], uri: [/api/v2/auth/login?aid=bindid-ama&did=9d7f10a9-b4d0-43a5-b8e4-5b566c2e7dcc&locale=es-ES], statusCode: [401], errorCode: [4001], errorMessage: [Session rejected 'debf7337-b077-4294-a423-0bb419da3861'], data: [Some(RejectedAuthenticationResponseData(None,Some({\"source\":{\"action_type\":\"reject\",\"type\":\"action\"},\"reason\":{\"type\":\"assertion_rejected\"}}),None))], sdk headers: [List()], millis: [83]", ]
      grok {
        support_rules = ""
        match_rules   = "all_rule %%{date(\"yyyy-MM-dd HH:mm:ss.SSS\"):date}\\s+%%{word:level}.*%%{regex(\"Expression evaluated to true|Received response|Sending request|Request rejected|Request ended|Request started\"):action}; %%{data::keyvalue(\": \", \"\", \"[]\")}"
      }
    }
  }

  processor {
    grok_parser {
      name       = "flow_id"
      is_enabled = true
      source     = "message"
      samples    = ["2021-04-02 08:32:34.828 DEBUG c.t.c.h.HttpUtils$:57 - 6252927043405491503 7134353032431869550 - [] [7ca08a_4319697] [BID_e83a-ea19-40ae-afaf-1aa48c070340] [transmit-akka.actor.default-dispatcher-4] Sending request; url: [https://http-intake.logs.datadoghq.com/v1/input], method: [POST], headers: [List((DD-API-KEY,a9c148505325b952e0fdd768261b6d18))], body: [Some({\"failure\":false,\"device_id\":\"6561ac5e-af8d-4ed6-996a-687fcf2279cf\",\"policy_id\":\"idp_init\",\"session_id\":\"3b091501-11e3-4c08-b296-f3fae87a25a2\",\"device_os_type\":\"Mac OS X\",\"hostname\":\"ts-sandbox-auth-control-5b5b979f7c-xdtq6\",\"device_hw_id\":\"0a8086199f0f7024edd00d5380c8fcb4\",\"device_session_id\":\"91d06084-ac10-4c90-978d-39c14862e2b3\",\"device_model\":\"Chrome 89.0\",\"ddtags\":\"env:sandbox,buid:ac1e3db9-aa8c-4f56-96fa-1d4bd148dd6d,event_action:assertion_start,event_app:bindid-oidc,event_journey:idp_init\",\"data\":{\"__app_enrichment\":{\"session_id\":\"a15fc388-11ae-4245-8f13-d180979295a3\",\"client_id\":\"bid_demo_acme\"},\"assertion_id\":\"cV8bmSMqY0ou2yMXCUp18BjK\",\"device_public_key\":true},\"uri\":\"/api/v2/auth/assert?aid=bindid-oidc&did=6561ac5e-af8d-4ed6-996a-687fcf2279cf&sid=91d06084-ac10-4c90-978d-39c14862e2b3&locale=nl-NL\",\"ddsource\":\"bindid-authentication-server-activity-log\",\"service\":\"bindid-authentication-server\",\"action2\":\"wait_for_ticket\",\"user_id\":\"ac1e3db9-aa8c-4f56-96fa-1d4bd148dd6d\",\"time_lo_res\":1617352320000,\"status\":\"INFO\",\"action3\":\"action\",\"category\":\"user\",\"client_version\":\"6.0.0\",\"message\":\"Activity log assertion_start:wait_for_ticket:action, application: bindid-oidc, journey: idp_init\",\"time\":1617352354827,\"flow_id\":\"BID_e83a-ea19-40ae-afaf-1aa48c070340\",\"action\":\"assertion_start\",\"policy_version_id\":\"default_version\",\"client_ip\":\"136.143.103.234\",\"application_id\":\"bindid-oidc\",\"session_type\":\"web_anonymous\"})]", "2021-04-20 13:57:40.596 DEBUG c.t.s.r.Routes:197 - 2213759799033874979 2629739892400426308 - [] [45fcf8_218579] [] [transmit-akka.actor.default-dispatcher-8] Request started; method: [POST], uri: [/api/v2/oidc/bindid-oidc/complete], headers: [List()], entity: [result=error&session_id=c9209be4-4275-4dcf-a990-78052cc9cf20&user_id=&auth_token=&error_message=something+went+wrong&flow_id=BID_89f0-204e-40b8-b4c5-a66767de1c17]", "2021-04-22 11:33:29.485 DEBUG c.t.s.r.Routes:220 - 2309803266800685809 7954816056821735249 - [] [45fcf8_435514] [BID_6223-6598-4869-94ab-85186433602a] [transmit-akka.actor.default-dispatcher-5] Request ended; method: [POST], uri: [/api/v2/auth/poll?aid=bindid-oidc&did=f510ec50-bfb9-4c42-be70-505e67fb06ad&sid=8440b22c-29a2-45ae-9415-b5c8b8ae4e2d&locale=en-US], headers: [List()], status: [200], millis: [3032], response: [{\"error_code\":0,\"error_message\":\"\",\"data\":{\"change_detected\":false},\"headers\":[]}].", ]
      grok {
        support_rules = ""
        match_rules   = <<EOF
get_bid1 [^\[]*(\[(?!BID)([^\[])*)*\[%%{regex("BID[^\\]]*"):flow_id}.*
get_bid2 .*%%{regex("flow_id")}=%%{regex("BID[^\\]]*"):flow_id}.*
EOF
      }
    }
  }

  dynamic "processor" {
    for_each = local.category_processors
    content {
      category_processor {
        name       = processor.value.name
        is_enabled = true
        target     = processor.value.target
        dynamic "category" {
          for_each = processor.value.definition
          content {
            filter {
              query = category.value.filter_query
            }
            name = category.value.name
          }
        }
      }
    }
  }

}