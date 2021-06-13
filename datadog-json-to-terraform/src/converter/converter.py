import importlib
import logging


class Converter:
    """
    class to convert datadog json to terraform code.
    """

    def __init__(self, datadog_type, json_dict:dict):
        """
        Initialize converter object.
            Args:
            . datadog_type - datadog json file type (dashboard, monitor, synthetics ...)
            . json_dict    - datadog json dictionary.
        """
        try:
            converter_class = getattr(importlib.import_module('.'+datadog_type, package="converter"), datadog_type.title())
            self._converter = converter_class(json_dict)
        except ModuleNotFoundError as e:
            logging.exception(f'No converter found for type {datadog_type} {str(e)}')


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog dashboard json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        return self._converter.to_Terraform_Code(resource_name)
    
