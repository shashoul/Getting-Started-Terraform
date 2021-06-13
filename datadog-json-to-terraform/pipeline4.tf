resource "datadog_logs_custom_pipeline" "pipeline_test4" {

  name       = "Datadog Agent"
  is_enabled = true
  filter {
    query = "source:(agent OR datadog-agent OR datadog-agent-cluster-worker OR datadog-cluster-agent OR process-agent OR security-agent OR system-probe OR trace-agent)"
  }
  processor {
    grok_parser {
      name       = "Parsing Datadog Agent logs"
      is_enabled = true
      source     = "message"
      samples    = ["2020-07-01 09:48:14 UTC | CORE | INFO | (pkg/collector/runner/runner.go:327 in work) | check:network,type:core | Done running check", "2020-09-15 10:00:07 UTC | CORE | INFO | (pkg/collector/python/datadog_agent.go:120 in LogMessage) | kafka_cluster_status:8ca7b736f0aa43e5 | (kafka_cluster_status.py:213) | Checking for out of sync partition replicas", "2019-04-08 13:53:48 UTC | TRACE | INFO | (pkg/trace/agent/agent.go:145 in loop) | exiting", "2019-02-01 16:59:41 UTC | INFO | (connection_manager.go:124 in CloseConnection) | Connection closed", "2020-11-18 10:31:13 UTC | JMX | INFO  | App | Successfully initialized instance: cassandra-localhost-7199", ]
      grok {
        support_rules = ""
        match_rules   = <<EOF
agent_rule         %%{date("yyyy-MM-dd HH:mm:ss z"):timestamp} \| %%{notSpace:agent} \| %%{word:level} \| \(%%{notSpace:filename}:%%{number:lineno} in %%{word:process}\) \|( %%{data::keyvalue(":")} \|)?( - \|)?( \(%%{notSpace:pyFilename}:%%{number:pyLineno}\) \|)?%%{data}
agent_rule_pre_611 %%{date("yyyy-MM-dd HH:mm:ss z"):timestamp} \| %%{word:level} \| \(%%{notSpace:filename}:%%{number:lineno} in %%{word:process}\)%%{data}
jmxfetch_rule      %%{date("yyyy-MM-dd HH:mm:ss z"):timestamp} \| %%{notSpace:agent} \| %%{word:level}\s+\| %%{word:class} \| %%{data}

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
      name       = "Define level as the official log status"
      is_enabled = true
      sources    = ["level", ]
    }
  }
}