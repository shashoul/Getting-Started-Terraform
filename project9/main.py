import json
import importlib
from definitions import DASHBOARD
from utils import assignmentString


def block(name, contents):
    res = ""
    res += f'\n {name} ' + '{'
    for key, val in contents.items():
        res += assignmentString(key, val)
    return res + '\n } '


def block_list(name, contents):
    res = ""
    for elm in contents:
        res += block(name, elm)
    return res


##################
def block_elements(name, content, converter):
    res =""
    res += f'\n {name} ' + '{'
    for key, val in content.items():
        res += converter(key, val)
    return res + '\n } '


################
def block_list_elements(name, content, converter):
    res = ""
    for elm in content:
        res += block_elements(name, elm, converter)
    return res


def template_variables(key, val):
    res = ""
    for elm in val:
        res += block("template_variable", elm)    
    return res


def template_variable_preset(key, val):
    res = ""
    for k, v in val.items():
        if k == "name":
            res += assignmentString(k, v)
        elif k == "template_variables":
            # res += template_variables(k, v)
            res += block_list_elements("template_variable", v, assignmentString)
    return res


def convertSort(content):
    res = ""
    if isinstance(content,str):
        res += assignmentString("sort", content)
    else:
        res += block_list("sort", content)
    return res


def group_by_block(content):
    res = f'\n group_by ' + '{'
    for k, v in content.items():
        if k in ["sort"]:
            res += block("sort_query", v)
        elif k in ["sort_query"]:
            res += block(k,v)
        else:
            res += assignmentString(k,v)
    return f'{res} \n }} '

    
def group_by_blocks(content):
    res = ""
    for elm in content:
        res += group_by_block(elm)
    return res


######################
def group_by_schema(key, val):
    res = ""
    if key in ["sort"]:
        res += block_elements("sort_query", val, assignmentString)
    elif key in ["sort_query"]:
        res += block_elements("sort_query", val, assignmentString)
    else:
        res += assignmentString(key, val)
    return res


def log_query_block(content):
    res = f'\n log_query ' + '{'
    for k, v in content.items():
        if k in ["search"]:
            res += assignmentString("search_query",v["query"])
        elif k in ["compute"]:
            res += block("compute_query",v)
        elif k in ["compute_query"]:
            res += block(k,v)
        elif k in ["multi_compute"]:
            pass
        elif k in ["group_by"]:
            res += group_by_blocks(v)
        else:
            res += assignmentString(k,v)
    return f'{res} \n }} '


def rum_query_block(content):
    res = f'\n rum_query ' + '{'
    for k, v in content.items():
        if k in ["search"]:
            res += assignmentString("search_query",v["query"])
        elif k in ["compute"]:
            res += block("compute_query",v)
        elif k in ["compute_query"]:
            res += block(k,v)
        elif k in ["multi_compute"]:
            pass
        elif k in ["group_by"]:
            res += group_by_blocks(v)
        else:
            res += assignmentString(k,v)
    return f'{res} \n }} '


def fill_block(content):
    res = f'\n fill ' + '{'
    for k,v in content.items():
        if k in ["apm_query"]:
            pass
        elif k in ["log_query"]:
            res += log_query_block(v)
        elif k in ["process_query"]:
            pass
        elif k in ["rum_query"]:
            res += rum_query_block(v)
        elif k in ["security_query"]:
            pass
        else:
            res += assignmentString(k,v)
    return f'{res} \n }} '

    
def requests_blocks(content):
    res = f'\n request ' + '{'
    for k, v in content.items():
        if k in ["style"]:
            res += block(k,v)
        elif k in ["metadata","conditional_formats"]:
            res += block_list(k,v)
        elif k in ["log_query"]:
            res += log_query_block(v)
        elif k in ["rum_query"]:
            res += rum_query_block(v)
        elif k in ["fill"]:
            res += fill_block(v)
        elif k in ["profile_metrics_query"]:
            pass      ## Unsupported block type
        else:
            res += assignmentString(k,v)
    return res + '\n } '


##################
def request_block_nested(key, val):
    res = ""
    if key in ["apm_query"]:
        pass
    # elif key in ["log_query"]:
    #     res += log_query_block(val)
    # elif key in ["process_query"]:
    #     pass
    # elif key in ["rum_query"]:
    #     res += rum_query_block(val)
    # elif key in ["security_query"]:
    #     pass
    # elif key in ["sort"]:
    #     res += block("sort_query", val)
    # elif key in ["sort_query"]:
    #     res += block(key,val)
    elif key in ["search"]:
        res += assignmentString("search_query",val["query"])
    elif key in ["compute"]:
        res += block("compute_query",val)
    elif key in ["compute_query"]:
        res += block(key,val)
    elif key in ["multi_compute"]:
        pass
    elif key in ["group_by"]:
        # res += group_by_blocks(val)
        res += block_list_elements("group_by", val, group_by_schema)
    else:
        res += assignmentString(key,val)
    return res


