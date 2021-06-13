import os, logging
from datadog import api, initialize
from datadog.api.dashboards import Dashboard


options = {
    'api_key': os.getenv("DATADOG_API_KEY"),
    'app_key': os.getenv("DATADOG_APP_KEY")
}

initialize(**options)


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
        pass
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
