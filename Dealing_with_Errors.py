opened_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
read_file = reader(opened_file)
apps_data = list(read_file)

rating_sum = 0

for row in apps_data[1:]:
   # print(len(row))
    rating = float(row[7])
    rating_sum = rating_sum + rating
    avg_rating = rating_sum / len(apps_data[1:])
    nah = len(apps_data[1:])
    #print(nah)
    avg_rating2 = rating_sum / 7197
print(avg_rating)
print(avg_rating2)
    