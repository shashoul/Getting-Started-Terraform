resource "datadog_logs_custom_pipeline" "pipeline_test6" {
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
        match_rules   = "all_rule %%{date(\"yyyy-MM-dd HH:mm:ss.SSS\"):date}\\s+%%{word:level}.*%%{regex(\"Expression evaluated to true|Received response|Sending request|Request rejected\"):action}; %%{data::keyvalue(\": \", \"\", \"[]\")}"
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
          query = "@message:*User?not?found*"
        }
        name = "User not found"
      }
      category {
        filter {
          query = "@message:*Device?not?found*"
        }
        name = "Device not found"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/auth\\/assert\\?aid=bindid-ama* AND @errorCode:4001 AND @message:*you?denied?the?request*"
        }
        name = "request has been denied"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize* AND @message:*invalid_client* AND @message:*Invalid?client?credentials*"
        }
        name = "Invalid client credentials"
      }
      category {
        filter {
          query = "@message:*client?returned?from?error"
        }
        name = "client returned from error"
      }
      category {
        filter {
          query = "@message:*cannot_consume_ticket*"
        }
        name = "cannot consume ticket"
      }
      category {
        filter {
          query = "(@uri:\\/api\\/v2\\/auth\\/assert\\?aid\\=bindid-oidc* OR @uri:\\/api\\/v2\\/auth\\/login\\?aid\\=bindid-oidc*) AND @errorCode:4001 AND @message:*Authentication?cancelled?by?the?user*"
        }
        name = "Authentication cancelled by the user"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/mng-ui\\/* AND @message:*Bad?administrator?session*"
        }
        name = "Bad administrator session"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/mng-ui\\/* AND @message:*Bad?credentials?provided*"
        }
        name = "Bad credentials provided"
      }
      category {
        filter {
          query = "@message:*Unknown?authorization?code*"
        }
        name = "Unknown authorization code"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/token AND @message:*error\\:?invalid_client*"
        }
        name = "invalid client"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/server-api\\/anonymous_invoke\\?aid\\=bindid-backend-api AND @message:*api_error_code\\:?invalid_auth*"
        }
        name = "invalid_auth"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/* AND @message:*error\\:?invalid_request* AND @message:*api_error_code\\:?alias_already_set*"
        }
        name = "invalid request - alias already set"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/token AND @message:*invalid_grant* AND @message:*Invalid?redirect?uri*"
        }
        name = "invalid_grant - invalid redirect uri"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/token AND @message:*unsupported_grant_type* AND @message:*Unsupported?grant?type*"
        }
        name = "unsupported grant type"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* AND @message:*invalid_request* AND @message:*Invalid?redirect?uri*"
        }
        name = "invalid request - invalid redirect uri"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* AND @message:*invalid_request* AND @message:*Missing?\\\"response_type\\\"*"
        }
        name = "invalid request - Missing response type"
      }
      category {
        filter {
          query = "@uri:\\/api\\/v2\\/oidc\\/bindid-oidc\\/authorize\\?* AND @message:*invalid_request* AND @message:*Missing?\\\"client_id\\\"*"
        }
        name = "invalid request - Missing client_id"
      }
      target = "error_category"
    }
  }
}