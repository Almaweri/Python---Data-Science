numbers = [5, 4, 33, 54, 2, 1, 31]
min_number = min(numbers)
max_number = max(numbers)
print(min_number)
print(max_number)

empty_list = []
min_value = min(empty_list, default= 5)
print(min_value)

words = ['apple', 'banana', 'cherry', 'abab','date' ]
shortest_word = min(words, key=len)
print(shortest_word)

# modulo

smallest_number = min(numbers, key= lambda x: x + 10)
print(smallest_number)