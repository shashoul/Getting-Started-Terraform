import json

with open("../configuration/development.json", "r") as json_file:
    content = json.load(json_file)


conf = {"variable": {}}
for module in content.keys():
    print(f"==================== {module} ====================")
    for variable in content[module].keys():
        conf["variable"][variable] = {}
        conf["variable"][variable]["default"] = content[module][variable]


print(conf)

with open("conf.tf.json", "w") as json_file:
    json.dump(conf, json_file)