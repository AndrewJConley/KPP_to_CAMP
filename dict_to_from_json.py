import json

# dictionary:
x_dict = {
  "name": "John",
  "age": 30,
  "married": True,
  "divorced": False,
  "children": ("Ann","Billy"),
  "empty": {},
  "pets": None,
  "cars": [
    {"model": "BMW 230", "mpg": 27.5},
    {"model": "Ford Edge", "mpg": 24.1}
  ]
}

print(x_dict)



# JSON
# JSON in python is a string
x_json = json.dumps(x_dict, indent=4)

print(x_json)




# conversion back to a python dict
x_returned_dict = json.loads(x_json)

print(x_returned_dict)

