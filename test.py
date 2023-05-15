import pandas as pd

url = 'C:\\Users\\t3281ma\\Desktop\\Python\\VOQ DATA.xlsx'
app_data = pd.read_excel
data = list(app_data)


for row in data:
    new_rows = row[1]
print(new_rows)