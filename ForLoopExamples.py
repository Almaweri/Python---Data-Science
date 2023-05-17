
excel_data = open('D:\Python\VOQ DATA _CSV.csv', encoding= 'utf-8')

# import the reader from CSV
from csv import reader

#read_and_store_date_here
read_data = reader(excel_data)

#change to a list:
list_data = list(read_data)

#loop over the data
for row in list_data[0]:
    row_by_row = row[1:6]
    print(row)
    print(row_by_row)