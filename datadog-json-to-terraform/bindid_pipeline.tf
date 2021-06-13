resource "datadog_logs_custom_pipeline" "bindid_pipeline" {

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
    category_processor {
      name       = "Api Audience"
      is_enabled = true
      category {
        filter {
          query = "@uri: \\/api\\/v2\\/auth\\/* OR @uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize*"
        }
        name = "enduser"
      }
      category {
        filter {
          query = "-@uri:\\/api\\/v2\\/auth\\/* AND -@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize*"
        }
        name = "backend"
      }
      target = "api_audience"
    }
  }
  processor {
    category_processor {
      name       = "Error Category"
      is_enabled = true
      category {
        filter {
          query = "@message:*Request?started* @message:*anonymous_invoke* @message:*policy_request_id* @message:*ama-rejection-recovery*"
        }
        name = "Recovery Journey Invocations"
      }
      category {
        filter {
          query = "@uri:\"/api/v2/oidc/bindid-oidc/token\" @message:*unsupported_grant_type* @message:*Unsupported?grant?type*"
        }
        name = "Backend & Management - unsupported_grant"
      }
      category {
        filter {
          query = "@uri:\"/api/v2/oidc/bindid-oidc/token\" @message:*invalid_grant*"
        }
        name = "Backend & Management – invalid_grant"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize* @message:*invalid_client* @message:*Invalid?client?credentials*"
        }
        name = "End User - invalid_client"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* @message:*invalid_request* @message:*Invalid?redirect?uri*"
        }
        name = "Invalid Request - Invalid redirect URI on /authorize"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* @message:*invalid_request* @message:*Missing??\\\"client_id*"
        }
        name = "Invalid Request - Missing client_id on /authorize"
      }
      category {
        filter {
          query = "@uri:\"/api/v2/server-api/anonymous_invoke?aid=bindid-backend-api\" @message:*api_error_code?\\:?invalid_auth*"
        }
        name = "Invalid authentication to BindID Backend API"
      }
      category {
        filter {
          query = "@uri:\"/api/v2/oidc/bindid-oidc/token\" @message:*error?\\:?invalid_client*"
        }
        name = "Invalid client credentials on /token"
      }
      category {
        filter {
          query = "@message:*api_error_code* @message:*alias_already_set*"
        }
        name = "Number of \"Alias already set\" Errors"
      }
      category {
        filter {
          query = "(@uri:\\/api\\/v2\\/mng-ui\\/support\\/user* @message:*User?not?found*) OR (@uri:\\/api\\/v2\\/mng-ui\\/reports\\/user* @message:*User?not?found*)"
        }
        name = "User not found for backend/management support APIs"
      }
      category {
        filter {
          query = "(@uri:\\/api\\/v2\\/mng-ui\\/* @message:*Bad?administrator?session*) OR (@uri:\\/api\\/v2\\/mng-ui\\/* @message:*Bad?credentials?provided*)"
        }
        name = "Management Console Bad Logins"
      }
      category {
        filter {
          query = "@message:*\\\"assertion_error_code\\:9\\\"*"
        }
        name = "FIDO Registration Failures"
      }
      category {
        filter {
          query = "@statusCode:500 @uri:\\/api\\/v2\\/auth\\/* @message:*rejection\\:?MethodRejection*"
        }
        name = "Invalid HTTP Method: Frontend/End-User"
      }
      category {
        filter {
          query = "@statusCode:500 -@uri:\\/api\\/v2\\/auth\\/* @message:*rejection\\:?MethodRejection*"
        }
        name = "Invalid HTTP Method: Backend/Management"
      }
      category {
        filter {
          query = "@statusCode:500 @uri:(\\/api\\/v2\\/auth\\/* OR \"/api/v2/oidc/bindid-oidc/complete\") -@message:*rejection\\:?MethodRejection* -@message:*client?returned?from?error* -@message:*cannot_consume_ticket*"
        }
        name = "500: End-Users"
      }
      category {
        filter {
          query = "@statusCode:401 @message:*cannot_consume_ticket* status:error"
        }
        name = "Ticket consumption errors"
      }
      category {
        filter {
          query = "@statusCode:(400 OR 401 OR 404) ((@uri:\\/api\\/v2\\/auth\\/assert\\?aid\\=bindid-ama* @message:*bindid_error_user_declined_title*) OR (@uri:\\/api\\/v2\\/auth\\/assert\\?aid\\=bindid-oidc* @message:*Authentication?cancelled?by?the?user*) OR (@uri:\\/api\\/v2\\/auth\\/login\\?aid\\=bindid-oidc* @message:*Authentication?cancelled?by?the?user*)) @errorCode:4001"
        }
        name = "User Cancellation"
      }
      category {
        filter {
          query = "(@statusCode:500 OR @status:500) -@uri:\\/api\\/v2\\/auth\\/* -@uri:\"/api/v2/oidc/bindid-oidc/complete\" -@message:*rejection\\:?MethodRejection* -@message:*client?returned?from?error* -@message:*cannot_consume_ticket*"
        }
        name = "500: Backend & Management"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/auth\\/* (@statusCode:400 OR @statusCode:401 OR @statusCode:404 OR @status:(400 OR 401)) @message:*User?not?found*"
        }
        name = "User not found errors"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/auth\\/* (@statusCode:400 OR @statusCode:401 OR @statusCode:404 OR @status:(400 OR 401)) @message:*Device?not?found*"
        }
        name = "Device not found errors"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* @message:*invalid_request*"
        }
        name = "All Invalid Request Errors on /authorize"
      }
      category {
        filter {
          query = "@status:400 @message:*Unknown?authorization?code*"
        }
        name = "Unknown authorization code on /token"
      }
      category {
        filter {
          query = "@message:*Client?returned?with?error*"
        }
        name = "OIDC /complete with errors"
      }
      category {
        filter {
          query = "@message:*Unexpected?exception?during?field?resolution*"
        }
        name = "Expression evaluation errors"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/* @message:*error\\:?invalid_request*"
        }
        name = "OIDC Backend invalid_request errors"
      }
      target = "error_category"
    }
  }
}