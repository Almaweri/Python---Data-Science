#What's the average rating of non-free apps?
#What's the average rating of free apps?

opened_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(opened_file)
apps_data = list(read_file)

apps_names = []
for row in apps_data[1:]:
    name = (row[2])
    apps_names.append(name)
print(apps_names[:5])