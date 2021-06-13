"""
    This script use for convert Datadog resources into a terraform code according to Datadog resource type
    (dashboard, monitor, synthetics).

    Input:
        . --input  or -i: Leave it empty for all resources or provide input JSON filename or type a list of IDs seperated by comma.
        . --output or -o: Terraform code outpur filename.
        . --type   or -t: Datadog resource type [monitor/dashboard/synthetics].
        . --mode   or -m: Create new Output Terraform code  file or Append to existing one.
        . --help   or -h: Full help description.

    Examples:
        . In order to convert all dashboards
          python3 datadog_resources_to_terraform -t dashboard -o output_dashboards.tf

        . In order to convert a list of monitors (provided by command line)
          python3 datadog_resources_to_terraform -t monitor -i 34430786,34407156,34443907,34443110 -o output_monitors.tf

        . In order to convert a list of synthetics (provided by json file)
          python3 datadog_resources_to_terraform -t synthetics -i synthetics_input.json -o output_synthetics.tf

    Prerequisite:
        . Set the following env variables:
            DD_API_KEY: Datadog API key.
            DD_APP_KEY: Datadog Application key.
"""

import json, os, logging, argparse
from converter.converter import Converter
from utils.datadog_api import fetch_dd_resources, fetch_dd_resource_def, fetch_dd_resource, fetch_dd_resource_ids
import time


start_time = time.time()


def set_logging(verbose):
    """
    Set logging level.

        Args:
        . verbose: True/False
    """
    logging_level = logging.DEBUG if verbose else logging.INFO

    logging.basicConfig(level=logging_level, format='%(asctime)s - %(levelname)s - %(message)s')


def get_arguments():
    """
    Define and Get input arguments.
    """
    parser = argparse.ArgumentParser(description='Generates Terraform code from datadog resource ID numbers')
    parser.add_argument("--input", "-i", type=str, required=False, default="ALL", help="Extract all datadog resources(default) OR Provide JSON filename that contains datadog resource ID numbers. i.e monitors.json OR ID numbers list i.e 34430786,34407156,34443907")
    parser.add_argument("--output", "-o", type=str, required=False, default="output.tf", help="Output Terraform filename. i.e monitors.tf")
    parser.add_argument("--type", "-t", type=str, required=True, choices=["monitor","dashboard","synthetics","logmetrics"], help="datadog resource type")
    parser.add_argument("--mode", "-m", type=str, required=False, choices=["w","a"], default="w", help="Create new Terraform file or Append to existing one.")
    parser.add_argument("--group", action="store_true", help="Create Terraform files per group.")
    parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output for the script.")

    return parser.parse_args()


def validate_args(args):
    """
    Validate input arguments and return a list 
    of Datadog resource ID numbers list in case of args.input!=ALL
    """

    logging.info(f"Datadog resources type=>[{args.type}] input=>[{args.input}] output=>[{args.output}] ")

    if not args.output.endswith(".tf"):
        raise ValueError('Output filename should end with .tf (i.e output.tf)')
    
    if args.input == "ALL":
        return None
    
    return fetch_dd_resource_ids(args.input, args.type)

    # elif args.input.endswith(".json"):
    #     """
    #     If input is a json file, we will check if file exist and read it.
    #     """
    #     if not os.path.isfile(args.input):
    #         raise FileNotFoundError(f'Input file "{args.input}" not found!!!')
    #     with open(args.input, "r") as f:
    #         dd_resource_ids = json.load(f)

    #     logging.debug(f'Datadog resources IDs => \n {dd_resource_ids}')

    #     return dd_resource_ids

    # else:
    #     """
    #     If input is a list of ID numbers, we will extract ID numbers into dict
    #     and return it.
    #     """
    #     dd_resource_ids = {}
    #     ids = args.input.split(',')
    #     if args.type in ["monitor"]:
    #         if not all(id.isnumeric() for id in ids):
    #             raise ValueError(f'Invalid Ids number input.')
    #         dd_resource_ids[args.type] = [int(id) for id in args.input.split(',')]
    #     else:
    #         dd_resource_ids[args.type] = args.input.split(',')

    #     logging.debug(f'Datadog resources IDs => \n {dd_resource_ids}')

    #     return dd_resource_ids


def dd_resources_to_terraform(args, dd_resource_ids):
    """
    Convert Datadog resource to terraform code.

        Args:
        . args:             input Arguments 
        . dd_resource_ids:  Datadog resource ID numbers to convert.

        Output:
        . return terraform code string that represent Datadog resource.
    """
    
    terraform_code = ""

    if args.input == "ALL":
        """
        In case we need to convert all Datadog resources of specific type.
        """
        count = 0 
        dd_resources = fetch_dd_resources(args.type)    # Fetch all Datadog resources.
        for dd_resource in dd_resources:
            count += 1
            # convert Datadog resource definition dict to terraform code.
            converter = Converter(datadog_type=args.type, json_dict=dd_resource)

            logging.debug(f'Datadog resource {count} => {dd_resource}')

            # Append terraform code to.
            terraform_code += converter.to_Terraform_Code(args.type + '_' + str(count)) + "\n\n\n"
    else:
        if args.type != "dashboard": dd_resources = fetch_dd_resources(args.type)
        
        for dd_resource_group, dd_resource_group_ids in dd_resource_ids.items():
            count =0
            terraform_code_monitors_group = ""       # output terraform code per dd resource group.

            for dd_resource_group_id in dd_resource_group_ids:
                count += 1

                if args.type != "dashboard":
                    dd_resource_dict = fetch_dd_resource_def(dd_resource_group_id, dd_resources, args.type)
                else:
                    # dd_resource_dict = dd_resource_remove_keys(api.Dashboard.get(dd_resource_group_id), args.type)
                    dd_resource_dict = fetch_dd_resource(dd_resource_group_id, args.type)
                
                # convert Datadog resource definition dict to terraform code.
                converter = Converter(datadog_type=args.type, json_dict=dd_resource_dict)
                
                logging.debug(f'Datadog resource {count} => {dd_resource_dict}')

                # Append terraform code.
                terraform_code_monitors_group += converter.to_Terraform_Code(dd_resource_group + '_' + str(count)) + "\n\n\n"

            # Write out terraform code for this group of dd resource...
            if args.group:
                with open(dd_resource_group+".tf","w") as f:
                    f.write(terraform_code_monitors_group)
                logging.info(f"Terraform code file for group {dd_resource_group} has been created...")

            terraform_code += f"#####\n#\n# {dd_resource_group}\n#\n#####\n" + terraform_code_monitors_group
            
    return terraform_code


def main():
    """
    Main function use for convert Datadog resources into a terraform code according to a type:
        . dashboard
        . monitor
        . synthetics
    """
    try:
        args = get_arguments()                                               # get input arguments.

        set_logging(args.verbose)                                            # set logging level.

        dd_resource_ids = validate_args(args)                                # validate input arguments.

        terraform_code = dd_resources_to_terraform(args, dd_resource_ids)    # Convert to terraform code.

        # Write out terraform code. 
        with open(args.output,args.mode) as f:
            f.write(terraform_code)

        logging.info(f"Terraform code file {args.output} has been created successfully...")

    except BaseException as e:
        logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))


if __name__ == "__main__":
    main()
    print("--- %s seconds ---" % (time.time() - start_time))