
opened_file = open('AppleStore.csv')
from csv import reader
read_file = reader(opened_file)
apps_data = list(read_file)

for app in apps_data[1:]:
    price = float(app[4])

    if price == 0:
        app.append('free')
    elif price > 0 and price < 20:
        app.append('affordable')
    elif price >= 20 and price <50:
        app.append('expensive')
    elif price > 50:
        app.append('very expensive')
# Add a new column header for the price label
apps_data[0].append('price_label')

# Print the header row and first five rows of data to confirm the changes
print(apps_data[0])
for row in apps_data[1:6]:
    print(row)
print(apps_data[0])