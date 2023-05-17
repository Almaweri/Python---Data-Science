open_file = open('D:\\Python\\AppleStore.csv', encoding='utf-8')

from csv import reader
file_data = reader(open_file)
data_list = list(file_data)

# creating below so I could append the rating to each category
over_4 = []
over_9 = []
over_12 = []
over_17 = []

for app_rate in data_list:
    rating = app_rate[11]

    if rating == '4+':
        over_4.append(rating)
    elif rating == '9+':
        over_9.append(rating)
    elif rating == '12+':
        over_12.append(rating)
    elif rating == '17+':
        over_17.append(rating)

print("Over_4 is: ", len(over_4))
print("Over_9 is: ", len(over_9))
print("Over_12 is: ", len(over_12))
print("Over_17 is: ", len(over_17))

        
