content_ratings = {'4+': 4433, '9+': 987, '12+': 1155, '17+': 622}

for key in content_ratings:
    value = content_ratings[key]
    print('key:', key)
    print('value:', value)
    total = sum(content_ratings.values())
    keys = content_ratings.keys()
    minimum_val = min(content_ratings.values())
    maximum_val = max(content_ratings.values())
    
print("total  ", total)
print("keys: ", keys)
print(minimum_val)
print(maximum_val)

