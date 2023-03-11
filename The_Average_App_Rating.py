
row_1 = ['Facebook', 0.0, 'USD', 2974676, 3.5]
row_2 = ['Instagram', 0.0, 'USD', 2161558, 4.5]
row_3 = ['Clash of Clans', 0.0, 'USD', 2130805, 4.5]
row_4 = ['Fruit Ninja Classic', 1.99, 'USD', 698516, 4.5]
row_5 = ['Minecraft: Pocket Edition', 6.99, 'USD', 522012, 4.5]

app_data_set = [row_1, row_2, row_3, row_4, row_5]

rating_sum = 0
for row in app_data_set:
    rating = row[3]
    rating_sum += rating
    print("print the rating:  " + str(rating_sum))

avg_rating = rating_sum / 5
print(avg_rating)
   
#  Instructions
# Calculate the average app rating for the apps stored in the app_data_set variable.

# Initialize a variable named rating_sum with a value of zero outside the loop body.
# Loop (iterate) over the app_data_set list of lists. For each of the five iterations of the loop (for each row in app_data_set):
# Extract the rating of the app, and store it to a variable named rating. The rating is the last element of each row.
# Add the value stored in rating to the current value of rating_sum and assign the result back to rating_sum.
# Outside the loop body, divide the rating sum (stored in rating_sum) by the number of ratings to get an average value. Store the result in a variable named avg_rating.
