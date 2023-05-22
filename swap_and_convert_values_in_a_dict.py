content_ratings = {'4+': 622, '12+': '1155', '9+': 987, '17+': 4433}

temp = content_ratings['4+']
content_ratings['4+'] = content_ratings['17+']
content_ratings['17+'] = temp
content_ratings['12+'] = int(content_ratings['12+'])

print(content_ratings)