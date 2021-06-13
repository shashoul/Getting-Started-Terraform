import json, time

# fixed_name = "web"
# result = {
#   "name": f"{fixed_name}-{int(time.time())}",
#   "info": {"AA": 1}
# }

# data = { "data": {
#         "name": "youName",
#         "age": 38,
#         "points": {
#             "p1": 12,
#             "p2": 14,
#             "p3": 15,
#             "p4": 17
#         }
#     }}

# print(json.dumps(data))

with open("configuration.tf.json", "r") as f:
  # mydict = json.loads(f.read())
  content = f.read()

# print(json.loads(content))

content = json.loads(content)
content["variable"]["result"]["default"] = "testing"

with open('data.tf.json', 'w') as outfile:
    json.dump(content, outfile)