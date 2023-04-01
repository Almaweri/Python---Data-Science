
open_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(open_file)
apps_data = list(read_file)

for app in apps_data[1:]:
    price = float(app[7])
    # Complete code from here
    if price == 0.0:
        app.append('free')
    else:
        app.append('not free')
apps_data[0].append('free_or_not')

print(apps_data[0:5])

