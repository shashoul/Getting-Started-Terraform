"""
    Created on May 5, 2021

    @author: Shady

    This script receive monitors id numbers list and convert them to terrafom code. 
"""
import json, os
from datadog import api, initialize
from converter.converter import Converter
import time
import argparse
import logging


# # Following is input and output filename , change them as required.
# monitors_list_filename = 'monitors_list.json'
# monitors_terraform_output_filename = 'monitors.tf'

start_time = time.time()

options = {
    'api_key': os.getenv("DATADOG_API_KEY"),
    'app_key': os.getenv("DATADOG_APP_KEY")
}

initialize(**options)

# # List of All env Monitors.
# all_monitors_def = api.Monitor.get_all()


def set_logging(verbose):
    logging_level = logging.DEBUG if verbose else logging.INFO

    logging.basicConfig(level=logging_level, format='%(asctime)s - %(levelname)s - %(message)s')


def get_arguments():
    """
    Define and Get input arguments.
    """
    parser = argparse.ArgumentParser(description='Generates Terraform code from datadog resource ID numbers')
    parser.add_argument("--input", "-i", type=str, required=False, default="ALL", help="Extract all datadog resources(default) OR Input JSON filename that contains datadog resource ID numbers. i.e monitors.json OR ID numbers list i.e 34430786,34407156,34443907")
    parser.add_argument("--output", "-o", type=str, required=False, default="output.tf", help="Output Terraform filename. i.e monitors.tf")
    parser.add_argument("--type", "-t", type=str, required=True, choices=["monitor","dashboard", "synthetics"], help="datadog resource type")
    parser.add_argument("--mode", "-m", type=str, required=False, choices=["w","a"], default="w", help="Create new Terraform file or Append to existing one.")
    parser.add_argument("--all", action="store_true", help="Create Terraform files per group.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output for the script.")

    return parser.parse_args()


def get_monitor_by_id(monitorID)->dict:
    """
    Return monitor definitoin.

        Args:
        . monitorID: id number of the monitors.
    """
    # monitor_def = [monitor for monitor in all_monitors_def if monitor["id"]==monitorID]
    # if not len(monitor_def):
    #     raise KeyError(f"Monitor ID not Exist => {monitorID}")
    # return monitor_def[0]
    try:
        return [monitor for monitor in all_monitors_def if monitor["id"]==monitorID][0]
    except IndexError:
        print(f"====> Monitor ID {monitorID} not exist <==== ")


def get_dd_resource_def(dd_resource_id, dd_resources, dd_resource_type)->dict:
    """
    """
    if dd_resource_type in ["synthetics"]:
        id_key = "public_id"
    else:
        id_key = "id"
    try:
        return [dd_resource for dd_resource in dd_resources if dd_resource[id_key] == dd_resource_id][0]
    except IndexError:
        logging.exception(f'====> Datadog resource ID {dd_resource_id} not exist <====')


def dd_resource_remove_keys(dd_resource:dict, dd_resource_type)->dict:
    """
    Remove unnacessary keys form dd resource definition dict.

        Args:
        . dd_resource: dd resource definitoin dictionary.
        . dd_resource_type: dd resource type (monitor,dashboard,synthetics)
    """
    if dd_resource_type == "monitor":
        # Remove keys list.
        rem_list = [ 'restricted_roles',
            'deleted',
            'multi',
            'created',
            'created_at',
            'creator',
            'org_id',
            'modified',
            'overall_state_modified',
            'overall_state',
            'matching_downtimes'
            ]
    elif dd_resource_type == "dashboard":
        rem_list= [
            'modified_at',
            'created_at',
            'author_handle',
            'author_name'
        ]
    elif dd_resource_type == "synthetics":
        rem_list = [
        'created_at',
        'modified_at'
        ]

    #remove unneeded keys
    [dd_resource.pop(key) for key in rem_list]

    return dd_resource


