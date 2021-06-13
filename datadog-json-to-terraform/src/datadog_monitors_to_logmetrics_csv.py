"""
    This script use for create logmetrics csv conf file from a monitors IDs.

    Input:
        . --input  or -i: JSON filename or type a list of IDs seperated by comma.
        . --output or -o: csv filename.
        . --mode   or -m: Create new Output csv file or Append to existing one.
        . --help   or -h: Full help description.

    Examples:
        . In order to create logmetrics csv file from a list of monitors IDs
          python3 datadog_monitors_to_logmetrics_csv.py -i 34430786,34407156,34443907,34443110 -o logmetrics_test.csv

        . In order to create logmetrics csv file from json file contains a list of monitors IDs
          python3 datadog_monitors_to_logmetrics_csv.py -i monitors_list.json -o logmetrics_test.csv

    Prerequisite:
        . Set the following env variables:
            DD_API_KEY: Datadog API key.
            DD_APP_KEY: Datadog Application key.
"""

import logging, argparse, csv
from utils.datadog_api import fetch_dd_resources, fetch_dd_resource_def, fetch_dd_resource_ids
import time


# logmetrics's configuration fields names.
logmetrics_conf_keys = [
    'name', 'filter_query', 'compute_type', 'compute_path', 'group_by'
]

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
    parser = argparse.ArgumentParser(description='Generates csv file for logMetrics module from datadog monitors')
    parser.add_argument("--input", "-i", type=str, required=False, default="", help="Monitor IDs (JSON filename or a list of IDs")
    parser.add_argument("--output", "-o", type=str, required=False, default="logmetrics.csv", help="Output csv filename. i.e logmetrics.csv")
    parser.add_argument("--mode", "-m", type=str, required=False, choices=["w","a"], default="w", help="Create new csv file or Append to existing one.")
    parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output for the script.")

    return parser.parse_args()


def validate_args(args):
    """
    Validate input arguments and return a list 
    of Datadog monitors ID numbers list.
    """

    logging.info(f"input=> [{args.input}] output=> [{args.output}] ")

    if not args.output.endswith(".csv"):
        raise ValueError('Output filename should end with .csv (i.e output.csv)')
    
    return fetch_dd_resource_ids(args.input, "monitor")


def create_logmetrics_conf(monitor_def):
    """
    Create logMetrics conf dictionary.

        Args:
        . monitor_def: Datadog monitor defitions.
    """
    logmetrics_conf = dict((key, "") for key in logmetrics_conf_keys)

    for key in logmetrics_conf:
        if key in ['name']:
            logmetrics_conf[key] = monitor_def["name"]
        elif key in ['filter_query']:
            logmetrics_conf[key] = monitor_def["query"].split("logs(")[1].split(")")[0]
        elif key in ['compute_type','compute_path','group_by']:
            logmetrics_conf[key] = ""

    return logmetrics_conf


def create_logmetrics_csv(args, monitors_ids):
    """
    Create logmetrics csv file based on monitors IDs

        Args:
        . args:         input arguments.
        . monitors_ids: Datadog monitors IDs.
    """
    logmetrics_conf = []                                # logmetrics configuration list.
    monitors_resource = fetch_dd_resources("monitor")   # Fetch all Datadog monitors resource.

    # go over monitors id numbers and create logmetrics conf list.
    for _, monitor_ids in monitors_ids.items():
        
        for monitor_id in monitor_ids:

            # extract monitor definition from datadog.
            monitor_def = fetch_dd_resource_def(monitor_id, monitors_resource, "monitor")

            logging.debug(f"Moonitor ID {monitor_id} ... Monitor Datadog def {monitor_def}")

            # Add logmetrics configuration.
            logmetrics_conf.append(create_logmetrics_conf(monitor_def))

    # write out logmetrics conf into csv file.
    with open(args.output, mode=args.mode) as csv_file:
        fieldnames = logmetrics_conf_keys
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        if args.mode == "w": writer.writeheader()
        writer.writerows(logmetrics_conf)

    if args.mode == "w":
        logging.info(f"Monitors Configuration csv file {args.output} has been created successfully ...")
    else:
        logging.info(f"Monitors Configuration has been added successfully to csv file {args.output} ...")


def main():
    """
    Main function use for create csv for logmetrics module from list of Datadog monitor IDs.
    """
    try:
        args = get_arguments()                                              # get input arguments.

        set_logging(args.verbose)                                           # set logging level.

        monitors_ids = validate_args(args)                                  # validate input arguments.

        create_logmetrics_csv(args, monitors_ids)                           # create logmetrics csv file.

    except BaseException as e:
        logging.exception("Uncaught exception: %s: %s", type(e).__name__, str(e))


if __name__ == "__main__":
    main()
    print("--- %s seconds ---" % (time.time() - start_time))