###################
def request_block_converter(key, val):
    res = ""
    if key in ["style"]:
        # res += block(key,val)
        res += block_elements(key, val, assignmentString)
    elif key in ["process_query"]:
        res += block_elements(key, val, assignmentString)
    elif key in ["apm_stats_query"]:
        res += block_elements(key, val, assignmentString)
    elif key in ["metadata","conditional_formats"]:
        # res += block_list(key,val)
        res += block_list_elements(key, val, assignmentString)
    elif key in ["log_query"]:
        # res += log_query_block(val)
        res += block_elements("log_query", val, request_block_nested)
    elif key in ["rum_query"]:
        res += block_elements("rum_query", val, request_block_nested)
    elif key in ["apm_query"]:
        res += block_elements("apm_query", val, request_block_nested)
    elif key in ["rum_query"]:
        # res += rum_query_block(val)
        res += block_elements("rum_query", val, request_block_nested)
    elif key in ["security_query"]:
        res += block_elements("security_query", val, request_block_nested)
    elif key in ["network_query"]:
        res += block_elements("network_query", val, request_block_nested)
    elif key in ["fill"]:
        # res += fill_block(val)
        # res += block_elements("fill", val, request_block_nested)
        res += block_elements("fill", val, request_block_converter)
    elif key in ["size"]:
        res += block_elements("size", val, request_block_converter)
    elif key in ["profile_metrics_query"]:
        pass      ## Unsupported block type
    else:
        res += assignmentString(key,val)
    return res


def requests(contents):
    res = ""
    for elm in contents:
        res += requests_blocks(elm)
    return res


def widgets_definition(contents):
    res = ""
    for k , v in contents.items():
        if k in ["type","legend_layout","legend_columns","global_time_target","reflow_type"]:
            pass
        elif k == "custom_links":
            # res += block_list("custom_link",v)
            res += block_list_elements("custom_link", v, assignmentString)
        elif k == "requests":
            # res += requests(v) if isinstance(v,list) else requests_blocks(v)
            res += block_list_elements("request", v, request_block_converter) if isinstance(v,list) else block_elements("request", v, request_block_converter)
        elif k == "widgets":
            # res += widgets(k,v)
            res += block_list_elements("widget", v, widget_block)
        elif k == "sort":
            convertSort(v)
        elif k in ["event", "right_yaxis", "widget_layout", "xaxis", "yaxis", "style"]:
            res += block_elements(k, v, assignmentString)     
        # elif k == "event":
        #     # res += block("event", v)
        #     res += block_elements("event", v, assignmentString)
        elif k == "events":
            # res += block_list("event",v)
            res += block_list_elements("event", v, assignmentString)
        elif k == "markers":
            # res += block_list("marker",v)
            res += block_list_elements("marker", v, assignmentString)
        # elif k == "right_yaxis":
        #     # res += block("right_yaxis", v)
        #     res += block_elements("right_yaxis", v, assignmentString)
        # elif k == "widget_layout":
        #     # res += block("widget_layout", v)
        #     res += block_elements("widget_layout", v, assignmentString)
        # elif k == "xaxis":
        #     # res += block("xaxis", v)
        #     res += block_elements("xaxis", v, assignmentString)
        # elif k == "yaxis":
        #     # res += block("yaxis", v)
        #     res += block_elements("yaxis", v, assignmentString)
        # elif k == "style":
        #     # res += block("style", v)
        #     res += block_elements("style", v, assignmentString)
        elif k == "time":
            res += assignmentString("live_span",v["live_span"])
        elif k == "autoscale":
            print(v)
            res += assignmentString(k,v)
        else:
            res += assignmentString(k,v)
    definition_type = "service_level_objective" if contents["type"] == "slo" else contents["type"]
    return f'\n {definition_type}_definition ' + '{ ' + f'{res} \n' + '}'


def widgets_blocks(val):
    res = f'\n widget ' + '{'
    for k, v in val.items():
        if k in ["id"]:
            pass
        elif k == "definition":
            res += widgets_definition(v)
        elif k == "layout":
            res += block("widget_layout", v)
    return res + '\n } '


def widgets(key, val):
    res = ""
    for elm in val:
        res += widgets_blocks(elm)
    return res


###########################
def widget_block(key, val):
    res = ""
    if key in ["id"]:
        pass
    elif key == "definition":
        res += widgets_definition(val)
    elif key == "layout":
        # res += block("widget_layout", val)
        res += block_elements("widget_layout", val, assignmentString)
    return res


