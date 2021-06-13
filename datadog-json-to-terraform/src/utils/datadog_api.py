import os, logging, json
from datadog import api, initialize
from datadog_api_client.v2 import ApiClient, ApiException, Configuration
from datadog_api_client.v2.api import logs_metrics_api


options = {
    'api_key': os.getenv("DD_API_KEY"),
    'app_key': os.getenv("DD_APP_KEY")
}

initialize(**options)

configuration = Configuration()


def dd_resource_remove_keys(dd_resource:dict, dd_resource_type)->dict:
    """
    Remove unnacessary keys form Datadog resource definition dict.

        Args:
        . dd_resource:      Datadog resource definitoin dictionary.
        . dd_resource_type: Datadog resource type (monitor,dashboard,synthetics)
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


def fetch_dd_resources(dd_resource_type):
    """
    Fetch all Datadog resources of specific type.

        Args:
        . dd_resource_type: Datadog resource type(dashboard,monitor,synthetics)
    """
    if dd_resource_type == "monitor":
        return [
            dd_resource_remove_keys(monitor, dd_resource_type)
                for monitor in 
                    api.Monitor.get_all()
        ]

    elif dd_resource_type == "dashboard":
        return [
            dd_resource_remove_keys(api.Dashboard.get(dashboard["id"]), dd_resource_type)
                for dashboard in 
                    api.Dashboard.get_all()["dashboards"]
        ]

    elif dd_resource_type == "synthetics":
        return [
            dd_resource_remove_keys(synthetics_test, dd_resource_type)
                for synthetics_test in 
                    api.Synthetics.get_all_tests()["tests"]
        ]

    elif dd_resource_type == "logmetrics":
        return fetch_dd_resources_api_client(dd_resource_type)
    
    else:
        return None


def fetch_dd_resource(dd_resource_id, dd_resource_type):
    """
    Fetch Datadog resource.

        Args:
        . dd_resource_id:   Datadog resource ID number.
        . dd_resource_type: Datadog resource type(monitor,dashboard,synthetics)
    """
    if dd_resource_type == "monitor":
        return dd_resource_remove_keys(api.Monitor.get(dd_resource_id), dd_resource_type)
    elif dd_resource_type == "dashboard":
        return dd_resource_remove_keys(api.Dashboard.get(dd_resource_id), dd_resource_type)
    elif dd_resource_type == "synthetics":
        return None
    elif dd_resource_type == "logmetrics":
        return fetch_dd_resource_api_client(dd_resource_id,dd_resource_type)
    else:
        return None


def fetch_dd_resource_def(dd_resource_id, dd_resources, dd_resource_type)->dict:
    """
    Fetch Datadog resource definition from list of resources.

        Args:
        . dd_resource_id:   Datadog resource ID number.
        . dd_resources:     Datadog resources definitoin list.
        . dd_resource_type: Datadog resource type(dashboard,monitor,synthetics)
    """
    if dd_resource_type in ["synthetics"]:
        id_key = "public_id"
    else:
        id_key = "id"
    try:
        return [dd_resource for dd_resource in dd_resources if dd_resource[id_key] == dd_resource_id][0]
    except IndexError:
        logging.exception(f'====> Datadog resource ID {dd_resource_id} not exist <====')


def fetch_dd_resource_api_client(dd_resource_id, dd_resource_type):
    with ApiClient(configuration) as api_client:
        try:
            if dd_resource_type == "logmetrics":
                api_instance = logs_metrics_api.LogsMetricsApi(api_client)
                api_response = api_instance.get_logs_metric(dd_resource_id)
                logs_metrics_resource = api_response["data"]
                logs_metrics_resource["type"] = str(logs_metrics_resource["type"])
                return eval(str(logs_metrics_resource))
                # return api_response["data"].__dict__["_data_store"]
            else:
                return None
        
        except ApiException as e:
            logging.exception("Exception when calling datadog api client: %s",str(e))


def fetch_dd_resources_api_client(dd_resource_type):
    with ApiClient(configuration) as api_client:
        try:
            if dd_resource_type == "logmetrics":
                api_instance = logs_metrics_api.LogsMetricsApi(api_client)
                api_response = api_instance.list_logs_metrics()
                logs_metrics_resources = []
                for logs_metrics_resource in api_response["data"]:
                    logs_metrics_resource["type"] = str(logs_metrics_resource["type"])
                    logs_metrics_resources.append(eval(str(logs_metrics_resource)))
                return logs_metrics_resources
                # return api_response["data"]
                # return [
                #     object_to_dict(entry.__dict__["_data_store"])
                #         for entry in api_response["data"]
                # ]
                # return [ 
                #     dict(entry)
                #         for entry in api_response["data"]
                # ]
            else:
                return None
        
        except ApiException as e:
            logging.exception("Exception when calling datadog api client: %s",str(e))


def fetch_dd_resource_ids(input_args, dd_resource_type):
    """
    Fetch Datadog resource IDs according to the input arguments(JSON filename or list of IDs ),
    and return it as a list in dictionary.

        Args:
        . input_args:       JSON filename ot list of IDs.
        . dd_resource_type: Datadog resource type.
    """
    if input_args.endswith(".json"):
        """
        If input is a json file, we will check if file exist and read it.
        """
        if not os.path.isfile(input_args):
            raise FileNotFoundError(f'Input file "{input_args}" not found!!!')
        with open(input_args, "r") as f:
            dd_resource_ids = json.load(f)

        logging.debug(f'Datadog resources IDs => \n {dd_resource_ids}')

        return dd_resource_ids

    else:
        """
        If input is a list of ID numbers, we will extract ID numbers into dict
        and return it.
        """
        dd_resource_ids = {}
        ids = input_args.split(',')
        if dd_resource_type in ["monitor"]:
            if not all(id.isnumeric() for id in ids):
                raise ValueError(f'Invalid Ids number input.')
            dd_resource_ids[dd_resource_type] = [int(id) for id in input_args.split(',')]
        else:
            dd_resource_ids[dd_resource_type] = input_args.split(',')

        logging.debug(f'Datadog resources IDs => \n {dd_resource_ids}')

        return dd_resource_ids


# def object_to_dict(input_object:dict)->dict:
#     """
#     Convert object to dict.
#     """
#     dictionary = {}
#     print(input_object)
#     for key in input_object.keys():
#         print(key, type(input_object[key]).__name__)
#         if type(input_object[key]).__name__ not in ['list', 'dict', 'str', 'int', 'float', 'bool', 'NoneType', 'set', 'tuple']:
#             # print(input_object[key].__dict__)
#             dictionary[key] = object_to_dict(input_object[key].__dict__)
#         elif isinstance(input_object[key],dict):
#             print(input_object[key], "IN DICT FUNC.....")
#             # for k in input_object[key].keys():
#             #     dictionary[key] = object_to_dict(input_object[k])
#             # print(vars(input_object[key]))
#             # return dict((key, todict(val)) for key, val in obj.items())
#             dictionary[key] = dict((k,v) for k, v in input_object[key].items())
#         elif type(input_object[key]).__name__ in ['NoneType']:
#             continue
#         else:
#             dictionary[key] = input_object[key]
#             # return input_object[key]
#             # continue
#     return dictionary
    