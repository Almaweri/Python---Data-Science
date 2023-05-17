from csv import reader

# creating key and value of a dictionary. Values are set to 0
rating_counts = {
    '4+': 0,
    '9+': 0,
    '12+': 0,
    '17+': 0
}

with open('D:\\Python\\AppleStore.csv', encoding='utf-8') as open_file:
    file_data = reader(open_file) # read data
    data_list = list(file_data) # add data to a list
    
    for app_rate in data_list:
        rating = app_rate[11] # column 11 has all apps rating
        
        if rating in rating_counts: #means if it is 4+, 9+, 12+, 17+
            rating_counts[rating] += 1

print("Number of apps with 4+ rating:", rating_counts['4+'])
print("Number of apps with 9+ rating:", rating_counts['9+'])
print("Number of apps with 12+ rating:", rating_counts['12+'])
print("Number of apps with 17+ rating:", rating_counts['17+'])
    
    