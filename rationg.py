data_path = open(r'C:\Users\t3281ma\Desktop\All DATA\1.1 Py\Python---Data-Science\AppleStore.csv', encoding='ISO-8859-1')

from csv import reader
read_data = reader(data_path)
app_data = list(read_data)

n_app_more_9 = 0
n_app_less_9 = 0
sum_rating = 0

for row in app_data[1:]:
    price = float(row[5])
    rating = float(row[9])
    
    if price >= 9:
        sum_rating += rating
        
        n_app_more_9 = n_app_more_9 + 1
        
    else:
        n_app_less_9 = n_app_less_9 + 1

avg_rating = sum_rating / n_app_more_9

print("Average rating of apps with price greater than $9: ", avg_rating)
print("Number of apps with price greater than $9: ", n_app_more_9)
print("Number of apps with price less than or equal to $9: ", n_app_less_9)