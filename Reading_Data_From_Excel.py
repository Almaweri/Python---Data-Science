import pandas as pd

file_path = r'C:\Users\t3281ma\Desktop\All DATA\Dev Tasks\Database Tebels\EDAPNVQ500.csv'
vehicle_make = set()

# Read the CSV file in chunks
chunksize = 10000  # Adjust this value based on your system's resources
for chunk in pd.read_csv(file_path, chunksize=chunksize, error_bad_lines=False):
    for index, row in chunk.iterrows():
        make_m = row[3]

        if make_m not in vehicle_make:
            vehicle_make.add(make_m)
            print(make_m)

# Print the last vehicle make
if len(vehicle_make) > 0:
    make_m = list(vehicle_make)[-1]
    print("make is:  " + make_m)
