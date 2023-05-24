mon_sales = "121"
tues_sales = "105"
wed_sales = "110"
thurs_sales = "98"
fri_sales = "95"

#TODO: assign the total sales to a string with this format: This week's total sales: xxx
# You will probably need to write some lines of code before the assigning statement.

result_string = (int(mon_sales) + int(tues_sales) + int(wed_sales)
         + int(thurs_sales) + int(fri_sales))
print("This week's total sales: ", result_string)