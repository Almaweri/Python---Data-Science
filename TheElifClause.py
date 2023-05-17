open_file = open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8')
from csv import reader
data_in_csv = reader(open_file)
apps_data = list(data_in_csv)

for app in apps_data[1:]:
    try:
        price = app[5]
        price = float(price)
        if price == 0.0:
            app.append('free')
        elif price > 0.0 and price < 20.0:
            app.append('affordable')
        elif price >= 20 and price < 50:
            app.append('expensive')
        elif price >= 50:
            app.append('very expensive')
    except ValueError:
        print("Invalid price value")        

for row in apps_data[0:4]:
    print("Price is: --->>>   ",  price)
    print(row)