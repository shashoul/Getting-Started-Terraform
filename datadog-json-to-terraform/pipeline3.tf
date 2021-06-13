resource "datadog_logs_custom_pipeline" "pipeline_test3" {

  name       = "CloudFront"
  is_enabled = true
  filter {
    query = "source:cloudfront"
  }
  processor {
    grok_parser {
      name       = "Parsing Web, RTMP and Real-Time logs"
      is_enabled = true
      source     = "message"
      samples    = ["2010-03-12	 23:51:20	 SEA4	 192.0.2.147	 connect	 2014	 OK	 bfd8a98bee0840d9b871b7f6ade9908f	 rtmp://shqshne4jdp4b6.cloudfront.net/cfx/st​	key=value	 http://player.longtailvideo.com/player.swf	 http://www.longtailvideo.com/support/jw-player-setup-wizard?example=204	 LNX%2010,0,32,18	 -	 -	 -	 -", "2019-12-17	16:36:45	LAX3-C3	418	167.216.131.180	POST	dqok34epbkzv2.cloudfront.net	/api/effu/back_office/environments/staging/pcdu/netsuite/record-change	401	-	NetSuite/2019.2%2520(SuiteScript)	-	-	Error	tiLX4Pye9scFGNb_tEnixIKN3hAW15drXcSeNG-xoFligmwedxjbbA==	www.farmersbusinessnetwork.com	https	934	0.067	-	TLSv1.2	ECDHE-RSA-AES128-GCM-SHA256	Error	HTTP/1.1	-	-	36798	0.067	Error	application/json	42	-	-", "2019-12-04	21:02:31    LAX1 392 192.0.2.100    GET d111111abcdef8.cloudfront.net  /index.html 200 -   Mozilla/5.0%2520(Windows%2520NT%252010.0;%2520Win64;%2520x64)%2520AppleWebKit/537.36%2520(KHTML,%2520like%2520Gecko)%2520Chrome/78.0.3904.108%2520Safari/537.36 -   -   Hit f37nTMVvnKvV2ZSvEsivup_c2kZ7VXzYdjC-GUQZ5qNs-89BlWazbw==    d111111abcdef8.cloudfront.net  https   23  0.001   -   TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 Hit HTTP/2.0    -   -   11040   0.001   Hit text/html   78  -   -", "1600299221.087	174.204.64.230	0.000	304	322	GET	https	preview.dashcon.io	/michaelw/real-time-logs-all_fields/2020/speakers/	637	SEA19-C2	eRwgLa8bR0pQBnbTFt_jIVY77WAfmcRuE980cPpEpGBcxrM6rq97vw==	d3gpvymg9z2unc.cloudfront.net	0.140	HTTP/2.0	IPv4	Mozilla/5.0%20(iPhone;%20CPU%20iPhone%20OS%2013_7%20like%20Mac%20OS%20X)%20AppleWebKit/605.1.15%20(KHTML,%20like%20Gecko)%20Version/13.1.2%20Mobile/15E148%20Safari/604.1	https://preview.dashcon.io/michaelw/real-time-logs-all_fields/2020/speakers/alex-landau/	-	-	RefreshHit	-	TLSv1.3	TLS_AES_128_GCM_SHA256	RefreshHit	-	-	-	-	-	-	10485	RefreshHit	US	gzip,%20deflate,%20br	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/michaelw/real-time-logs-all_fields/*	host:preview.dashcon.io%0Aaccept:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8%0Aaccept-encoding:gzip,%20deflate,%20br%0Aif-none-match:%22c223572e08c0fc3cde6d5416ff989957%22%0Aif-modified-since:Fri,%2011%20Sep%202020%2023:02:55%20GMT%0Auser-agent:Mozilla/5.0%20(iPhone;%20CPU%20iPhone%20OS%2013_7%20like%20Mac%20OS%20X)%20AppleWebKit/605.1.15%20(KHTML,%20like%20Gecko)%20Version/13.1.2%20Mobile/15E148%20Safari/604.1%0Aaccept-language:en-us%0Areferer:https://preview.dashcon.io/michaelw/real-time-logs-all_fields/2020/speakers/alex-landau/%0A	host%0Aaccept%0Aaccept-encoding%0Aif-none-match%0Aif-modified-since%0Auser-agent%0Aaccept-language%0Areferer%0Acookie%0A	9", "1600020865.895	67.183.143.147	0.168	200	31126	GET	https	preview.dashcon.io	/michaelw/real-time-logs-all_fields/2020/font/CalibreWeb-Medium.woff2	82	SFO20-C1	eR3FzjDcwV6Pq1BLuTy94PN9BicI_one9B4tC4ECGWrVfX4UsSBq_Q==	d3gpvymg9z2unc.cloudfront.net	0.237	HTTP/2.0	IPv4	Mozilla/5.0%20(Macintosh;%20Intel%20Mac%20OS%20X%2010_15_6)%20AppleWebKit/537.36%20(KHTML,%20like%20Gecko)%20Chrome/85.0.4183.83%20Safari/537.36	https://preview.dashcon.io/michaelw/real-time-logs-all_fields/2020/static/style.8fb2b.css	-	-	Miss	-	TLSv1.3	TLS_AES_128_GCM_SHA256	Miss	-	-	font/woff2	30736	-	-	51179	Miss	US	gzip,%20deflate,%20br	*/*	/michaelw/real-time-logs-all_fields/*	host:preview.dashcon.io%0Aorigin:https://preview.dashcon.io%0Adpr:2%0Auser-agent:Mozilla/5.0%20(Macintosh;%20Intel%20Mac%20OS%20X%2010_15_6)%20AppleWebKit/537.36%20(KHTML,%20like%20Gecko)%20Chrome/85.0.4183.83%20Safari/537.36%0Aviewport-width:1440%0Aaccept:*/*%0Asec-fetch-site:same-origin%0Asec-fetch-mode:cors%0Asec-fetch-dest:font%0Areferer:https://preview.dashcon.io/michaelw/real-time-logs-all_fields/2020/static/style.8fb2b.css%0Aaccept-encoding:gzip,%20deflate,%20br%0Aaccept-language:en-US,en;q=0.9%0A	host%0Aorigin%0Adpr%0Auser-agent%0Aviewport-width%0Aaccept%0Asec-fetch-site%0Asec-fetch-mode%0Asec-fetch-dest%0Areferer%0Aaccept-encoding%0Aaccept-language%0Acookie%0A	13", ]
      grok {
        support_rules = <<EOF
_request_id %%{notSpace:http.request_id:nullIf("-")}
_client_id %%{notSpace:network.client.id}
_bytes_write %%{integer:network.bytes_written}
_bytes_read %%{integer:network.bytes_read}
_client_ip %%{ip:network.client.ip}
_client_port (%%{port:network.client.port:number}|-)
_url %%{notSpace:http.url}
_version HTTP\/%%{regex("\\d+\\.\\d+"):http.version}
_user_agent %%{regex("[^\\t\\\"]*"):http.useragent}
_referer %%{notSpace:http.referer:nullIf("-")}
_status_code %%{integer:http.status_code}
_ident %%{notSpace:http.ident:nullIf("-")}
_method %%{word:http.method}
_duration %%{number:duration:scale(1000000000)}
_date_access %%{date("yyyy-MM-dd HH:mm:ss"):date_access}
_ssl_cipher %%{notSpace:http.ssl.cipher:nullIf("-")}
_ssl_protocol %%{notSpace:http.ssl.protocol:nullIf("-")}
_x_forwarded_for %%{notSpace:http._x_forwarded_for:nullIf("-")}
_fle_status %%{notSpace:security.fle_status:nullIf("-")}
_fle_encrypted_fields (%%{number:security.fle_encrypted_fields}|-)
_time_to_first_byte (%%{number:http.time_to_first_byte}|-)
_x_edge_detailed_result_type %%{notSpace:http.x_edge_detailed_result_type:nullIf("-")}
_sc_content_type %%{notSpace:http.resource.content_type:nullIf("-")}
_sc_content_len (%%{number:http.resource.content_length}|-)
_sc_range_start (%%{number:http.sc_range_start}|-)
_sc_range_end (%%{number:http.sc_range_end}|-)

EOF
        match_rules   = <<EOF
# Complete rule added on 18/12/19 to sync new fields added by AWS
web_distribution_complete (%%{_date_access}|%%{date("yyyy-MM-dd'	'HH:mm:ss"):date_access})\s+%%{notSpace:cloudfront.edge-location}\s+%%{_bytes_write}\s+%%{_client_ip}\s+%%{_method}\s+%%{notSpace:http.url_details.host}\s+%%{notSpace:http.url_details.path}\s+%%{_status_code}\s+%%{_referer}\s+%%{_user_agent}\s+%%{notSpace:http.url_details.queryString:querystring}\s+%%{notSpace:cloudfront.cookie}\s+%%{word:cloudfront.edge-result-type}\s+%%{_request_id}\s+%%{_ident}\s+%%{notSpace:http.url_details.scheme}\s+(%%{_bytes_read}|-)\s+%%{_duration}\s+%%{_x_forwarded_for}\s+%%{_ssl_protocol}\s+%%{_ssl_cipher}\s+%%{notSpace:cloudfront.edge-response-result-type}\s+%%{_version}\s+%%{_fle_status}\s+%%{_fle_encrypted_fields}\s+%%{_client_port}\s+%%{_time_to_first_byte}\s+%%{_x_edge_detailed_result_type}\s+%%{_sc_content_type}\s+%%{_sc_content_len}\s+%%{_sc_range_start}\s+%%{_sc_range_end}.*
web_distribution (%%{_date_access}|%%{date("yyyy-MM-dd'	'HH:mm:ss"):date_access})\s+%%{notSpace:cloudfront.edge-location}\s+%%{_bytes_write}\s+%%{_client_ip}\s+%%{_method}\s+%%{notSpace:http.url_details.host}\s+%%{notSpace:http.url_details.path}\s+%%{_status_code}\s+%%{_referer}\s+%%{_user_agent}\s+%%{notSpace:http.url_details.queryString:querystring}\s+%%{notSpace:cloudfront.cookie}\s+%%{word:cloudfront.edge-result-type}\s+%%{_request_id}\s+%%{_ident}\s+%%{notSpace:http.url_details.scheme}\s+(%%{_bytes_read}|-)\s+%%{_duration}\s+%%{_x_forwarded_for}\s+%%{_ssl_protocol}\s+%%{_ssl_cipher}\s+%%{notSpace:cloudfront.edge-response-result-type}\s+%%{_version}.*
rtmp_distribution %%{date("yyyy-MM-dd'	 'HH:mm:ss"):date_access}\s+%%{notSpace:cloudfront.edge-location}\s+%%{_client_ip}\s+%%{_method}\s*%%{_bytes_write}\s+%%{word:cloudfront.status}\s+%%{_client_id}\s+%%{_ident}\s+%%{notSpace:http.url_details.queryString:querystring}\s+%%{_referer}\s+%%{_url}\s+%%{_user_agent}\s+%%{notSpace:cloudfront.stream.name:nullIf("-")}\s+%%{notSpace:cloudfront.stream.queryString:querystring}\s+%%{notSpace:cloudfront.stream.type:nullIf("-")}\s+%%{notSpace:cloudfront.stream.id:nullIf("-")}.*
real_time_logs (%%{number:timestamp:scale(1000)}|%%{number:timestamp})\s+%%{_client_ip}\s+%%{_time_to_first_byte}\s+%%{_status_code}\s+%%{_bytes_write}\s+%%{_method}\s+%%{regex("[a-z]*"):http.url_details.scheme}\s+%%{notSpace:http.url_details.host:nullIf("-")}\s+%%{notSpace:http.url_details.path:nullIf("-")}\s+%%{_bytes_read}\s+%%{notSpace:cloudfront.edge-location:nullIf("-")}\s+%%{_request_id}\s+%%{_ident}\s+%%{_duration}\s+%%{_version}\s+IPv%%{integer:network.client.ip_version}\s+%%{_user_agent}\s+%%{_referer}\s+%%{notSpace:cloudfront.cookie}\s+(%%{notSpace:http.url_details.queryString:querystring}|%%{notSpace:http.url_details.queryString:nullIf("-")})\s+%%{notSpace:cloudfront.edge-response-result-type:nullIf("-")}\s+%%{_x_forwarded_for}\s+%%{_ssl_protocol}\s+%%{_ssl_cipher}\s+%%{notSpace:cloudfront.edge-result-type:nullIf("-")}\s+%%{_fle_encrypted_fields}\s+%%{_fle_status}\s+%%{_sc_content_type}\s+%%{_sc_content_len}\s+%%{_sc_range_start}\s+%%{_sc_range_end}\s+%%{_client_port}\s+%%{_x_edge_detailed_result_type}\s+%%{notSpace:network.client.country:nullIf("-")}\s+%%{notSpace:accept-encoding:nullIf("-")}\s+%%{notSpace:accept:nullIf("-")}\s+%%{notSpace:cache-behavior-path-pattern:nullIf("-")}\s+%%{notSpace:headers:nullIf("-")}\s+%%{notSpace:header-names:nullIf("-")}\s+%%{integer:headers-count}.*

EOF
      }
    }
  }
  processor {
    user_agent_parser {
      name       = ""
      is_enabled = true
      sources    = ["http.useragent", ]
      target     = "http.useragent_details"
      is_encoded = false
    }
  }
  processor {
    date_remapper {
      name       = "Define Date_access as the official timestamp of the log"
      is_enabled = true
      sources    = ["date_access", "timestamp", ]
    }
  }
  processor {
    category_processor {
      name       = "Categorise status code"
      is_enabled = true
      category {
        filter {
          query = "@http.status_code:[200 TO 299]"
        }
        name = "OK"
      }
      category {
        filter {
          query = "@http.status_code:[300 TO 399]"
        }
        name = "notice"
      }
      category {
        filter {
          query = "@http.status_code:[400 TO 499]"
        }
        name = "warning"
      }
      category {
        filter {
          query = "@http.status_code:[500 TO 599]"
        }
        name = "error"
      }
      target = "http.status_category"
    }
  }
  processor {
    status_remapper {
      name       = "Set the log status based on the status code value"
      is_enabled = true
      sources    = ["http.status_category", ]
    }
  }
}