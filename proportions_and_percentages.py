from csv import reader

with open('D:/Python/AppleStore.csv', encoding='utf-8') as opened_file:
    read_file = reader(opened_file)
    apps_data = list(read_file)
    
genre_counting = {}

for gnre in apps_data[1:]:
    gnre = gnre[12]
    
    if gnre in genre_counting:
        genre_counting[gnre] += 1 # checking and filling up the dict
    else:
        genre_counting[gnre] = 1
print("Genre_counting:  ", genre_counting)