def redefined_monitor_definition(monitor_def:dict)->dict:
    """
    Redefine and reorder monitor definition dict.

        Args:
        . monitor_def: monitor definitoin dictionary. 
    """
    # Remove keys list.
    rem_list = [ 'restricted_roles',
        'deleted',
        'multi',
        'created',
        'created_at',
        'creator',
        'org_id',
        'modified',
        'overall_state_modified',
        'overall_state']

    #remove unneeded keys
    [monitor_def.pop(key) for key in rem_list]

    #reorder keys.
    monitor_definition = {}
    monitor_definition["id"] = monitor_def["id"]
    monitor_definition["name"] = "Terraform - " + monitor_def["name"]
    monitor_definition["type"] = monitor_def["type"]
    monitor_definition["query"] = monitor_def["query"]
    monitor_definition["message"] = monitor_def["message"]
    monitor_definition["tags"] = monitor_def["tags"]
    monitor_definition["options"] = monitor_def["options"]
    monitor_definition["priority"] = monitor_def["priority"]

    return monitor_definition


def redefined_synthetics_definition(synthetics_test:dict)->dict:
    """
    """
    rem_list = [
        'created_at',
        'modified_at'
    ]

    # remove unneeded keys.
    [synthetics_test.pop(key) for key in rem_list]

    return synthetics_test


def validate_args(args):
    """
    """
    if not args.output.endswith(".tf"):
        logging.exception(f'Output filename should end with .tf (i.e output.tf)')
        raise ValueError('Output filename should end with .tf (i.e output.tf)')
    
    if args.input == "ALL":
        return None

    elif args.input.endswith(".json"):
        if not os.path.isfile(args.input):
            logging.exception(f'Input file "{args.input}" not found!!!')
            raise FileNotFoundError(f'Input file "{args.input}" not found!!!')
        with open(args.input, "r") as f:
            dd_resource_ids = json.load(f)
        return dd_resource_ids

    else:
        dd_resource_ids = {}
        ids = args.input.split(',')
        if args.type in ["monitor"]:
            if not all(id.isnumeric() for id in ids):
                logging.exception(f'Invalid Ids number input.')
                raise ValueError(f'Invalid Ids number input.')
            dd_resource_ids[args.type] = [int(id) for id in args.input.split(',')]
        else:
            dd_resource_ids[args.type] = args.input.split(',')
        return dd_resource_ids


def get_dd_resources(resource_type):
    """
    """
    if resource_type == "monitor":
        # monitors = api.Monitor.get_all()
        # return [redefined_monitor_definition(monitor) for monitor in monitors]
        return [
            dd_resource_remove_keys(monitor, resource_type)
                for monitor in 
                    api.Monitor.get_all()
        ]

    elif resource_type == "dashboard":
        # return api.Dashboard.get_all()["dashboards"]
        # return api.DashboardList.get_all()
        # return api.Dashboard.get('fw2-mkx-phe')
        return [
            dd_resource_remove_keys(api.Dashboard.get(dashboard["id"]), resource_type)
                for dashboard in 
                    api.Dashboard.get_all()["dashboards"]
        ]

    elif resource_type == "synthetics":
        return [
            dd_resource_remove_keys(synthetics_test, resource_type)
                for synthetics_test in 
                    api.Synthetics.get_all_tests()["tests"]
        ]


def dd_resource_to_terraform(args, dd_resource_ids):
    """
    """
    # dd_resources = get_dd_resources(args.type)
    # print(dd_resources)
    terraform_code = ""

    if args.input == "ALL":
        count = 0 
        dd_resources = get_dd_resources(args.type)
        for dd_resource in dd_resources:
            count += 1
            # if count == 2 or count == 4 or count == 8 or count == 12 or count == 15: continue
            # print(count)
            # print(dd_resource)
            # print("==========================================================================")
            # convert monitor definition dict to terraform code.
            converter = Converter(datadog_type=args.type, json_dict=dd_resource)

            # Append terraform code to monitor platform file(according to monitor type).
            terraform_code += converter.to_Terraform_Code(args.type + '_' + str(count)) + "\n\n\n"
    else:
        if args.type != "dashboard": dd_resources = get_dd_resources(args.type)
        
        for dd_resource_group, dd_resource_group_ids in dd_resource_ids.items():
            count =0
            terraform_code_monitors_group = ""       # output terraform code per dd resource group.

            for dd_resource_group_id in dd_resource_group_ids:
                count += 1

                if args.type != "dashboard":
                    dd_resource_dict = get_dd_resource_def(dd_resource_group_id, dd_resources, args.type)
                else:
                    dd_resource_dict = dd_resource_remove_keys(api.Dashboard.get(dd_resource_group_id), args.type)
                
                # convert monitor definition dict to terraform code.
                converter = Converter(datadog_type=args.type, json_dict=dd_resource_dict)
                
                # Append terraform code to monitor platform file(according to monitor type).
                terraform_code_monitors_group += converter.to_Terraform_Code(dd_resource_group + '_' + str(count)) + "\n\n\n"

            # Write out terraform code for this group of dd resource...
            if args.all:
                with open(dd_resource_group+".tf","w") as f:
                    f.write(terraform_code_monitors_group)
                logging.info(f"Terraform code file for group {dd_resource_group} has been created...")

            terraform_code += f"#####\n#\n# {dd_resource_group}\n#\n#####\n" + terraform_code_monitors_group
            
    return terraform_code


