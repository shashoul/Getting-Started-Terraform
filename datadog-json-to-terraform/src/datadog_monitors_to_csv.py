"""
    Created on May 5, 2021

    @author: Shady

    This script receive monitors id numbers and convert them into configuration csv file.
"""
import json, os
from datadog import api, initialize
import time
import csv
import argparse
import logging

start_time = time.time()

options = {
    'api_key': os.getenv("DATADOG_API_KEY"),
    'app_key': os.getenv("DATADOG_APP_KEY")
}

# monitor's configuration fields names.
monitor_conf_keys = [
    'name', 'priority', 'type', 'query', 'operator',
    'threshold_critical', 'threshold_warning', 'threshold_critical_recovery', 'message', 'tags',
    'escalation_message', 'locked', 'new_host_delay', 'notify_audit', 'notify_no_data',
    'renotify_interval', 'require_full_window', 'timeout_h', 'evaluation_delay', 'no_data_timeframe',
    'include_tags', 'enable_logs_sample', 'threshold_windows_recovery_window', 'threshold_windows_trigger_window'
]

initialize(**options)

# List of All env Monitors.
all_monitors_def = api.Monitor.get_all()


def set_logging(verbose):
    """
    Set looging level.
    """
    logging_level = logging.DEBUG if verbose else logging.INFO

    logging.basicConfig(level=logging_level, format='%(asctime)s - %(levelname)s - %(message)s')


def get_arguments():
    """
    Define and Get input arguments.
    """
    parser = argparse.ArgumentParser(description='Generates Configuration csv file from datadog monitors ID numbers')
    parser.add_argument("--input", "-i", type=str, required=False, default="monitors.json", help="Input JSON filename that contains Monitors ID numbers. i.e monitors.json")
    parser.add_argument("--output", "-o", type=str, required=False, default="monitors.csv", help="Output csv filename. i.e monitors.csv")
    parser.add_argument("--mode", "-m", type=str, required=False, choices=["w","a"], default="w", help="Create new csv file or Append to existing one.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output for the script.")

    return parser.parse_args()


def get_monitor_conf(monitor_datadog_def)->dict:
    """
    Create monitor conf dictionary from monitor datadog definition 
    
        Args:
        - monitor_datadog_def: monitor datadog definition dict.

        Output:
        - monitor conf dict.
    """
    moninot_conf = dict((key, "") for key in monitor_conf_keys)

    # extract operator from monitor query.
    query_text = monitor_datadog_def["query"]
    operator = [op for op in ['<=','>=','<','>'] if op in query_text][0]

    for key in moninot_conf:
        if key in ['query']:
            moninot_conf[key] = query_text.split(operator)[0].strip()
        elif key in ['operator']:
            moninot_conf[key] = operator
        elif key in ['tags']:
            moninot_conf[key] = ' '.join(monitor_datadog_def["tags"])
        elif key in ['name', 'priority', 'type', 'message', 'escalation_message']:
            moninot_conf[key] = monitor_datadog_def.get(key,"")
        elif key in ['threshold_critical', 'threshold_warning', 'threshold_critical_recovery']:
            moninot_conf[key] = monitor_datadog_def["options"].get("thresholds",{}).get(key.split('threshold_')[1], "")
        elif key in ['threshold_windows_recovery_window', 'threshold_windows_trigger_window']:
            moninot_conf[key] = monitor_datadog_def["options"].get("threshold_windows",{}).get(key.split('threshold_windows_')[1],"")
        else:
            moninot_conf[key] = monitor_datadog_def["options"].get(key,"")

    return moninot_conf


def get_monitor_by_id(monitorID)->dict:
    """
    Return Datadog monitor definitoin.

        Args:
        . monitorID: id number of the monitors.
    """
    try:
        return [monitor for monitor in all_monitors_def if monitor["id"]==monitorID][0]
    except IndexError:
        print(f"====> Monitor ID {monitorID} not exist <==== ")


def main():
    """
    Main function used to convert datadog monitors into configuration csv file.
    """

    args = get_arguments()          # get input arguments.
    set_logging(args.verbose)       # set logging level.
    monitors_conf = []              # monitors configuration list.
    try:
        # get monitors ID numbers.
        logging.info(f"Read monitors ID numbers list from {args.input} ...")
        with open(args.input, "r") as f:
            monitors_list_dict = json.load(f)

        # go over monitors id numbers and create monitors conf list.
        for _, monitor_ids in monitors_list_dict.items():
            
            for monitor_id in monitor_ids:

                # extract monitor definition from datadog.
                logging.debug(f" Moonitor ID {monitor_id} ...")
                monitor_datadog_def = get_monitor_by_id(monitor_id)
                logging.debug(f"Monitor Datadog def {monitor_datadog_def}")

                # Skipt monitors from "composite" type.
                if monitor_datadog_def["type"] == "composite":
                    logging.info(f'Monitor (composite) - has been skipped: id => {monitor_id} name => {monitor_datadog_def["name"]}')
                    continue

                # Add monitor configuration.
                monitors_conf.append(get_monitor_conf(monitor_datadog_def))

        # write out monitors conf into csv file.
        with open(args.output, mode=args.mode) as csv_file:
            fieldnames = monitor_conf_keys
            writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
            if args.mode == "w": writer.writeheader()
            writer.writerows(monitors_conf)

        if args.mode == "w":
            logging.info(f"Monitors Configuration csv file {args.output} has been created successfully ...")
        else:
            logging.info(f"Monitors Configuration has been added successfully to csv file {args.output} ...")

    except BaseException as e:
        print("Uncaught exception: %s: %s", type(e).__name__, str(e))


if __name__ == "__main__":
    main()
    print("--- %s seconds ---" % (time.time() - start_time))