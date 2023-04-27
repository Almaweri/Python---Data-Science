open_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
apps_data = list(open_file)
for app in apps_data:
    price = app[7]

    if price == 0.0:
        app.append('free')
    if price > 0.0 and price < 20:
        app.append('affordable')
    if price >= 20 and price < 50:
        app.append('expensive')
    if price >= 50:
        app.append('very expensive')

print(apps_data[0:5])