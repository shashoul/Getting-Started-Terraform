from converter.utils import literalString, assignmentString, block, block_list
import logging


class Synthetics:
    """
    class used to convert datadog synthetics test json to terraform code.
    """

    def __init__(self, synthetics_dict:dict):
        self._synthetics_dict = synthetics_dict


    def monitor_options_schema(self, key, val):
        """
        Converter for monitor_options schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'monitor_options schema key => {key} , val => {val}')
        res = ""
        if key in ["renotify_interval"]:
            res += assignmentString(key, val)
        else:
            pass
        return res


    def options_schema(self, key, val):
        """
        Converter for options_list schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'options schema key => {key} , val => {val}')
        res = ""
        if key in ["retry"]:
            res += block(key, val, assignmentString)
        elif key in ["monitor_options"]:
            res += block(key, val, self.monitor_options_schema )
        elif key in ["device_ids"]:
            pass
        else:
            res += assignmentString(key, val)
        return res


    def assertion_schema(self, key, val):
        """
        Converter for assertion schema.
            Args:
            . key - key name in the schema.
            . val - the key value.
        """
        logging.debug(f'assertion schema key => {key} , val => {val}')
        res = ""
        if key in ["targetjsonpath"]:
            res += block("targetjsonpath", val, assignmentString)
        else:
            res += assignmentString(key, val)
        return res


    def request_definition_schema(self, key, val):
        """
        Converter for request_definition schema
            Args:
            . key - key name in the schema.
            . val - the key value.
        """   
        logging.debug(f'request_definition schema key => {key} , val => {val}')
        res = ""
        if key in ["basicAuth","headers"]:
            pass
        else:
            res += assignmentString(key, val)
        return res


    def request_schema(self, content):
        """
        Converter for request schema.
            Args:
            . content - the content dict of the request.
        """
        logging.debug(f'request schema content => \n {content}')
        res = ""
        basicAuth_value = content.get("basicAuth", None)
        headers_value = content.get("headers", None)
        # logging.debug(f'request schema basicAuth: {basicAuth_value} , request_headers: {headers_value} {headers_value.items()}')

        if basicAuth_value is not None:
            res += block("request_basicauth", basicAuth_value, assignmentString)

        if headers_value is not None:
            # res += f'\n request_headers = {{ \n {assignmentString(key, val) for key, val in headers_value.items()} \n }}'
            res += assignmentString("request_headers", headers_value)

        res += block("request_definition", content, self.request_definition_schema)

        return res


    def config_schema(self, content):
        """
        Converter for config schema.
            Args:
            . content - the content dict of the config definition.
        """
        logging.debug(f'config schema content => \n {content}')
        res = ""
        for key, val in content.items():
            if key in ["request"]:
                res += self.request_schema(val)
            elif key in ["assertions"]:
                res += block_list("assertion", val, self.assertion_schema)
            elif key in ["variables"]:
                res += block_list("browser_variable", val, assignmentString)
            elif key in ["configVariables"]:
                res += block_list("config_variable", val, assignmentString)
            else:
                res += assignmentString(key, val)
        return res


    def synthetics_test_schema(self, syntheticsData):
        """
        Create terrafom synthetics test schema.
            Args:
            . syntheticsData - datadog synthetics test dict.
        """
        logging.debug(f'Synthetics test schema data => \n {syntheticsData}')
        res = ""
        for key, val in syntheticsData.items():
            if key in ["public_id","monitor_id"]:
                pass
            elif key in ["config"]:
                res += self.config_schema(val)
            elif key in ["options"]:
                # we'll check if there is device_ids key first.
                device_ids_val = syntheticsData["options"].get("device_ids", None)
                if device_ids_val is not None:
                    res += assignmentString("device_ids", device_ids_val)
                res += block("options_list", val, self.options_schema)
            else:
                res += assignmentString(key, val)
        return res


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog synthetics test json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        terraform_string = self.synthetics_test_schema(self._synthetics_dict)
        terraform_string = \
        f'resource "datadog_synthetics_test" {resource_name} {{\n' + \
            terraform_string + \
                f'\n}}'
        return terraform_string