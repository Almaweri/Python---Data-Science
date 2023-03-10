
row_1 = ['Facebook', 0.0, 'USD', 2974676, 3.5]
row_2 = ['Instagram', 0.0, 'USD', 2161558, 4.5]
row_3 = ['Clash of Clans', 0.0, 'USD', 2130805, 4.5]
row_4 = ['Fruit Ninja Classic', 1.99, 'USD', 698516, 4.5]
row_5 = ['Minecraft: Pocket Edition', 6.99, 'USD', 522012, 4.5]

app_data_set = [row_1, row_2, row_3, row_4, row_5]

rating_sum = 0
for row in app_data_set:
    rating_count = row[3] 
    rating_sum = rating_sum + rating_count
    print(rating_sum)
print(rating_sum)

#  Instructions
#  Calculate the total number of app ratings for the apps stored in the app_data_set variable.

#  Initialize a variable named rating_sum with a value of zero outside the loop body.
#  Loop (iterate) over the app_data_set list of lists. For each of the five iterations of the loop (for each row in app_data_set):
#  Extract the rating count of the app, and store it to a variable named rating_count.
#  Add the value stored in rating_count to the current value of rating_sum and assign the result back to rating_sum.
#  Print rating_sum.

# rating_sum = 0 this is the default value 
#rating_sum = 0 + row[3.5] = 3.5
#rating_sum = 3.5 + row[4.5] = 8
#rating_sum = 8 + row[4.5] = 12.5
#rating_sum = 12.5 + row[4.5] = 17
#rating_sum = 17 + row[4.5] = 21.5