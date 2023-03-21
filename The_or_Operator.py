#open the file using the open function
#save the output to a variable called opened_file
opened_file = open('AppleStore.csv', encoding='utf-8')

# Read the opened file using the reader() function
from csv import reader

# Save the output to a variable named read_file
read_file = reader(opened_file)

#Transform the read-in file to a list using list() function 
apps_data = list(read_file)

games_social_rating = []
for row in apps_data[1:]:
    rating = float(row[7])
    genre = row[11]
    
    if genre == 'Socail Media' or genre =='Games':
        games_social_rating.append(rating)
print(games_social_rating[:5])
print(len(games_social_rating))
    