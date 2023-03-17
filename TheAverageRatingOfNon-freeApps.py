app_and_price = [['Facebook', 0], ['Instagram', 0], ['Plants vs. Zombies', 0.99], ['Minecraft: Pocket Edition', 6.99], ['Temple Run', 0], ['Plague Inc.', 0.99]]

free_app_name = []
for row in app_and_price:
    name = row[0]
    price = row[1]
    
    if price ==0:
        free_app_name.append(name)
print(free_app_name)
    