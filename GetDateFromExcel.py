import pandas as pd

# Read data from the Excel file
excelData = pd.read_excel('D:\Python\VOQ DATA.xlsx')

# Convert the DataFrame to a list of lists
new_data = excelData.values.tolist()

# Initialize an empty list to store the processed data
main_list_of_data = []

# Process each row and store the data in main_list_of_data
for row in new_data:
    set_of_new_lists = row[:-1]
    main_list_of_data.append(set_of_new_lists)

# Get the VOQ value from the user and convert it to an integer
specific_value = int(input("Enter your VOQ: "))

# Search for the specific VOQ value in the data and print the corresponding row
found = False
for row in main_list_of_data:
    if row[0] == specific_value:
        print(row)
        found = True
        break

# If the specific VOQ value is not found, print a message
if not found:
    print("VOQ not found.")
