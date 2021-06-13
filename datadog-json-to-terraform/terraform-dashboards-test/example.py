from os import write
import sys
import json
import requests

def fetch():
    # The program needs to read the passed data in query from stdin
    input_json = sys.stdin.read()
    try:
        # The string data passed by query has json format
        input_dict = json.loads(input_json)
        todo_id = input_dict.get('id')
        # Retrieve TODO data with specified id in query from JSONPlaceholder API
        response = requests.get(f'https://jsonplaceholder.typicode.com/todos/{todo_id}')
        output_json = response.json()
        # The output is a json string with all key's values as string type
        output = json.dumps({str(key): str(value) for key, value in output_json.items()})
        output = json.dumps({"monitors": "temp.json"})
        aList = [{"a":54, "b":87}, {"c":81, "d":63}, {"e":17, "f":39}]
        jsonString = json.dumps(aList)
        # The output must be returned in stdout
        with open("temp.json","w") as f:
            f.write(jsonString)
        # sys.stdout.write(output)
        sys.stdout.write(output)
    except ValueError as e:
        sys.exit(e)

if __name__ == "__main__":
    fetch()