apps_data = [['Facebook', 0.0], ['Notion', 14.99], ['Astropad Standard', 29.99], ['NAVIGON Europe', 74.99]]

for app in apps_data:
    price = app[1]
    
    if price == 0:
        app.append('Free')
    elif price > 0 and price < 20:
        app.append('afforable')
    elif price >=20 and price < 50:
        app.append('Expensive')
    elif price >= 50:
        app.append('Very Expensive')
print(apps_data)