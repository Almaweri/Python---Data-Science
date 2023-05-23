from csv import reader

with open('D:/Python/AppleStore.csv', encoding='utf-8') as opened_file:
    read_file = reader(opened_file)
    apps_data = list(read_file)

content_ratings = {'4+': 0, '9+': 0, '12+': 0, '17+': 0}

#loop through the apps_data without the header row:

for c_rating in apps_data[1:]:
    c_rating = c_rating[11]
    if c_rating in content_ratings:
        content_ratings[c_rating] += 1
print(content_ratings)