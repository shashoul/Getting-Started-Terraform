resource "datadog_logs_custom_pipeline" "pipeline_test5" {

  name       = "Java"
  is_enabled = true
  filter {
    query = "source:bindid-authentication-server"
  }
  processor {
    grok_parser {
      name       = "Parsing Java Default formats"
      is_enabled = true
      source     = "message"
      samples    = ["2000-09-07 14:07:41,508 [main] INFO  MyApp - Entering application.", "54 [main] INFO MyApp.foo.bar - Entering application.", "2000-09-07 14:07:44 INFO org.foo.bar:32 - Entering application.", "2000-09-07 14:07:44.452 [main] INFO org.foo.bar - Entering application.", ]
      grok {
        support_rules = <<EOF
_date %%{date("yyyy-MM-dd HH:mm:ss.SSS"):timestamp}
_date_ms %%{date("yyyy-MM-dd HH:mm:ss.SSS"):timestamp}
_date_slf4j %%{date("yyyy-MM-dd HH:mm:ss.SSS"):timestamp}
_duration %%{integer:duration}
_thread_name %%{notSpace:logger.thread_name}
_status %%{word:level}
_logger_name %%{notSpace:logger.name}
_context %%{notSpace:logger.context}
_line %%{integer:line}

EOF
        match_rules   = <<EOF
ajava_log4j %%{_date} %%{_status}\s+%%{_logger_name}:%%{_line}\s+- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - \[%%{word:ts.realm}\] \[%%{word:ts.requestid}\] \[%%{_thread_name}\] )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_log4j %%{_date} %%{_status}\s+%%{_logger_name}:%%{_line}\s+- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_slf4j %%{_date_slf4j}\s+\[%%{_thread_name}\]\s+%%{_status}\s+%%{_logger_name}\s*(%%{_context}\s*)?- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_default (%%{_date_ms}|%%{_duration})\s+\[%%{_thread_name}\]\s+%%{_status}\s+%%{_logger_name}\s*(%%{_context}\s*)?- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_fallback (%%{_date}|%%{_date_ms}) %%{_status}\s+(?>%%{word:dd.trace_id} %%{word:dd.span_id} )?%%{data:message}((\n|\t)%%{data:error.stack})?



EOF
      }
    }
  }
  processor {
    grok_parser {
      name       = "Parsing GC logs"
      is_enabled = true
      source     = "message"
      samples    = ["[9237.485s][info   ][gc] GC(835) Pause Young (G1 Evacuation Pause) 4937M->645M(7168M) 17.476ms", "2019-03-20T14:36:30.111+0000: 41.098: [GC concurrent-mark-end, 0.0272767 secs]", "2019-03-20T14:36:30.111+0000: 41.071: [GC concurrent-mark-start]", "2019-03-20T14:36:30.111+0000: 41.099: [Finalize Marking, 0.0011661 secs]", ]
      grok {
        support_rules = <<EOF
_gc_event_phase_duration %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}: %%{notSpace}\s\[GC\s%%{notSpace:gc.action}(\s%%{regex("([^,]*)"):gc.phase},)?(\s%%{number:duration:scale(1000000000)}\ssecs)?]

_parallel \[Parallel\sTime:\s%%{number:parallel_time}\sms,\sGC\sWorkers:\s%%{number:gc_worker.count}]

_gc_worker_start \[GC\sWorker\sStart\s\(ms\):\sMin:\s%%{number:gc_worker.start.min},\sAvg:\s%%{number:gc_worker.start.avg},\sMax:\s%%{number:gc_worker.start.max},\sDiff:\s%%{number:gc_worker.start.diff}]

_ext_root_scanning \[Ext\sRoot\sScanning\s\(ms\):\sMin:\s%%{number:exit_root_scanning.min},\sAvg:\s%%{number:exit_root_scanning.avg},\sMax:\s%%{number:exit_root_scanning.max},\sDiff:\s%%{number:exit_root_scanning.diff},\sSum:\s%%{number:exit_root_scanning.sum}]

_update_rs \[Update\sRS\s\(ms\):\sMin:\s%%{number:update_rs.min},\sAvg:\s%%{number:update_rs.avg},\sMax:\s%%{number:update_rs.max},\sDiff:\s%%{number:update_rs.diff},\sSum:\s%%{number:update_rs.sum}]

_gcc_event %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}:%%{notSpace}\s\[%%{regex("([^\\]]*)"):event.type}]

_processed_buffer \[Processed\sBuffers:\sMin:\s%%{number:processed_buffer.min},\sAvg:\s%%{number:processed_buffer.avg},\sMax:\s%%{number:processed_buffer.max},\sDiff:\s%%{number:processed_buffer.diff},\sSum:\s%%{number:processed_buffer.sum}]

_scan_rs \[Scan\sRS\s\(ms\):\sMin:\s%%{number:scan_rs.min},\sAvg:\s%%{number:scan_rs.avg},\sMax:\s%%{number:scan_rs.max},\sDiff:\s%%{number:scan_rs.diff},\sSum:\s%%{number:scan_rs.sum}]

_code_root_scan \[Code\sRoot\sScanning\s\(ms\):\sMin:\s%%{number:code_root.scan.min},\sAvg:\s%%{number:code_root.scan.avg},\sMax:\s%%{number:code_root.scan.max},\sDiff:\s%%{number:code_root.scan.diff},\sSum:\s%%{number:code_root.scan.sum}]

_object_copy \[Object\sCopy\s\(ms\):\sMin:\s%%{number:object_copy.min},\sAvg:\s%%{number:object_copy.avg},\sMax:\s%%{number:object_copy.max},\sDiff:\s%%{number:object_copy.diff},\sSum:\s%%{number:object_copy.sum}]

_termination \[Termination\s\(ms\):\sMin:\s%%{number:termination.min},\sAvg:\s%%{number:termination.avg},\sMax:\s%%{number:termination.max},\sDiff:\s%%{number:termination.diff},\sSum:\s%%{number:termination.sum}]

_termination_attempts \[Termination\sAttempts:\sMin:\s%%{number:termination.attempts.min},\sAvg:\s%%{number:termination.attempts.avg},\sMax:\s%%{number:termination.attempts.max},\sDiff:\s%%{number:termination.attempts.diff},\sSum:\s%%{number:termination.attempts.sum}]

_gc_worker_other \[GC\sWorker\sOther\s\(ms\):\sMin:\s%%{number:gc_worker.other.min},\sAvg:\s%%{number:gc_worker.other.avg},\sMax:\s%%{number:gc_worker.other.max},\sDiff:\s%%{number:gc_worker.other.diff},\sSum:\s%%{number:gc_worker.other.sum}]

_gc_worker_total \[GC\sWorker\sTotal\s\(ms\):\sMin:\s%%{number:gc_worker.total.min},\sAvg:\s%%{number:gc_worker.total.avg},\sMax:\s%%{number:gc_worker.total.max},\sDiff:\s%%{number:gc_worker.total.diff},\sSum:\s%%{number:gc_worker.total.sum}]

_gc_worker_end \[GC\sWorker\sEnd\s\(ms\):\sMin:\s%%{number:gc_worker.end.min},\sAvg:\s%%{number:gc_worker.end.avg},\sMax:\s%%{number:gc_worker.end.max},\sDiff:\s%%{number:gc_worker.end.diff}]

_code_root_fixup \[Code\sRoot\sFixup:\s%%{number:code_root.fixup}\sms]

_code_root_purge \[Code\sRoot\sPurge:\s%%{number:code_root.purge}\sms]

_clear_ct \[Clear\sCT:\s%%{number:clear_ct}\sms]

_other \[Other:\s%%{number:other}\sms]

_choose_cset \[Choose\sCSet:\s%%{number:choose_cset}\sms]

_ref_proc \[Ref\sProc:\s%%{number:ref.proc}\sms]

_ref_enq \[Ref\sEnq:\s%%{number:ref.enq}\sms]

_redirty_cards \[Redirty\sCards:\s%%{number:redirty_cards}\sms]

_humongous_register \[Humongous\sRegister:\s%%{number:humongous_register}\sms]

_humongous_reclaim \[Humongous\sReclaim:\s%%{number:humongous_reclaim}\sms]

_free \[Free\sCSet:\s%%{number:free}\sms]

_memory_usage \[Eden: (%%{number:eden.memory_before}M|%%{number:eden.memory_before:scale(1000)}G)\((%%{number:eden.memory_allocated_before}M|%%{number:eden.memory_allocated_before:scale(1000)}G)\)->%%{number:eden.memory_after}B\((%%{number:eden.memory_allocated_after}M|%%{number:eden.memory_allocated_after:scale(1000)}G)\)\sSurvivors:\s%%{number:survivor.memory_before}M->%%{number:survivor.memory_after}M\sHeap:\s(%%{number:heap.memory_before}M|%%{number:heap.memory_before:scale(1000)}G)\((%%{number:heap.memory_allocated_before}M|%%{number:heap.memory_allocated_before:scale(1000)}G)\)->%%{number:heap.memory_after}M\((%%{number:heap.memory_allocated_after}M|%%{number:heap.memory_allocated_after:scale(1000)}G)\)]

_times \[Times:\suser=%%{number:times.user}\ssys=%%{number:times.system},\sreal=%%{number:times.real}\ssecs]

EOF
        match_rules   = <<EOF

gc_nonverbose_basic \[%%{notSpace}\]\[%%{word:level}\s*\]\[%%{word:gc.type}\] GC\(%%{number:gc.iteration}\) %%{data:gc.action} \(%%{data:gc.phase}\) %%{number:heap.memory_before}M\-\>%%{number:heap.memory_after}M\(%%{number:heap.memory_total}M\) %%{number:duration:scale(1000000)}ms

gc_action_phase_duration %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}: %%{notSpace}\s\[GC\s%%{notSpace:gc.action}(\s%%{regex("([^,]*)"):gc.phase},)?(\s%%{number:duration:scale(1000000000)}\ssecs)?]

