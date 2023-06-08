from csv import reader

with open('D:/Python/AppleStore.csv', encoding='utf-8') as opened_file:
    read_file = reader(opened_file)
    apps_data = list(read_file)
    
size_freq = {}

for row in apps_data[1:]:
    size = row[3]
    
    if size in size_freq: # checking if the size exist in the new dict so we could fill it up
        size_freq[size] += 1
    else:
        size_freq[size] = 1
print("len of size_freq:  ", len(size_freq))
print("size_freq: ", size_freq)
        