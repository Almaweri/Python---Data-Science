content_ratings = {'4+': 4433, '9+': 987, '12+': 1155, '17+': 622}

#check if the key exists in the dict
is_in_dictionary_1 = '9+' in content_ratings

#check if a value exists in a dict
is_in_dictionary_2 = 987 in content_ratings


#if a key 17+ exists in the dict,
# then assign the vaule to a new variable called results and then print the results
if '17+' in content_ratings:
    result = 'It exists'
print(result)