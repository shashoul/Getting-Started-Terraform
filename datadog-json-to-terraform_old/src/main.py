import json
import argparse
import logging
from dashboard import Dashboard
from monitor import Monitor


def set_logging(verbose):
    logging_level = logging.DEBUG if verbose else logging.INFO

    logging.basicConfig(level=logging_level, format='%(asctime)s - %(levelname)s - %(message)s')


def get_arguments():
    parser = argparse.ArgumentParser(description='Generate Terraform Content from Datadog Json')
    parser.add_argument("--type", "-t", choices=["dashboard","monitor"], required=False, default="dashboard", help="The type of datadog object the json represents.")
    parser.add_argument("--json", "-j",type=str, required=True, help="The Datadog Json file name to be converted.")
    parser.add_argument("--output", "-o", type=str, required=True, help="The output terraform file name. i.e dashboard.tf")
    parser.add_argument("--resource", "-r", required=False, default="resource_name", help="The terraform resource name")
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output for the script.")

    return parser.parse_args()


def main():
    """
    Main function used to convert a datadog json file into a terraform file.
    """
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
    # with open("../project8/load_test.json") as f:
        # content = json.load(f)
    
    args = get_arguments()
    set_logging(args.verbose)
    
    try:
        datadog_type = args.type
        datadog_json = args.json
        terraform_file = args.output
        terraform_resource_name = args.resource

        if datadog_type in ["dashboard","monitor"]:
            logging.info(f" Converting Json file {datadog_json} of type {datadog_type} ...")
            
            # read datadog json file.
            with open(datadog_json, "r") as f:
                datadog_json_dict = json.load(f)

            # initiliaze dashboard converter instance. 
            dashboard_converter = Dashboard(datadog_json_dict) if datadog_type == "dashboard" else Monitor(datadog_json_dict)

            # create terraform code.
            with open(terraform_file,"w") as f:
                f.write(dashboard_converter.to_Terraform_Code(terraform_resource_name))

            logging.info(f" Terraform file [ {terraform_file} ] has been created")
            logging.info(f" For reformating run => [ terraform fmt {terraform_file} ]")

    except BaseException as e:
        logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))
    

if __name__ == "__main__":
    main()