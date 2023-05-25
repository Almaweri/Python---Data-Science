new_str = "The cow jumped over the moon."
new_str.split()
print(new_str)
#2. Here  the separator is space, and the maxsplit argument is set to 3.
new_str1 = "The cow jumped over the moon."
new_str1.split(' ', 3)
print(new_str1)

#3. Using '.' or period as a separator.
new_str2 = "The cow jumped over the moon."
new_str2.split('.')
print(new_str2)

#4. Using no separators but having a maxsplit argument of 3.   

new_str3 = "The cow jumped over the moon."
new_str3.split(None, 3)
print(new_str3)