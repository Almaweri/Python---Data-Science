import csv

try:
    with open('D:/Python/PthonRep/Python---Data-Science/AppleStore.csv', encoding='utf-8') as file:
        csv_reader = csv.reader(file)
        apps_data = [row for row in csv_reader]
        print("Successfully read {} rows from file.".format(len(apps_data)))
        if len(apps_data) > 0:
            print("First 5 rows of data:")
            for row in apps_data:
                print(row)
        else:
            print("File is empty.")
except FileNotFoundError:
    print("File not found.")
except Exception as e:
    print("Error occurred while reading file: {}".format(e))