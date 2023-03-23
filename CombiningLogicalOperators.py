open_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(open_file)
apps_data = list(read_file)

n_of_apps = 0

for row in apps_data[1:]:
    rating = float(row[7])
    if rating >= 4.0:
        n_of_apps = n_of_apps + 1

print(n_of_apps)