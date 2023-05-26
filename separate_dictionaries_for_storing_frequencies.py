content_ratings = {'4+': 4433, '9+': 987, '12+': 1155, '17+': 622}

proportions = {} #the value of the key divided by the total of all values 
precentages = {} #the value of the key divided by the total of all values * 100
total_apps = sum(content_ratings.values())

for rating, frequency in content_ratings.items():
    proportion = frequency / total_apps 
    precentage = (frequency / total_apps) * 100
    proportions[rating] = proportion

    precentages[rating] = precentage
    
print("Proportions:", proportions)
print("Precentage", precentages)
