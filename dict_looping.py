content_ratings = {'4+': 4433, '12+': 1155, '9+': 987, '17+': 622}
total_number_of_apps = 7197

for key in content_ratings:
    value = content_ratings[key] / total_number_of_apps
    print('value: ', value)
    value_prop = value * 100
    print('val prop:  ', value_prop)
    percentage_17_plus = content_ratings['17+'] / total_number_of_apps * 100
    print('17+:  ', percentage_17_plus)
    percentage_15 = content_ratings['4+'] +  content_ratings['9+'] +  content_ratings['12+']
    percentage_15_allowed = (percentage_15 / total_number_of_apps) * 100
    print('15+ allowd: ', percentage_15_allowed)
    