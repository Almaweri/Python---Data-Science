
from csv import reader
with open('D:\Python\VOQ DATA _CSV.csv', encoding= 'utf-8') as excel_data:
    read_data = reader(excel_data)
    list_data = list(read_data)

#loop over the data
for row in list_data:
    row_by_row = row[0:1]

print('row: ', row)
print('row_by_row:  ', row_by_row)
excel_data.close()
