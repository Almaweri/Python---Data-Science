content_ratings = {'4+': 0, '9+': 0, '12+': 0, '17+': 0}
ratings = ['4+', '4+', '4+', '9+', '9+', '12+', '17+']

for c_rating in ratings:
    if c_rating in content_ratings:
        print('each rating is: ', content_ratings[c_rating])
    print(content_ratings)
    
print('Final dictionary:')
print(content_ratings)