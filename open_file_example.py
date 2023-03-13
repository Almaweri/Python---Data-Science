#open the file using the open function
#save the output to a variable called opened_file
opened_file = open('AppleStore.csv', encoding='utf-8')

# Read the opened file using the reader() function
from csv import reader

# Save the output to a variable named read_file
read_file = reader(opened_file)

#Transform the read-in file to a list using list() function 
apps_data = list(read_file)

print(len(apps_data))
print(apps_data[0])
print(apps_data[1:3])