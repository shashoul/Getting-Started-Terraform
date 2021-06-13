import importlib

_module = importlib.import_module("utils")

func = getattr(_module, "assignmentString")

print(func("name","shady"))
