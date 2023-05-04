import matplotlib.pyplot as plt

# Helper function to fetch the year from a given date string
def fetch_year(date):
    return int(date.split(", ")[-1])

# Read data from the text file
file_path = r"D:\Python\Prison Break Data.txt"
with open(file_path, "r") as file:
    data = [line.strip().split(",") for line in file.readlines()]

# Remove the details from each row
for row in data:
    row.pop()

# Extract the year from the date in each row
for row in data:
    year = fetch_year(row[0])
    row[0] = year

# Calculate the minimum and maximum years
min_year = min(data, key=lambda x: x[0])[0]
max_year = max(data, key=lambda x: x[0])[0]

# Create a list of years within the range
years = list(range(min_year, max_year + 1))

# Initialize attempts per year list with zeros
attempts_per_year = [[year, 0] for year in years]

# Count the number of attempts for each year
for row in data:
    for year_attempt in attempts_per_year:
        year = year_attempt[0]
        if row[0] == year:
            year_attempt[1] += 1

# Create a bar plot to visualize the results
years, attempts = zip(*attempts_per_year)
plt.bar(years, attempts)
plt.xlabel("Year")
plt.ylabel("Number of Attempts")
plt.title("Prison Break Attempts per Year")
plt.show()
