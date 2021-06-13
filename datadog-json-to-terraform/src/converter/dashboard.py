from converter.utils import literalString, assignmentString, block, block_list
import logging


class Dashboard:
    """
    class used to convert a datadog json dashboard to terraform dashboard code.
    """

    def __init__(self, dashboard_dict:dict):
        self._dashboard_dict = dashboard_dict


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


    def template_variable_preset_schema(self, key, val):
        """
        Converter for template_variable_present schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'template variable preset schema key => {key} , val => {val}')
        res = ""
        if key == "name":
            res += assignmentString(key, val)
        elif key == "template_variables":
            res += block_list("template_variable", val, assignmentString)
        return res


    def group_by_schema(self, key, val):
        """
        Converter for group_by schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'group_by schema key => {key} , val => {val}')
        res = ""
        if key in ["sort"]:
            res += block("sort_query", val, assignmentString)
        elif key in ["sort_query"]:
            res += block("sort_query", val, assignmentString)
        else:
            res += assignmentString(key, val)
        return res


    def request_nested_schema(self, key, val):
        """
        Converter for request nested schema.
            Args:
            . key - key name in the schema.
            . val - the key value.
        """
        logging.debug(f'request nested schema key => {key} , val => {val}')
        res = ""
        if key in ["search"]:
            res += assignmentString("search_query",val["query"])
        elif key in ["compute"]:
            res += block("compute_query", val, assignmentString)
        elif key in ["compute_query"]:
            res += block("compute_query", val, assignmentString)
        elif key in ["multi_compute"]:
            pass
        elif key in ["group_by"]:
            res += block_list("group_by", val, self.group_by_schema)
        else:
            res += assignmentString(key, val)
        return res


    def request_schema(self, key, val):
        """
        Converter for request schema.
            Args:
            . key - key name in the schema.
            . val - the key value.
        """
        logging.debug(f'request schema key => {key} , val => {val}')
        res = ""
        if key in ["style","process_query","apm_stats_query"]:
            res += block(key, val, assignmentString)
        elif key in ["metadata","conditional_formats"]:
            res += block_list(key, val, assignmentString)
        elif key in ["log_query","rum_query","apm_query","security_query","network_query"]:
            res += block(key, val, self.request_nested_schema)
        elif key in ["fill","size"]:
            res += block(key, val, self.request_schema)
        elif key in ["profile_metrics_query"]:    #unsupported keys
            pass
        else:
            res += assignmentString(key, val)
        return res


    def widget_definition_schema(self, content):
        """
        Converter for widget dfinition schema.
            Args:
            . content - the content dict of the widget definition.
        """
        logging.debug(f'widget definition schema content => \n {content}')
        res = ""
        for key, val in content.items():
            if key in ["type","legend_layout","legend_columns","global_time_target","reflow_type"]:
                pass
            elif key == "custom_links":
                res += block_list("custom_link", val, assignmentString)
            elif key == "requests":
                res += block_list("request", val, self.request_schema) if isinstance(val, list) else block("request", val, self.request_schema)
            elif key == "widgets":
                res += block_list("widget", val, self.widget_schema)
            elif key == "events":
                res += block_list("event", val, assignmentString)
            elif key == "markers":
                res += block_list("marker", val, assignmentString)
            elif key == "sort":
                res += assignmentString("sort", val) if isinstance(val,str) else block_list("sort", val, assignmentString)
            elif key in ["event", "right_yaxis", "widget_layout", "xaxis", "yaxis", "style", "view"]:
                res += block(key, val, assignmentString)
            elif key == "time":
                live_span = val.get("live_span","")
                if live_span != "": res += assignmentString("live_span", live_span)
            else:
                res += assignmentString(key, val)
        definition_type = "service_level_objective" if content["type"] == "slo" else content["type"]
        return f'\n {definition_type}_definition {{ {res} \n }}'


    def widget_schema(self, key, val):
        """
        Converter for widget schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'widget schema key => {key} , val => {val}')
        res = ""
        if key in ["id"]:
            pass
        elif key == "definition":
            res += self.widget_definition_schema(val)
        elif key == "layout":
            res += block("widget_layout", val, assignmentString)
        return res


    def dashboard_schema(self, dashboardData):
        """
        Create terrafom dashboard schema.
            Args:
            . dashboardData - datadog dashboard dict.
        """
        logging.debug(f'Dashboard schema dashboard data => \n {dashboardData}')
        res = ""
        for key, val in dashboardData.items():
            if key in ["id","reflow_type"]:
                pass
            elif key == "widgets":
                logging.debug(f'Dashboard schema widgets => \n {val}')
                res += block_list("widget", val, self.widget_schema) if val is not None else ""
            elif key == "template_variables":
                logging.debug(f'Dashboard schema template_variables => \n {val}')
                res += block_list("template_variable", val, assignmentString) if val is not None else ""
            elif key == "template_variable_presets":
                logging.debug(f'Dashboard schema template_variable_presets => \n {val}')
                res += block_list("template_variable_preset", val, self.template_variable_preset_schema) if val is not None else ""
            else:
                res += assignmentString(key,val)
        return res


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog dashboard json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        terraform_string = self.dashboard_schema(self._dashboard_dict)
        terraform_string = \
        f'resource "datadog_dashboard" {resource_name} {{\n' + \
            terraform_string + \
                f'\n}}'
        return terraform_string

    
