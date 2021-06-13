from datadog import api, initialize
from dashboard import Dashboard
import os
import json

options = {
    'api_key': os.getenv("DATADOG_API_KEY"),
    'app_key': os.getenv("DATADOG_APP_KEY")
}

initialize(**options)

# dastboards = api.Dashboard.get_all()

# # for dashboard in dastboards.keys():
#     # print(f'{dashboard} \n')

# # print(dastboards["dashboards"][1])

# for ids in dastboards["dashboards"]:
#     # print(ids["id"], ids["title"])
#     if ids["title"] == "Infrastructure Overview":
#         json = api.Dashboard.get(ids["id"])
#         print("====================")
#         # converter = Dashboard(json)
#         # print(converter.to_Terraform_Code(resource_name="test_dashboard"))
#         print(Dashboard(json).to_Terraform_Code(resource_name="test_dashboard"))



# synthetic_test = api.Synthetics.get_all_tests()
# print(synthetic_test)
# tests = synthetic_test["tests"][0]
# print(tests)

# synthetic_test = api.Synthetics.get_test("m9i-ujv-c9s")
# synthetic_test = api.Synthetics.get_test("6v9-9pk-my3")
# synthetic_test = api.Synthetics.get_test("v7z-33z-989")
# synthetic_test = api.Synthetics.get_test("dns-ten-d55")
# synthetic_test = api.Synthetics.get_test("z2b-gec-5ak")
# synthetic_test = api.Synthetics.get_test("edv-ef9-uek")   
# synthetic_test = api.Synthetics.get_test("d69-23c-vm8")
# synthetic_test = api.Synthetics.get_test("m9i-ujv-c9s")
# synthetic_test = api.Synthetics.get_test("6v9-9pk-my3")
synthetic_test = api.Synthetics.get_test("ah6-p4r-sqf")
print(type(synthetic_test))
print(synthetic_test)

# with open("../project8/synthetic_test#8.json","w") as f:
# with open("../project8/synthetic_test#7.json","w") as f:
    # json.dump(synthetic_test, f)

