name= "Maged Almaweri"

name = "Maged Almaweri"

# title() returns a version of the string where the first character of each word is capitalized
print(name.title())

# islower() checks whether all the characters in the string are lowercase, returning True if so and False otherwise
print(name.islower())

# capitalize() returns a copy of the string with only its first character capitalized
print(name.capitalize())

# casefold() returns a version of the string that is suitable for caseless comparisons, this is more aggressive than the lower() method
print('casefold:  ', name.casefold())

# center() returns a centered string. Note that you need to use an integer, not a string.
print(name.center(45))

# encode() returns the encoded version of the string as a bytes object
print('encode:  ', name.encode())

# endswith() returns True if the string ends with the specified suffix, False otherwise
print(name.endswith('Laila'))

# expandtabs() replaces all tab characters ("\t") in the string with the correct number of spaces for a tab stop. 
# If your string doesn't contain tabs, it returns the original string.
print(name.expandtabs())

# find() returns the lowest index in the string where substring 'a' is found
print(name.find('a'))

# format() formats the specified value(s) and insert them inside the string's placeholder. As we have no placeholders, this will return the original string.
print(name.format())

# format_map() is similar to format() but takes a dictionary. As we have no dictionary, this will return an error.

# index() works like find() but raises an exception if the substring is not found. We need to specify a substring to look for.
#print(name.index('a'))  # Uncomment this line after replacing 'a' with the substring you want to find

# isalnum() returns True if all characters in the string are alphanumeric (either alphabets or numbers), False otherwise
print(name.isalnum())

# isalpha() returns True if all characters in the string are alphabets, False otherwise
print(name.isalpha())

# isdecimal() returns True if all characters in the string are decimals (0-9), False otherwise
print(name.isdecimal())

# isdigit() returns True if all characters in the string are digits, False otherwise
print(name.isdigit())

# isidentifier() checks if the string is a valid identifier according to Python's rules. This would typically be used to see if a string is a valid variable name.
print(name.isidentifier())

# isnumeric() returns True if all characters in the string are numeric characters
print(name.isnumeric())

# isprintable() returns True if all characters in the string are printable or the string is empty, False otherwise
print(name.isprintable())

# isspace() returns True if all characters in the string are whitespaces
print(name.isspace())

# istitle() returns True if the string follows the rules of a title (first letter of each word is capitalized, others are lowercase)
print(name.istitle())

# isupper() returns True if all characters in the string are uppercase
print(name.isupper())

# join() concatenates the elements of an iterable with the string acting as a delimiter between each element. We need an iterable to use this function.
#print(name.join(iterable))  # Uncomment this line after replacing 'iterable' with the iterable you want to join

# ljust() returns a left-justified version of the string. We need to specify the total length of the new string.
#print(name.ljust(30))  #


count_fish = "one fish, tow fish, three fish, four fish, fishier man"
print(count_fish.count('fish'))