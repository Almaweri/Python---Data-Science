opened_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(opened_file)
app_data = list(read_file)

rating_games = []

for row in app_data[1:]:
    rating = float(row[8])
    genre = row[12]
    if genre == 'Games':
        rating_games.append(rating)
avg_rating_games = sum(rating_games) / len(rating_games)
print(avg_rating_games)
