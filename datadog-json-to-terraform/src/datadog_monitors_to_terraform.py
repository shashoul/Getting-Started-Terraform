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

# List of All env Monitors.
all_monitors_def = api.Monitor.get_all()


def set_logging(verbose):
    logging_level = logging.DEBUG if verbose else logging.INFO

    logging.basicConfig(level=logging_level, format='%(asctime)s - %(levelname)s - %(message)s')


def get_arguments():
    """
    Define and Get input arguments.
    """
    parser = argparse.ArgumentParser(description='Generates Terraform code from datadog monitors ID numbers')
    parser.add_argument("--input", "-i", type=str, required=False, default="monitors.json", help="Input JSON filename that contains Monitors ID numbers. i.e monitors.json")
    parser.add_argument("--output", "-o", type=str, required=False, default="monitors.tf", help="Output Terraform filename. i.e monitors.tf")
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
        'overall_state',
        'matching_downtimes']

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
    args = get_arguments()          # get input arguments.
    set_logging(args.verbose)
    terraform_code = ""             # output terraform code.
    try:
        with open(args.input, "r") as f:
            monitors_list_dict = json.load(f)

        for monitor, monitor_ids in monitors_list_dict.items():
            count = 0
            terraform_code_monitors_group = ""       # output terraform code per monitors group.
            for monitor_id in monitor_ids:
                count += 1

                # extract monitor definition from datadog.
                monitor_def = get_monitor_by_id(monitor_id)
                # print(monitor_id,type(monitor_def),monitor_def.keys())      
                # monitor_def = api.Monitor.get(monitor_id)

                # reorg monitor dict.
                monitor_definition = redefined_monitor_definition(monitor_def)

                # convert monitor definition dict to terraform code.
                converter = Converter(datadog_type="monitor", json_dict=monitor_definition)

                # Append terraform code to monitor platform file(according to monitor type).
                terraform_code_monitors_group += converter.to_Terraform_Code(monitor + '_' + str(count)) + "\n\n\n"

            # Write out terraform code for this group of monitor..
            if args.all:
                with open(monitor+".tf","w") as f:
                    f.write(terraform_code_monitors_group)
                logging.info(f"Terraform code file for group {monitor} has been created...")

            terraform_code += f"#####\n#\n# {monitor}\n#\n#####\n" + terraform_code_monitors_group

        # Write out terraform code. 
        with open(args.output,args.mode) as f:
            f.write(terraform_code)

        logging.info(f"Terraform code file {args.output} has been created successfully...")

    except BaseException as e:
        logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))


if __name__ == "__main__":
    main()
    print("--- %s seconds ---" % (time.time() - start_time))