non_gc_action_duration %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}: %%{notSpace}\s\[%%{regex("([^,]*)"):gc.action}(,\s%%{number:duration:scale(1000000000)}\ssecs)?]

gc_verbose %%{_gc_event_phase_duration}(\r|\n|\s)*%%{_parallel}(\r|\n|\s)*%%{_gc_worker_start}(\r|\n|\s)*%%{_ext_root_scanning}(\r|\n|\s)*%%{_update_rs}(\r|\n|\s)*%%{_processed_buffer}(\r|\n|\s)*%%{_scan_rs}(\r|\n|\s)*%%{_code_root_scan}(\r|\n|\s)*%%{_object_copy}(\r|\n|\s)*%%{_termination}(\r|\n|\s)*%%{_termination_attempts}(\r|\n|\s)*%%{_gc_worker_other}(\r|\n|\s)*%%{_gc_worker_total}(\r|\n|\s)*%%{_gc_worker_end}(\r|\n|\s)*%%{_code_root_fixup}(\r|\n|\s)*%%{_code_root_purge}(\r|\n|\s)*%%{_clear_ct}(\r|\n|\s)*%%{_other}(\r|\n|\s)*%%{_choose_cset}(\r|\n|\s)*%%{_ref_proc}(\r|\n|\s)*%%{_ref_enq}(\r|\n|\s)*%%{_redirty_cards}(\r|\n|\s)*%%{_humongous_register}(\r|\n|\s)*%%{_humongous_reclaim}(\r|\n|\s)*%%{_free}(\r|\n|\s)*%%{_memory_usage}(\r|\n|\s)*%%{_times}

