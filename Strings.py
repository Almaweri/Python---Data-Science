username = "Kinari"
timestamp = "04:50"
url = "http://petshop.com/pets/mammals/cats"

# TODO: write a log message using the variables above.
# The message should have the same format as this one:
# "Yogesh accessed the site http://petshop.com/pets/reptiles/pythons at 16:20."

message = username + ' accessed the site ' + url + " at " + timestamp
print(message)

given_name = "William"
middle_names = "Bradley"
family_name = "Pitt"
# Todo: calculate how long this name is
name_length = (len(given_name + middle_names + family_name)) #replace `None` with your code
print(name_length)
# Now we check to make sure that the name fits within the driving license character limit
# Uncomment the code below. You don't need to make changes to the code.

driving_license_character_limit = 28
print(name_length <= driving_license_character_limit)
