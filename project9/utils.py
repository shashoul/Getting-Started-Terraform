
def literalString(value):
    if isinstance(value, str):
        if "\n" in value:
            return f'<<EOF\n{value}\nEOF'
        if '"' in value:
            temp = str.maketrans('"',"'")
            value = value.translate(temp)
        return f'"{value}"'
    elif isinstance(value, list):
        res = "["
        for elm in value:
            res += literalString(elm) + ","
        return res + "]"
    elif isinstance(value, bool):
        res = str(value).lower()
        return res
    return value


def assignmentString(key, value):
    displayvalue = literalString(value)
    return f'\n {key} = {displayvalue}'    


def blocklist(array, contents, converter):
    for item in array:
        print(item)


def convertWidgets(k, v):
    pass