from datadog import api, initialize
from dashboard import Dashboard
import os

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

synthetic_test = api.Synthetics.get_test("m9i-ujv-c9s")
print(synthetic_test)