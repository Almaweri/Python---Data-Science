opened_file = open('AppleStore.csv')
from csv import reader
read_file = reader(opened_file)
apps_data = list(read_file)

free_apps_ratings = []
for row in apps_data[1:]:
    rating = float(row[7])
    price = float(row[4])
    
    if price == 0.0:
        free_apps_ratings.append(rating)
avg_rating_free = sum(free_apps_ratings) / len(free_apps_ratings)
print(avg_rating_free)


#Example