def main():
    """
    Main function used to convert datadog monitors into a terraform file according to there type.
    """
    #all_monitors_def = api.Monitor.get_all()
    # print(all_monitors_def)
    # for monitor_def in all_monitors_def:
        # print(f"Monitor {type(monitor_def)}=> \n {monitor_def}")
    #return
    #print("hererererer")
    # read monitors ids json file.
    try:
        args = get_arguments()                                              # get input arguments.

        set_logging(args.verbose)                                           # set logging level.

        dd_resource_ids = validate_args(args)                               # validate input arguments.

        # print(args.input)

        terraform_code = dd_resource_to_terraform(args, dd_resource_ids)    # output terraform code.

        # print(terraform_code)

        # Write out terraform code. 
        with open(args.output,args.mode) as f:
            f.write(terraform_code)

    except BaseException as e:
        logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))


    # input_data = args.input
    # print(type(input_data), input_data.split(','), type(args))

    # if os.path.isfile(input_data):
    # if args.input.endswith('.json'):
    #     # print("Input is a file...")
    #     # if not args.input.endswith('.json'):
    #         # print("Not json file...")
    #     if not os.path.isfile(args.input):
    #         logging.exception(f'Input file "{args.input}" not found!!!')
    # else:
    #     args.input = [int(id) for id in input_data.split(',')]
    #     print(args.input)
    #     args.input_type = "list_of_ids"

    # try:
    #     with open(args.input, "r") as f:
    #         monitors_list_dict = json.load(f)

    #     for monitor, monitor_ids in monitors_list_dict.items():
    #         count = 0
    #         terraform_code_monitors_group = ""       # output terraform code per monitors group.
    #         for monitor_id in monitor_ids:
    #             count += 1

    #             # extract monitor definition from datadog.
    #             monitor_def = get_monitor_by_id(monitor_id)
    #             # print(monitor_id,type(monitor_def),monitor_def.keys())      
    #             # monitor_def = api.Monitor.get(monitor_id)

    #             # reorg monitor dict.
    #             monitor_definition = redefined_monitor_definition(monitor_def)

    #             # convert monitor definition dict to terraform code.
    #             converter = Converter(datadog_type="monitor", json_dict=monitor_definition)

    #             # Append terraform code to monitor platform file(according to monitor type).
    #             terraform_code_monitors_group += converter.to_Terraform_Code(monitor + '_' + str(count)) + "\n\n\n"

    #         # Write out terraform code for this group of monitor..
    #         if args.all:
    #             with open(monitor+".tf","w") as f:
    #                 f.write(terraform_code_monitors_group)
    #             logging.info(f"Terraform code file for group {monitor} has been created...")

    #         terraform_code += f"#####\n#\n# {monitor}\n#\n#####\n" + terraform_code_monitors_group

    #     # Write out terraform code. 
    #     with open(args.output,args.mode) as f:
    #         f.write(terraform_code)

    #     logging.info(f"Terraform code file {args.output} has been created successfully...")

    # except BaseException as e:
    #     logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))


if __name__ == "__main__":
    main()
    print("--- %s seconds ---" % (time.time() - start_time))