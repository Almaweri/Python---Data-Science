url = open('C:/Users/t3281ma/Desktop/Python/AppleStore.csv', encoding='ISO-8859-1')

from csv import reader
csv_data = reader(url)
data_list = list(csv_data)

over_4 = []
over_9 = []
over_12 = []
over_17 = []

for row in data_list:
       content_ratings = row[11]
       if content_ratings == '4+':
           over_4.append(row)
       elif content_ratings == '9+':
           over_9.append(row)
       elif content_ratings == '12+':
           over_12.append(row)
       elif content_ratings == '17+':
           over_17.append(row)
           
print("Over_4 :  ", len(over_4))
print("Over_9 :  ", len(over_9))
print("Over_12 :  ", len(over_12))
print("Over_17 :  ", len(over_17))
