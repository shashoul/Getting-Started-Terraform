from utils import literalString, assignmentString, block, block_list
import logging


class Monitor:
    """
    class used to convert a datadog json monitor to terraform monitor code.
    """

    def __init__(self, monitor_dict:dict):
        self._monitor_dict = monitor_dict


    # def block(self, name, content, converter):
    #     """
    #     Create terraform dasboard block.
    #         Args:
    #         . name      - block name.
    #         . content   - block dict.
    #         . converter - converter function
    #     """
    #     res =""
    #     res += f'\n {name} ' + '{'
    #     for key, val in content.items():
    #         res += converter(key, val)
    #     return res + '\n } '


    # def block_list(self, name, content, converter):
    #     """
    #     Create terraform dashbord block list.
    #         Args:
    #         . name      - block name.
    #         . content   - list of block dict.
    #         . converter - converter function
    #     """
    #     res = ""
    #     for elm in content:
    #         res += self.block(name, elm, converter)
    #     return res


    def options_schema(self, content):
        """
        Converter of options block.
            Args:
            . content - options dict.
        """
        logging.debug(f'Monitor options schema content  => \n {content}')
        res = ""
        for key, val in content.items():
            if key in ["thresholds"]:
                # res += self.block("monitor_thresholds", val, assignmentString)
                res += block("monitor_thresholds", val, assignmentString)
            elif key in ["silenced"]:
                # res += self.block(key, val, assignmentString)
                # res += block(key, val, assignmentString)
                pass        # unsupported block tyep.
            else:
                res += assignmentString(key, val)
        return res


    def monitor_schema(self, monitorData):
        """
        Create terrafom monitor schema.
            Args:
            . monitorData - datadog monitor dict.
        """
        logging.debug(f'Monitor schema dashboard data => \n {monitorData}')
        res = ""
        for key, val in monitorData.items():
            if key in ["id"]:
                pass
            elif key in ["options"]:
                res += self.options_schema(val)
            else:
                res += assignmentString(key,val)
        return res


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog monitor json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        terraform_string = self.monitor_schema(self._monitor_dict)
        terraform_string = \
        f'resource "datadog_monitor" {resource_name} {{\n' + \
            terraform_string + \
                f'\n}}'
        return terraform_string

    
