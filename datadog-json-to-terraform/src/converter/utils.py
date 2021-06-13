import logging


def literalString(value):
    """
    Return string represents the received value.
    """
    logging.debug(f'In literalString func value => {value}')
    if isinstance(value, str):
        ### new new
        # value = value.replace('\\','\\\\')
        if "%{" in value:
            value = value.replace('%{','%%{')
        if "\n" in value:
            return f'<<EOF\n{value}\nEOF'
        value = value.replace('\\','\\\\')
        if '"' in value:
            # temp = str.maketrans('"',"'")
            # value = value.translate(temp)
            value = value.replace('"','\\"')
        # if "\n" in value:
            # return f'<<EOF\n{value}\nEOF'
        return f'"{value}"'
    elif isinstance(value, list):
        res = "["
        for elm in value:
            res += literalString(elm) + ","
        return res + "]"
    elif isinstance(value, dict):
        res = "{"
        for key, val in value.items():
            res += assignmentString(key, val)
        return res + '\n }'
    elif isinstance(value, bool):
        res = str(value).lower()
        return res
    elif value is None:
        return "null"
    return value


def assignmentString(key, val):
    """
    Return a string represents key assignment according to the received value.        
        Args:
        . key - represents the left side of the assignment.
        . val - represents the value of the assignment.
    """
    displayvalue = literalString(val)
    logging.debug(f'In assignmentString func key => {key} , displayvalue => {displayvalue}')
    return f'\n {key} = {displayvalue}'


def block(name, content, converter):
    """
    Create terraform block.
        Args:
        . name      - block name.
        . content   - block dict.
        . converter - schema converter function
    """
    res =""
    res += f'\n {name} ' + '{'
    for key, val in content.items():
        res += converter(key, val)
    return res + '\n } '


def block_list(name, content, converter):
    """
    Create terraform block list.
        Args:
        . name      - block name.
        . content   - list of block dict.
        . converter - schema converter function
    """
    res = ""
    for elm in content:
        res += block(name, elm, converter)
    return res