def generateDashboardTerraformCode(dashboardData):
    res = ""
    for key, val in dashboardData.items():
        print(key, val)
        if key in ["id","reflow_type"]:
            pass
        elif key == "widgets":
            # res += widgets(key, val)
            res += block_list_elements("widget", val, widget_block)
        elif key == "template_variables":
            # res += template_variables(key, val)
            res += block_list_elements("template_variable", val, assignmentString)
        elif key == "template_variable_presets":
            res += block_list_elements("template_variable_preset", val, template_variable_preset)
        else:
            res += assignmentString(key,val)
    return res


def main():
    # with open("../project8/dashboard.json") as f:
    # with open("../project8/mongodb.json") as f:
    # with open("../project8/mongo.json") as f:
    # with open("../project8/business.json") as f:
    # with open("../project8/uptime.json") as f:
    # with open("../project8/alb_performance.json") as f:
    # with open("../project8/status_errors.json") as f:
    # with open("../project8/status_errors.json") as f:
    # with open("../project8/response_time.json") as f:
    # with open("../project8/aws_elb.json") as f:
    # with open("../project8/jvm_metrics.json") as f:
    # with open("../project8/k8s_pods.json") as f:
    # with open("../project8/aws_ec2.json") as f:
    # with open("../project8/jvm_overview.json") as f:
    # with open("../project8/alb_cloned.json") as f:
    # with open("../project8/k8s_services.json") as f:
    # with open("../project8/aws_ec2_cloned.json") as f:
    # with open("../project8/trace_analytics.json") as f:
    # with open("../project8/system_metrics.json") as f:
    # with open("../project8/aws_mq.json") as f:
    # with open("../project8/aws_autoscaling.json") as f:
    # with open("../project8/aws_billing.json") as f:
    # with open("../project8/aws_s3.json") as f:
    # with open("../project8/azure_api.json") as f:
    # with open("../project8/azure_overview.json") as f:
    # with open("../project8/aws_document.json") as f:
    # with open("../project8/redis.json") as f:
    # with open("../project8/aws_kinesis.json") as f:
    # with open("../project8/aws_kinesis_firehose.json") as f:
    # with open("../project8/aws_lambda.json") as f:
    # with open("../project8/aws_rds.json") as f:
    # with open("../project8/aws_sqs.json") as f:
    # with open("../project8/aws_step_functions.json") as f:
    # with open("../project8/aws_trusted_advisor.json") as f:
    # with open("../project8/azure_app_service.json") as f:
    # with open("../project8/azure_batch.json") as f:
    # with open("../project8/azure_cosmosdb.json") as f:
    # with open("../project8/azur_dbmsql.json") as f:
    # with open("../project8/azure_dbpostgres.json") as f:
    # with open("../project8/azure_event_hub.json") as f:
    # with open("../project8/azure_functions.json") as f:
    # with open("../project8/azure_iot_hub.json") as f:
    # with open("../project8/azure_loadbalancing.json") as f:
    # with open("../project8/azure_logicapp.json") as f:
    # with open("../project8/azure_overview#1.json") as f:
    # with open("../project8/azure_databases.json") as f:
    # with open("../project8/azure_usage.json") as f:
    # with open("../project8/azure_vm.json") as f:
    # with open("../project8/azure_vm_scale.json") as f:
    # with open("../project8/azure_cont.json") as f:
    # with open("../project8/azure_coredns.json") as f:
    # with open("../project8/docker_overview.json") as f:
    # with open("../project8/host_count.json") as f:
    # with open("../project8/k8s_daemonset.json") as f:
    # with open("../project8/k8s_deployment.json") as f:
    # with open("../project8/k8s_replicaset.json") as f:
    # with open("../project8/k8s_overview.json") as f:
    # with open("../project8/run_errors.json") as f:
    # with open("../project8/rum_mobile.json") as f:
    # with open("../project8/system_diskio.json") as f:
    # with open("../project8/system_networking.json") as f:
    # with open("../project8/troubleshoot.json") as f:
    with open("../project8/load_test.json") as f:
        content = json.load(f)

    terraform_string = generateDashboardTerraformCode(content)
    terraform_string = \
        f'resource "datadog_dashboard" "test_dashboard" {{\n' + \
            terraform_string + \
                f'\n}}'

    # print(terraform_string)

    # with open("dashboard.tf","w") as f:
    # with open("k8s_overview_dashboard.tf","w") as f:
    # with open("aws_elb_dashboard.tf","w") as f:
    # with open("load_test_dashboard_test.tf","w") as f:
    with open("test_dashboard.tf","w") as f:
        f.write(terraform_string)


if __name__ == "__main__":
    main()