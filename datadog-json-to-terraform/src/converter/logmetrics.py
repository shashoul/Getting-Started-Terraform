from converter.utils import assignmentString, block, block_list
import logging


class Logmetrics:
    """
    class used to convert a datadog json logMetrics to terraform logMetrics code.
    """

    def __init__(self, logMetrics_dict:dict):
        self._logMetrics_dict = logMetrics_dict


    def attributes_schema(self, content):
        """
        Converter of attributes block.
            Args:
            . content - attributes_schema dict.
        """
        logging.debug(f'LogMetrics attributes schema content  => \n {content}')
        res = ""
        for key, val in content.items():
            if key in ["compute","filter"]:
                res += block(key, val, assignmentString)
            elif key in ["group_by"]:
                res += block_list("group_by", val, assignmentString)
            else:
                res += assignmentString(key, val)
        return res


    def logMetrics_schema(self, logMetricsData):
        """
        Create terrafom logMetrics schema.
            Args:
            . logMetricsData - datadog logMetrics dict.
        """
        logging.debug(f'LogMetrics schema data => \n {logMetricsData}')
        res = ""
        for key, val in logMetricsData.items():
            if key in ["type"]:
                pass
            elif key in ["id"]:
                res += assignmentString("name", val)
            elif key in ["attributes"]:
                res += self.attributes_schema(val)
            else:
                res += assignmentString(key, val)
        return res


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog logMetrics json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        terraform_string = self.logMetrics_schema(self._logMetrics_dict)
        terraform_string = \
        f'resource "datadog_logs_metric" {resource_name} {{\n' + \
            terraform_string + \
                f'\n}}'
        return terraform_string
