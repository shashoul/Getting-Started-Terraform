resource "datadog_logs_custom_pipeline" "pipeline_test1" {

  name       = "Java"
  is_enabled = true
  filter {
    query = "source:(bindid-auth-control OR bindid-authentication-server)"
  }
  processor {
    grok_parser {
      name       = "Parsing Java Default formats"
      is_enabled = true
      source     = "message"
      samples    = ["2000-09-07 14:07:41,508 [main] INFO  MyApp - Entering application.", "2021-02-10 11:34:34.650 DEBUG c.t.s.r.Routes:188 - 2423345208843846765 7675519259441776682 - [default] [2bce92_1686] [] [transmit-akka.actor.default-dispatcher-13] Request started; method: [GET], uri: [/api/v2/status], headers: [List()], entity: []", ]
      grok {
        support_rules = <<EOF
_date %%{date("yyyy-MM-dd HH:mm:ss.SSS"):timestamp}
_date_ms %%{date("yyyy-MM-dd HH:mm:ss,SSS"):timestamp}
_date_slf4j %%{date("yyyy-MM-dd HH:mm:ss.SSS"):timestamp}
_duration %%{integer:duration}
_thread_name %%{notSpace:logger.thread_name}
_status %%{word:level}
_logger_name %%{notSpace:logger.name}
_context %%{notSpace:logger.context}
_line %%{integer:line}

EOF
        match_rules   = <<EOF
java_default (%%{_date_ms}|%%{_duration})\s+\[%%{_thread_name}\]\s+%%{_status}\s+%%{_logger_name}\s*(%%{_context}\s*)?- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_slf4j %%{_date_slf4j}\s+\[%%{_thread_name}\]\s+%%{_status}\s+%%{_logger_name}\s*(%%{_context}\s*)?- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

ts_java_log4j %%{_date} %%{_status}\s+%%{_logger_name}:%%{_line}\s+- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - \[(%%{word:ts.realm})?\] \[(%%{word:ts.requestid})?\] (\[(%%{word:ts.flowid})?\] )?\[(%%{_thread_name})?\] )?%%{data:message}((\n|\t)%%{data:error.stack})?

java_log4j %%{_date} %%{_status}\s+%%{_logger_name}:%%{_line}\s+- (?>%%{word:dd.trace_id} %%{word:dd.span_id} - )?%%{data:message}((\n|\t)%%{data:error.stack})?

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

#Parse Java 11 GC logs formats
gc_new_format \[%%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}\]\[%%{notSpace:status}\]\[%%{notSpace:gc.type}(\s)?\]\sGC\(%%{number:gc.iteration}\)\s%%{data:gc.action}(\s%%{number:duration:scale(1000000)}ms)?

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
      name                 = "Set the datadog environment tag"
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
}