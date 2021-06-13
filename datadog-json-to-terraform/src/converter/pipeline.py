from converter.utils import literalString, assignmentString, block, block_list
import logging


class Pipeline:
    """
    clss used to convert Datadog logs pipeline json to Terraform(datadog_logs_custom_pipeline) code.
    """

    def __init__(self, pipeline_dict:dict):
        self._pipeline_dict = pipeline_dict


    def filter_schema(self, key, val):
        """
        Convert filter schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'filter schema , key => {key} val => {val}')
        res = ""

        if key in ["query"]:
            if not val:
                raise ValueError(f'filter query is required and can not be empty!!!')
            res += assignmentString(key, val)
        else:
            res += assignmentString(key, val)

        return res


    def category_schema(self, key , val):
        """
        Convert category schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'category schema , key => {key} val => {val}')
        res = ""

        if key in ["filter"]:
            res += block_list("filter", val, self.filter_schema) if isinstance(val, list) else block("filter", val, self.filter_schema)
        else:
            res += assignmentString(key, val)

        return res


    def grok_parser_schema(self, key, val):
        """
        Convert grok_parser schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'grok_parser schema , key => {key} val => {val}')
        res = ""

        if key in ["type"]:
            pass
        elif key in ["grok"]:
            res += block("grok", val, assignmentString)
        else:
            res += assignmentString(key, val)

        return res


    def category_processor_schema(self, key, val):
        """
        Convert category_processor schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'category_processor schema , key => {key} val => {val}')
        res = ""

        if key in ["type"]:
            pass
        elif key in ["categories"]:
            res += block_list("category", val, self.category_schema)
        else:
            res += assignmentString(key, val)

        return res


    def processor_schema(self, key, val):
        """
        Convert processor schema.
            Args:
            . key - key name in the schema. 
            . val - the key value.
        """
        logging.debug(f'processors schema , key => {key} val => {val}')
        res = ""

        if key in ["type"]:
            pass
        else:
            res += assignmentString(key, val)

        return res


    def pipeline_processors_engine(self, processors):
        """
        Create the pipeline processors blocks.
            Args:
            . processors - list of processors.
        """
        logging.debug(f'Pipeline processors engine , Processors list: {processors}')
        
        res = ""

        for processor in processors:
            logging.debug(f'Processor => \n {processor}')

            processor_type = processor.get("type", None)
            if processor_type is None:
                logging.debug(f'No processor type is provided !!!')
                continue
            processor_type = processor_type.replace('-','_')

            if processor_type in ["category_processor"]:
                processor_block = block("category_processor", processor, self.category_processor_schema)
            elif processor_type in ["grok_parser"]:
                processor_block = block("grok_parser", processor, self.grok_parser_schema)
            elif processor_type in ["pipeline"]:
                processor_block = f'\n pipeline {{ {self.pipeline_schema(processor)} \n }}'
            else:
                processor_block = block(processor_type, processor, self.processor_schema)

            res += f'\n processor {{ {processor_block} \n }}'

        return res


    def pipeline_schema(self, pipelineData):
        """
        Create terrafom pipeline schema.
            Args:
            . pipelineData - datadog pipeline dict.
        """
        logging.debug(f'Pipeline schema pipeline data => \n {pipelineData}')
        res = ""
        for key, val in pipelineData.items():
            if key in ["id","type","is_read_only"]:
                pass
            elif key in ["filter"]:
                res += block_list("filter", val, self.filter_schema) if isinstance(val, list) else block("filter", val, self.filter_schema)
            elif key == "processors":
                res += self.pipeline_processors_engine(val)
            else:
                res += assignmentString(key,val)
        return res


    def to_Terraform_Code(self, resource_name):
        """
        Convert datadog logs pipeline json file to terraform code.
            Args:
            . resource_name - terraform resource name.
        """
        terraform_string = self.pipeline_schema(self._pipeline_dict)
        terraform_string = \
        f'resource "datadog_logs_custom_pipeline" {resource_name} {{\n' + \
            terraform_string + \
                f'\n}}'
        return terraform_string