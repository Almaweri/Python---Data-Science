n_of_apps = 0

for row in apps_data[1:]:
    rating = float(row[7])
    if rating >= 4.0:
        n_of_apps = n_of_apps + 1

print(n_of_apps)