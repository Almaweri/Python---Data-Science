apps_data = [['Call of Duty: Zombies', 5.0], ['Facebook', 0.0], ['Instagram', 0.0], ['Temple Run', 0.0]]

for app in apps_data:
    price = app[1]
    if price == 0.0:
        app.append('Free')
    else:
        app.append('Not Free')
print(apps_data)