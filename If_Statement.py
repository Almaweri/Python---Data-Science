open_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(open_file)
apps_data = list(read_file)

free_app = []
non_free = []

for row in apps_data[1:]:
	rating = float(row[7])
	price = float(row[7])
	#ratings.append(rating)
	
	if price == 0:
		free_app.append(rating)
	else:
		non_free.append(rating)
print(free_app)
print(non_free)