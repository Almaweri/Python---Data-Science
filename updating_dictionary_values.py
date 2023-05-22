content_ratings = {
    '4+': 4433,
    '12+': 1155,
    '9+': 987,
    '17+': 622
    }

#Change the value corresponding to the dictionary key '4+' from 4433 to 0.
content_ratings['4+'] = 0

#Add 13 to the value corresponding to the dictionary key '9+'.
content_ratings['9+'] += 13
#or content_ratings['9+'] = content_ratings['9+'] +13

#Subtract 1155 from the value corresponding to the dictionary key '12+'.
content_ratings['12+'] -= 1155

#Change the value corresponding to the dictionary key '17+' from 622 (integer) to '622' (string).
content_ratings['17+'] = '622'

print(content_ratings)