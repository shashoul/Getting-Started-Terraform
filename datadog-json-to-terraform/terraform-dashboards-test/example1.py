from terraform_external_data import terraform_external_data
import requests
import json

@terraform_external_data
def fetch(query):
    # Terraform requires the values you return be strings,
    # so terraform_external_data will error if they aren't.
    todo_id = query['id']
    response = requests.get(f'https://jsonplaceholder.typicode.com/todos/{todo_id}')
    output_json = response.json()
    return {str(key): str(value) for key, value in output_json.items()}


if __name__ == '__main__':
    fetch()