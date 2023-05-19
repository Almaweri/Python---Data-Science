print(hash(4))
print(hash('four'))
print(hash(3.245))
print(hash(True))

#An odd "gotcha" is when we mix integers with Booleans
# as dictionary keys. The hash() command converts the Boolean True to 1,
# and the Boolean False to 0. 
# This means the Booleans True and False will conflict with the integers 0 and 1. 
# The dictionary keys won't be unique anymore,
# and Python will only keep the first key and the last value in cases like that.

d_1 = {1: 'one', True: 'Boolean'}
d_2 = {False: 'Bool', 0: 'zero'}
d_3 = {0: 'zero', 1: 'one',  2: 'two', True: 'true',
       False: 'false'}

print(type(d_1[1]))
print(type(d_1[True]))
print(type(d_2[False]))
print(type(d_2[0]))
print(type(d_3[0]))
print(type(d_3[1]))
print(type(d_3[2]))
print(type(d_3[True]))
print(type(d_3[False]))

print(d_1)
print(d_2)
print(d_3)

print(len(385))