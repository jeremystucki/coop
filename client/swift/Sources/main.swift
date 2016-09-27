let api = try CoopAPI()

print(api.getLocations().joined(separator: "\n"))