EOF
      }
    }
  }
  processor {
    date_remapper {
      name       = "Define timestamp as the official timestamp of the log"
      is_enabled = true
      sources    = ["timestamp", ]
    }
  }
  processor {
    status_remapper {
      name       = "Define level as the official status of the log"
      is_enabled = true
      sources    = ["level", ]
    }
  }
  processor {
    trace_id_remapper {
      name       = "Define dd.trace_id as the official trace id associate to this log"
      is_enabled = true
      sources    = ["dd.trace_id", ]
    }
  }
  processor {
    attribute_remapper {
      name                 = "stack_trace to error.stack"
      is_enabled           = true
      sources              = ["stack_trace", ]
      source_type          = "attribute"
      target               = "error.stack"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
    }
  }
  processor {
    attribute_remapper {
      name                 = "logger_name to logger.name"
      is_enabled           = true
      sources              = ["logger_name", "loggerName", ]
      source_type          = "attribute"
      target               = "logger.name"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
    }
  }
  processor {
    attribute_remapper {
      name                 = "thread_name to logger.thread_name"
      is_enabled           = true
      sources              = ["thread_name", ]
      source_type          = "attribute"
      target               = "logger.thread_name"
      target_type          = "attribute"
      preserve_source      = false
      override_on_conflict = false
    }
  }
  processor {
    grok_parser {
      name       = "Parsing Java Stack traces"
      is_enabled = true
      source     = "error.stack"
      samples    = []
      grok {
        support_rules = ""
        match_rules   = <<EOF
error_rule %%{notSpace:error.kind}: %%{data:error.message}(\n|\t).*

EOF
      }
    }
  }
  processor {
    arithmetic_processor {
      name               = "Calculate GC memory freed"
      is_enabled         = true
      expression         = "(heap.memory_before - heap.memory_after)"
      target             = "gc.memory_freed"
      is_replace_missing = false
    }
  }
  processor {
    attribute_remapper {
      name                 = "Set the datadog environemnt tag"
      is_enabled           = true
      sources              = ["dd.env", "contextMap.dd.env", ]
      source_type          = "attribute"
      target               = "env"
      target_type          = "tag"
      preserve_source      = false
      override_on_conflict = true
    }
  }
  processor {
    attribute_remapper {
      name                 = "Set the datadog version tag"
      is_enabled           = true
      sources              = ["dd.version", "contextMap.dd.version", ]
      source_type          = "attribute"
      target               = "version"
      target_type          = "tag"
      preserve_source      = false
      override_on_conflict = true
    }
  }
  processor {
    service_remapper {
      name       = "Define app as the official service of the log"
      is_enabled = true
      sources    = ["dd.service", "contextMap.dd.service", ]
    }
  }
  processor {
    pipeline {
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
  }
}