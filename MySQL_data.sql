-- ##// INNER JOIN
-- ## ================ THINK about JOIN AS FROM ===================

SELECT sql_python.orders.*,
       orders.id, orders.account_id, orders.occurred_at, orders.standard_qty, orders.gloss_qty, orders.poster_qty, orders.total, orders.standard_amt_usd, orders.gloss_amt_usd, orders.poster_amt_usd, orders.total_amt_usd
   FROM sql_python.orders
   JOIN sql_python.accounts   
   ON orders.account_id = accounts.id

SELECT o.*, o.id, o.account_id, o.occurred_at, o.standard_qty, o.gloss_qty,
       o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd,
       o.poster_amt_usd, o.total_amt_usd
FROM sql_python.orders AS o
JOIN sql_python.accounts AS a
    ON o.account_id = a.id;

SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

-- //Quiz Questions

-- // 1- Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT acc.*, ord.*
FROM accounts as acc
JOIN orders as ord
ON acc.id =  ord.account_id;


-- // 2- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT ord.standard_qty, ord.gloss_qty, ord.poster_qty,
       acc.website, acc.primary_poc
FROM orders as ord
JOIN accounts as acc
ON ord.account_id = acc.id;


-- // ============= JOIN Revisited ===================

-- // Joining 3 tables

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id;

SELECT we.*, a.*, o.*
FROM web_events AS we
JOIN accounts AS a
    ON we.account_id = a.id
JOIN orders AS o
    ON a.id = o.account_id;

SHOW INDEX FROM sql_python.accounts;
SHOW INDEX FROM sql_python.orders;
SHOW INDEX FROM sql_python.region;
SHOW INDEX FROM sql_python.sales_reps;
SHOW INDEX FROM sql_python.web_events;


CREATE INDEX idx_web_events_account_id ON web_events (account_id);
CREATE INDEX idx_accounts_id ON accounts (id);
CREATE INDEX idx_orders_account_id ON orders (account_id);
CREATE INDEX idx_orders_occurred_at ON orders (occurred_at);

CREATE INDEX idx_account_id ON accounts (id);
CREATE INDEX idx_region_id ON region (id);

CREATE INDEX idx_sales_reps_region_id ON sales_reps (region_id);



CREATE INDEX idx_web_events_account_id ON web_events (account_id);
CREATE INDEX idx_accounts_id ON accounts (id);
CREATE INDEX idx_orders_account_id ON orders (account_id);

-- Execute the optimized query
SELECT *
FROM web_events
JOIN accounts
    ON web_events.account_id = accounts.id
JOIN orders
    ON accounts.id = orders.account_id;

-- ======================= LEFT and RIGHT JOINs

SELECT a.id, a.name, o.total 
From orders o
LEFT JOIN accounts a
ON o.account_id = a.id;

-- // Where Clause with Inner Join
SELECT o.*,
      a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.sales_rep_id = 321500



-- Questions
-- 1- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for the Midwest region. Your final table should include three columns: the region name, --
--the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name as REGION_NAME, s.name AS SALES_REP_NAME, a.name AS ACCOUNT_NAME
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name LIKE '%Midwest%'
ORDER BY a.name ASC;

-- 2- Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name as REGION_NAME, s.name AS SALES_REP_NAME, a.name AS ACCOUNT_NAME
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE s.name LIKE 's%' AND r.name LIKE '%Midwest%'
ORDER BY a.name ASC;

-- 3- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name as REGION_NAME, s.name AS SALES_REP_NAME, a.name AS ACCOUNT_NAME
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON  s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND SUBSTRING_INDEX(s.name, ' ', -1) LIKE 'k%'
ORDER BY a.name ASC;



-- 4- Provide the name for each region for every order, as well as the account name and the unit price they paid 
-- (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100.
-- Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .
-- 01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT r.name as REGION_NAME, a.name AS ACCOUNT_NAME, (o.total_amt_usd / o.total) as unit_price
FROM region r
JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id
JOIN orders o ON o.account_id = a.id
WHERE o.standard_qty > 100;

-- 5- Provide the name for each region for every order, as well as the account name and the unit price they paid
--  (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
-- Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT r.name as REGION_NAME, a.name AS ACCOUNT_NAME, (o.total_amt_usd / o.total+0.01) as unit_price
FROM region r
JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id
JOIN orders o ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_amt_usd > 50
ORDER BY unit_price ASC;
 
 
-- 6- Provide the name for each region for every order, as well as the account name and the unit price they paid 
-- (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 
-- and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. 
-- Sort for the largest unit price first. In order to avoid a division by zero error, adding . 
--01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT r.name as REGION_NAME, a.name AS ACCOUNT_NAME, (o.total_amt_usd / o.total+0.01) as unit_price
FROM region r
JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id
JOIN orders o ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_amt_usd > 50
ORDER BY unit_price DESC;

-- What are the different channels used by account id 1001? Your final table should have only 2 columns: 
-- account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT Distinct a.name NAME, w.channel Channel
FROM accounts a
JOIN web_events w ON w.account_id = a.id
JOIN orders o ON o.account_id = a.id
WHERE o.account_id = '1001';


-- Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, 
-- order total, and order total_amt_usd.

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-10-01' AND '2015-12-31';



-- NULLs and Aggregation ====== \\ ===\\\ ===\\\\===\\\===\\\=\=\=\=\\\\
-- When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL. We don't use =, 
-- because NULL isn't consideed a value in SQL. Rather, it is a property of the data.

Select *
FROM sql_python.accounts
WHERE primary_poc IS NOT Null;


-- First Aggregation - COUNT
SELECT COUNT(*) as order_count
FROM sql_python.orders
WHERE occurred_at >= '2016-12-01' AND occurred_at < '2017-01-01';

select * from orders
WHERE occurred_at >= '2016-12-01' AND occurred_at < '2017-01-01';

SELECT COUNT(a.id)
FROM accounts a;

SELECT * 
FROM accounts
WHERE primary_poc IS NULL;


-- SUM
SELECT SUM(o.standard_qty) AS standard,
       SUM(o.gloss_qty) AS gloss,
       SUM(o.poster_qty) AS poster
FROM orders o;

-- Quiz: SUM

-- 1- Find the total amount of poster_qty paper ordered in the orders table.
SELECT SUM(o.poster_qty) as poster
FROM orders o;

-- 2- Find the total amount of standard_qty paper ordered in the orders table.
SELECT SUM(o.standard_qty)
FROM orders o;

-- 3- Find the total dollar amount of sales using the total_amt_usd in the orders table.
SELECT SUM(o.total_amt_usd) as total_amt_usd
FROM orders o;

-- 4- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
SELECT SUM(o.total_amt_usd) as total_amt_usd, SUM(o.gloss_amt_usd) as gloss_amt_usd
FROM orders o;

-- 5- Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both aggregation and a mathematical operator.
SELECT SUM(o.standard_amt_usd) / SUM(o.standard_qty) as tandard_amt_usd_per_unit 
FROM orders o;


-- MIN & MAX

SELECT MIN(o.standard_qty) AS standard_min,
       MIN(o.gloss_qty) AS gloss_min,
       MIN(o.poster_qty) AS poster_min,
       MAX(o.standard_qty) AS standard_max,
       MAX(o.gloss_qty) AS gloss_max,
       MAX(o.poster_qty) AS poster_max
FROM orders o;

-- Quiz: MIN, MAX, & AVG

-- 1- When was the earliest order ever placed? You only need to return the date.
SELECT MIN(o.occurred_at) as min_date
FROM orders o;

-- 2- Try performing the same query as in question 1 without using an aggregation function.
SELECT o.occurred_at as min_date
FROM orders o
order by o.occurred_at ASC
limit 1;

-- 3- When did the most recent (latest) web_event occur?
SELECT MAX(w.occurred_at) as latest_web_event
FROM web_events w;

-- 4- Try to perform the result of the previous query without using an aggregation function.
SELECT w.occurred_at as latest_web_event
FROM web_events w
order by w.occurred_at DESC
limit 1;

-- 5- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT AVG(total) as total,
       AVG(poster_amt_usd) as poster_amt_usd,
       AVG(standard_amt_usd) as standard_amt_usd,
       AVG(gloss_amt_usd) as gloss_amt_usd,
       AVG(total_amt_usd) as total_amt_usd      
FROM orders;

-- 6- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

SELECT *
FROM (SELECT total_amt_usd
   FROM orders
   ORDER BY total_amt_usd
   LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- GROUP BY
SELECT account_id,
       SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders
GROUP BY account_id
ORDER BY account_id



-- Questions: GROUP BY

-- 1- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT a.name, o.occurred_at
from accounts a
JOIN orders o ON o.account_id = a.id
order by occurred_at asc
limit 1;

-- 2- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT a.name, SUM(o.total_amt_usd) AS total_amount   
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

--  3- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
SELECT w.channel, w.occurred_at, a.name
FROM web_events w
JOIN accounts a on a.id = w.account_id
ORDER BY w.occurred_at DESC
limit 1;

-- 4- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
SELECT  w.channel, COUNT(w.channel) as number_of_times_used
FROM web_events w
GROUP BY w.channel
ORDER BY w.channel;

-- 5- Who was the primary contact associated with the earliest web_event?

SELECT a.primary_poc, MIN(w.occurred_at) as earliest_web_event
FROM accounts a
JOIN web_events w on a.id = w.account_id
GROUP BY a.primary_poc
order by earliest_web_event;

-- 6- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name, MIN(o.total_amt_usd) as total_amt_usd
FROM accounts a
JOIN orders o ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_amt_usd ASC;

-- 7- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.
SELECT COUNT(s.id) as sales_reps_num, r.name AS region_name
FROM sales_reps s 
JOIN region r on r.id = s.region_id 
GROUP BY r.name
ORDER by sales_reps_num asc;


-- GROUP BY Part II

SELECT  w.account_id,
        w.channel,
        COUNT(id) AS events
FROM web_events w
GROUP BY w.account_id, w.channel
ORDER BY w.account_id, w.channel;

--You can GROUP BY multiple columns at once, as we showed here. This is often useful to aggregate across a number of different segments.

-- The order of columns listed in the ORDER BY clause does make a difference. You are ordering the columns from left to right.

-- The order of column names in your GROUP BY clause doesn’t matter—the results will be the same regardless. If we run the same query and reverse the order in the GROUP BY clause, you can see we get the same results.

-- As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause. It’s generally recommended to do this only when you’re grouping many columns, or if something else is causing the text in the GROUP BY clause to be excessively long.

-- A reminder here that any column that is not within an aggregation must show up in your GROUP BY statement. If you forget, you will likely get an error. However, in the off chance that your query does work, you might not like the results!


-- 1- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
SELECT a.name as account_name,
       AVG(o.standard_qty) as standard,
       AVG(o.gloss_qty) as gloss,
       AVG(o.poster_qty) as poster
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

-- 2- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name as account_name,
       AVG(o.standard_amt_usd) as standard_amt,
       AVG(o.gloss_amt_usd) as gloss_amt,
       AVG(o.poster_amt_usd) as poster_amt
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;


-- 3- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT w.channel as channel_name, count(w.channel) as times_used, s.name
FROM web_events w
JOIN accounts a on a.id = w.account_id
JOIN sales_reps s on s.id = a.sales_rep_id
GROUP by w.channel, s.name
order by channel;
 
 -- another solution 
 SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;


-- 4- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.


SELECT r.name as region_name, w.channel as channel_name, count(w.channel) as times_used
FROM web_events w
JOIN accounts a on a.id = w.account_id
JOIN sales_reps s on s.id = a.sales_rep_id
JOIN region r on r.id = s.region_id
GROUP by w.channel, r.name
order by times_used DESC;


-- Distinct
SELECT w.account_id, w.channel, COUNT(id) as events
FROM web_events w
GROUP by w.account_id, w.channel
ORDER BY w.account_id, w.channel DESC;

-- same as below 
SELECT account_id, channel
FROM web_events
GROUP by account_id, channel
ORDER by account_id;

-- same as 
SELECT DISTINCT account_id, channel
FROM web_events
ORDER BY account_id;

-- HAVING CLAUSE

SELECT o.account_id, sum(o.total_amt_usd) as sum_total_amt_usd
FROM orders o
Group by 1
HAVING sum(o.total_amt_usd) >= 250000 AND sum(o.total_amt_usd) <= 255000

-- Quiz: HAVING

SELECT * FROM sql_python.web_events
SELECT * FROM sql_python.accounts

-- 1- How many of the sales reps have more than 5 accounts that they manage?

SELECT s.id, s.name, COUNT(a.id) as num_accounts
FROM sql_python.sales_reps s 
JOIN sql_python.accounts a on a.sales_rep_id = S.id
GROUP by s.id, s.name
HAVING num_accounts >= 5;

SELECT s.id, s.name, COUNT(a.id) as num_accounts
FROM sql_python.sales_reps s 
JOIN sql_python.accounts a on a.sales_rep_id = S.id
GROUP by s.id, s.name
HAVING num_accounts >= 5;

-- 2- How many accounts have more than 20 orders?
SELECT a.id, a.name, COUNT(o.account_id) total_orders
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP by a.id, a.name
HAVING COUNT(o.account_id) > 20;

-- 3- Which account has the most orders?
SELECT a.id, a.name, COUNT(o.account_id) total_orders
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP by a.id, a.name
Order by COUNT(o.account_id) DESC
LIMIT 1;


-- 4- Which accounts spent more than 30,000 usd total across all orders?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;


-- 5- Which accounts spent less than 1,000 usd total across all orders?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;



-- 6- Which account has spent the most with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;


-- 7- Which account has spent the least with us?

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;


-- 8- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.id, a.name, w.channel, count(*) use_of_channel
FROM accounts a
Join web_events w on a.id = w.account_id
GROUP by a.id, a.name, w.channel
HAVING use_of_channel > 6 AND w.channel = "facebook"
order by use_of_channel

--  Solution 2
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY use_of_channel;

-- 9- Which account used facebook most as a channel?
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
limit 1;

-- 10- Which channel was most frequently used by most accounts?

SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts a
JOIN web_events w ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
limit 10;


-- DATE Functions

SELECT occurred_at, SUM(standard_qty) as "Standard Quantity SUM"
FROM orders
GROUP BY orders.occurred_at
Order by orders.occurred_at;

SELECT o.occurred_at,
        DATE_FORMAT('%d', o.occurred_at) AS day, DATE_FORMAT('%i', o.occurred_at) AS minutes
FROM orders o;

SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       account_id,
       occurred_at,
       total
FROM orders;

SELECT
    DAYOFWEEK(occurred_at) AS day_of_week,
    account_id,
    occurred_at,
    total
FROM
    orders;


SELECT
    o.occurred_at,
    DATE_FORMAT(o.occurred_at, '%d') AS day,
    DATE_FORMAT(o.occurred_at, '%i') AS minutes
FROM
    orders o;

SELECT standard_qty, COUNT(*)
FROM orders
GROUP BY 1
ORDER BY 1;

-- The 1 in both the GROUP BY and ORDER BY statements refer to standard_qty since it is the first of the columns included in the select statement.

SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       account_id,
       occurred_at,
       total
FROM orders;

SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       SUM(total) AS total_qty
FROM orders
GROUP BY 1
ORDER BY 2;

-- DAYOFWEEK in MYSQL

SELECT
    DAYOFWEEK(occurred_at) AS day_of_week,
    account_id,
    occurred_at,
    total
FROM
    orders;

-- select day of week 
SELECT DATE_PART('dow',occurred_at) AS day_of_week,
       SUM(total) AS total_qty
FROM orders
GROUP BY 1
ORDER BY 2;


SELECT DAYOFWEEK(o.occurred_at) as day_of_week, o.account_id, o.occurred_at, o.total
FROM orders o;

-- Quiz: DATE Functions

-- 1- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
-- USING DATE_FOTMAT
SELECT SUM(o.total_amt_usd) total_sale, DATE_FORMAT(o.occurred_at, '%Y') as years
FROM orders o
group by DATE_FORMAT(o.occurred_at, '%Y')
order by total_sale DESC;

-- USING DATE_PART
SELECT SUM(o.total_amt_usd) AS total_sale, DATE_PART('year', o.occurred_at) AS years
FROM orders o
GROUP BY DATE_PART('year', o.occurred_at)
ORDER BY total_sale DESC;


-- 2- Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT o.account_id, SUM(o.total_amt_usd) as total_sale, DATE_FORMAT(o.occurred_at, '%M') as month
FROM orders o
group by DATE_FORMAT(o.occurred_at, '%M'),  o.account_id
order by total_sale DESC;

SELECT o.account_id, SUM(o.total_amt_usd) AS total_sale, DATE_FORMAT(o.occurred_at, '%M') AS month
FROM orders o
WHERE o.account_id = 'Parch & Posey' -- Filter for Parch & Posey account only
GROUP BY DATE_FORMAT(o.occurred_at, '%M')
ORDER BY total_sale DESC;

-- using month 
select o.occurred_at, month(o.occurred_at) as month
from orders o;

-- unsing DATE_TRUNC
SELECT DATE_TRUNC(occurred_at, 'MONTH') AS month
FROM orders;


-- 3- Which year did Parch & Posey have the greatest sales in terms of the total number of orders? Are all years evenly represented by the dataset?
SELECT SUM(o.total_amt_usd) as total_sale, DATE_FORMAT(o.occurred_at, '%Y') as Year
FROM orders o
GROUP BY DATE_FORMAT(o.occurred_at, '%Y')
Order by total_sale DESC;

-- 4- Which month did Parch & Posey have the greatest sales in terms of the total number of orders? Are all months evenly represented by the dataset?
SELECT COUNT(o.id) as total_orders, DATE_FORMAT(o.occurred_at, '%M') as Month
FROM orders o
GROUP by DATE_FORMAT(o.occurred_at, '%M')
order by total_orders DESC;


-- 5- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT SUM(o.gloss_amt_usd) as gloss_spent, DATE_FORMAT(o.occurred_at, '%M') as month, DATE_FORMAT(o.occurred_at, '%Y') as year
FROM orders o
JOIN accounts a on a.id = o.account_id
Where a.name = 'Walmart'
GROUP by DATE_FORMAT(o.occurred_at, '%M'), DATE_FORMAT(o.occurred_at, '%Y')
order by gloss_spent DESC
limit 1;

-- CASE Statements
SELECT w.id,
       w.account_id,
       w.occurred_at,
       w.channel,
   CASE WHEN w.channel = 'facebook' THEN 'Yes' ELSE 'No' END AS is_facebook

FROM web_events w
ORDER BY w.occurred_at;

-- using or 
SELECT w.id, w.account_id, w.channel,
        CASE WHEN w.channel = 'facebook' OR w.channel = 'direct' THEN 'Yes' ELSE 'No' END AS is_facebook

FROM web_events w
ORDER BY w.occurred_at;

-- another case example

SELECT o.id, o.occurred_at, o.total,

CASE WHEN o.total > 500 THEN 'Over 500'
     WHEN o.total > 300 THEN '301 - 500'
     WHEN o.total > 100 THEN '101 - 300'
     
     ELSE '100 or under' END AS total_group 

From orders o;

-- combining the CASE statements with aggregation 

SELECT o.id, o.occurred_at, o.total,

CASE WHEN o.total > 500 THEN 'Over 500'
     WHEN o.total > 300 AND total <= 500 THEN '301 - 500'
     WHEN o.total > 100 AND total <= 300 THEN '101 - 300'
     
     ELSE '100 or under' END AS total_group 

From orders o;


-- QUIZ CASE 

-- 1- Write a query to display for each order, the account ID, the total amount of the order, 
-- and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, 
-- or smaller than $3000.

SELECT o.account_id, o.total_amt_usd, 
        CASE
         WHEN o.total_amt_usd >= 3000 THEN 'Large' 
         WHEN o.total_amt_usd < 3000 THEN 'Small' 
          END AS order_level
        
FROM orders o 
GROUP by 1,2;


-- 2- Write a query to display the number of orders in each of three categories, based on the total number of items in each order.
-- The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

SELECT 
    CASE
        WHEN o.total >= 2000 THEN 'At Least 2000' 
        WHEN o.total <= 2000 AND o.total >= 1000 THEN 'Between 1000 and 2000' 
        WHEN o.total < 1000 THEN 'Less than 1000' 
        ELSE 'unknown'
    END AS order_level,
    COUNT(*) as total_orders
FROM orders o 
GROUP BY 1;


-- 3- We would like to understand 3 different levels of customers based on the amount associated with their purchases.
-- The top-level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
-- The second level is between 200,000 and 100,000 usd.
--  The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account.
--  You should provide the account name, the total sales of all orders for the customer,
-- and the level. Order with the top spending customers listed first.

SELECT a.name as account_name, SUM(o.total_amt_usd) as total_amount,
        CASE
        WHEN SUM(o.total_amt_usd) > 200000 THEN  'greater than 200,000 - Level 1'
        WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) >= 100000 THEN  'Between 200k and 100k - Level 2'
        WHEN SUM(o.total_amt_usd) < 100000 AND SUM(o.total_amt_usd) >= 0 THEN  'less than 100k - Level 3'
        ELSE 'none'
        END as Levels
FROM orders o
JOIN accounts a on a.id = o.account_id
  GROUP BY 1
ORDER BY total_amount DESC;


SELECT a.name as account_name, SUM(o.total_amt_usd) as total_amount, o.occurred_at,
        CASE
        WHEN SUM(o.total_amt_usd) > 200000 THEN  'greater than 200,000 - Level 1'
        WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) >= 100000 THEN  'Between 200k and 100k - Level 2'
        WHEN SUM(o.total_amt_usd) < 100000 AND SUM(o.total_amt_usd) >= 0 THEN  'less than 100k - Level 3'
        ELSE 'none'
        END as Levels
FROM orders o
JOIN accounts a on a.id = o.account_id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2017-12-31'
GROUP BY account_name, o.occurred_at
ORDER BY total_amount DESC;

-- 5- We would like to identify top-performing sales reps, which are sales reps associated with more than 200 orders. 
-- Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. 
-- Place the top salespeople first in your final table.

SELECT s.name, count(o.total) as total_orders,
        CASE
            WHEN count(o.total) > 200 THEN 'Top'
            ELSE 'Not' END AS performing_level
FROM sales_reps s
JOIN accounts a on a.sales_rep_id = s.id
JOIN orders o on o.account_id = a.id
GROUP BY 1
ORDER BY total_orders DESC;

-- WITH Having to get only orders over 200 
SELECT s.name, COUNT(o.total) AS total_orders,
  CASE
    WHEN COUNT(o.total) > 200 THEN 'Top'
    ELSE 'Not'
  END AS performing_level
FROM sales_reps s
JOIN accounts a ON a.sales_rep_id = s.id
JOIN orders o ON o.account_id = a.id
GROUP BY s.name
HAVING COUNT(o.total) > 200
ORDER BY total_orders DESC;

-- 6- The previous didn't account for the middle, nor the dollar amount associated with the sales. 
-- Management decides they want to see these characteristics represented as well. 
-- We would like to identify top-performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales.
-- The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name,
-- the total number of orders, total sales across all orders, and a column with top, middle, or low depending on these criteria. 
-- Place the top salespeople based on the dollar amount of sales first in your final table. 
-- You might see a few upset salespeople by this criteria!

SELECT s.name, count(o.total) as total_orders, SUM(o.total_amt_usd) as total_spent,
        CASE
            WHEN count(o.total) >= 200 OR SUM(o.total_amt_usd) > 750000 THEN 'Top'
            WHEN count(o.total) < 200 AND count(o.total) >= 150 AND SUM(o.total_amt_usd) > 150000 THEN 'middle'
            ELSE 'low' END AS performing_level
FROM sales_reps s
JOIN accounts a on a.sales_rep_id = s.id
JOIN orders o on o.account_id = a.id
GROUP BY 1
ORDER BY total_spent DESC;

 -- Sub Query
SELECT channel,
       AVG(event_count) as avg_event_count
FROM
(SELECT DATE(w.occurred_at) AS day, w.channel,
      COUNT(*) as event_count
FROM web_events w
GROUP BY 1, 2
) sub
GROUP BY 1
ORDER BY 1;

-- The average amount of standard paper sold on the first month that any order was placed in the orders table (in terms of quantity).

-- Get the year first, then the month 
Simple Subquery
WITH dept_average AS 
  (SELECT dept, AVG(salary) AS avg_dept_salary
   FROM employee
   GROUP BY employee.dept
  )
SELECT E.eid, E.ename, D.avg_dept_salary
FROM employee E
JOIN dept.average D
ON E.dept = D.dept
WHERE E.salary > D.avg_dept_salary;
Correlated Subquery
SELECT employee_id,
  name
FROM employees_db emp
WHERE salary > 
  (SELECT AVG(salary)
   FROM employees_db
   WHERE department = emp.department);


-- The total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd).



SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

-- Simple Subquery
WITH dept_average AS 
  (SELECT dept, AVG(salary) AS avg_dept_salary
   FROM employee
   GROUP BY employee.dept
  )
SELECT E.eid, E.ename, D.avg_dept_salary
FROM employee E
JOIN dept.average D
ON E.dept = D.dept
WHERE E.salary > D.avg_dept_salary;

-- Correlated Subquery

SELECT employee_id,
  name
FROM employees_db emp
WHERE salary > 
  (SELECT AVG(salary)
   FROM employees_db
   WHERE department = emp.department);


   
---- SQL VIEWS
-- creatng the first VIEW from the sales_reps and region tables
CREATE VIEW V1
AS
SELECT s.id, s.name as rep_name, r.name as region
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
AND r.name = 'Northeast';

CREATE VIEW V2
AS 
SELECT r.name as region_name, a.name as account_name, (o.total_amt_usd / o.total) as unit_price
FROM accounts a
JOIN sales_reps s on a.sales_rep_id = s.id
JOIN region r on s.region_id = r.id
JOIN orders o on a.id = o.account_id;


SELECT * FROM V2;

-----------
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;



select max(total_amt_usd)
from V2;

-- CREATE VIEW 3

CREATE VIEW V3
AS
SELECT COUNT(w.id) as id_counts, AVG(w.occurred_at) as avg_da, w.channel as channel_tr
FROM web_events w
GROUP BY channel_tr
order by id_counts DESC;


SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
         FROM web_events 
         GROUP BY 1,2) sub
GROUP BY channel;

-- What is the top channel used by each account to market products?
SELECT a.id as acc_id, w.channel as channel, 
       (SELECT COUNT(wb.occurred_at)
        FROM web_events wb
        WHERE wb.account_id = a.id AND wb.channel = w.channel) as web_acc 
FROM web_events w
JOIN accounts a on a.id = w.account_id 
GROUP BY channel, acc_id;


-- What is the top channel used by each account to market products?
-- How often was that same channel used?

SELECT t3.id, t3.name, t3.channel, t3.ct
FROM (SELECT a.id, a.name, we.channel, COUNT(*) ct
     FROM accounts a
     JOIN web_events we
     On a.id = we.account_id
     GROUP BY a.id, a.name, we.channel) T3
JOIN (SELECT t1.id, t1.name, MAX(ct) max_chan
      FROM (SELECT a.id, a.name, we.channel, COUNT(*) ct
            FROM accounts a
            JOIN web_events we
            ON a.id = we.account_id
            GROUP BY a.id, a.name, we.channel) t1
      GROUP BY t1.id, t1.name) t2
ON t2.id = t3.id AND t2.max_chan = t3.ct
ORDER BY t3.id, t3.ct;

-- Another way to solve it and get the same results 

SELECT t2.Region_Name, t2.Sales_Reps_Name, MAX(t1.total_amt_usd) AS largest_amt
FROM (SELECT ac.sales_rep_id AS sales_rep_id, SUM(o.total_amt_usd) AS total_amt_usd
      FROM accounts ac
      JOIN orders o ON ac.id = o.account_id
      GROUP BY ac.sales_rep_id
) t1

JOIN (SELECT r.name AS Region_Name, s.name AS Sales_Reps_Name, s.id AS sales_rep_id
      FROM sales_reps s
      JOIN region r ON s.region_id = r.id
) t2

ON t1.sales_rep_id = t2.sales_rep_id

GROUP BY t2.Region_Name, t2.Sales_Reps_Name
ORDER BY largest_amt DESC;



-- Updated the above query to get the the top channel used by each account to market products and 
-- How often was that same channel used
SELECT t3.sales_rep_name, t3.region_name, t3.total_amt
FROM (SELECT region_name, MAX(total_amt) total_amt
        FROM(
             SELECT  s.name AS sales_rep_name, r.name AS region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a ON a.sales_rep_id = s.id
             JOIN orders o ON o.account_id = a.id
             JOIN region r ON r.id = s.region_id
             GROUP BY 1,2) t1
         GROUP BY 1) t2
JOIN (
        SELECT  s.name AS sales_rep_name, r.name AS region_name, SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
        GROUP BY 1,2
        ORDER BY 3 DESC) t3 
ON  t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;




WITH SalesData AS (
    SELECT
        s.name AS sales_rep_name,
        r.name AS region_name,
        SUM(o.total_amt_usd) AS total_amt,
        ROW_NUMBER() OVER (PARTITION BY r.name ORDER BY SUM(o.total_amt_usd) DESC) AS channel_rank
    FROM
        sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
    GROUP BY
        s.name, r.name
)
SELECT
    sales_rep_name,
    region_name,
    total_amt
FROM
    SalesData
WHERE
    channel_rank = 1;


-- Showing the orders with the hightest first 

SELECT t3.rep_name, t3.region_name, t3.total_amt

FROM(SELECT region_name, MAX(total_amt) total_amt

     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a ON a.sales_rep_id = s.id
             JOIN orders o   ON o.account_id = a.id
             JOIN region r   ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
     
JOIN (
    
    SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a ON a.sales_rep_id = s.id
     JOIN orders o   ON o.account_id = a.id
     JOIN region r   ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
     
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt
Order by total_amt DESC;

--Q2: For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
-- My answer below utilizes two subqueries, one to find the region with the highest total_amt_usd and another to find the region with the highest count of orders (total_orders).
-- Then, it joins these two subqueries on the region name and groups the results by region name.

SELECT t1.region_name, MAX(t2.total_orders) as total_of_orders
FROM( SELECT r.name as region_name, SUM(o.total_amt_usd) total_amt_usd -- gets all regions with high total_amt_used
        FROM region r
        JOIN sales_reps s on r.id = s.region_id
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON a.id = o.account_id
        GROUP BY 1
        order by total_amt_usd DESC) t1
JOIN(SELECT r.name as region_name, COUNT(o.total) as total_orders
        FROM region r
                JOIN sales_reps s on r.id = s.region_id
                JOIN accounts a ON a.sales_rep_id = s.id
                JOIN orders o ON a.id = o.account_id
                GROUP BY 1
                order by total_orders DESC
                Limit 1) t2
ON t1.region_name = t2.region_name
GROUP by 1;

-- The answer using Having and a subquery
SELECT t1.region_name, MAX(t1.total_amt_usd) max_used, t2.total_orders
FROM (SELECT r.name as region_name, SUM(o.total_amt_usd) total_amt_usd
        FROM region r
        JOIN sales_reps s on r.id = s.region_id
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON a.id = o.account_id
        HAVING (
                SELECT r.name as region_name, COUNT(o.total) total_orders
                FROM region r
                JOIN sales_reps s on r.id = s.region_id
                JOIN accounts a ON a.sales_rep_id = s.id
                JOIN orders o ON a.id = o.account_id
                GROUP BY 1
                order by total_orders DESC
                Limit 1) t2
ON t1.region_name = t2.region_name

GROUP BY 1
order by total_amt_usd DESC) t1
group by 1;


-- Q3: How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

SELECT a.id as acct_id, a.name as acc_name, o.account_id as ord_acc_id, SUM(o.gloss_amt_usd) as total_purchases
FROM orders o
JOIN accounts a on a.id = o.account_id
GROUP BY 1,2
HAVING SUM(o.gloss_amt_usd) = (
    SELECT MAX(sub.total_purchases) 
    FROM (SELECT a.id as acct_id, o.account_id as ord_acc_id, SUM(o.gloss_amt_usd) as total_purchases
          FROM orders o
          JOIN accounts a on a.id = o.account_id
          GROUP BY 1,2) sub;


-- Final Answer is as follows:

SELECT COUNT(*) as num_accounts
FROM (
    SELECT a.id as acct_id, a.name as acc_name, SUM(o.total) as total_sum
    FROM orders o
    JOIN accounts a ON a.id = o.account_id
    GROUP BY a.id, a.name
    HAVING SUM(o.total) > (
        SELECT SUM(o2.total) as max_total
        FROM orders o2
        JOIN accounts a2 ON a2.id = o2.account_id
        WHERE a2.id = (
            SELECT a3.id
            FROM accounts a3
            JOIN orders o3 ON a3.id = o3.account_id
            GROUP BY a3.id
            ORDER BY SUM(o3.standard_qty) DESC
            LIMIT 1
        )
    )
) accounts_with_more_purchases;


--Here's how this query works:
--The innermost subquery identifies the account ID that has purchased the most standard_qty paper by grouping orders by account and ordering the results in descending order of standard_qty purchases. The LIMIT 1 ensures you only get the top account.
--The middle subquery calculates the total purchases made by the account identified in the previous step.
--The outer subquery retrieves the account IDs, names, and total sums of purchases for all accounts.
--The HAVING clause filters the accounts to include only those with total purchases greater than the maximum total purchases from step 2.
--Finally, the outermost query counts the number of accounts that meet the criteria.
--Please note that this query assumes each account has a unique ID, and you might need to adjust the table and column names based on your database schema.

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT T1.ACCT_ID AS t1_id,
       T1.ACCT_NAME AS t1_name,
       T2.ACCT_ID AS t2_id,
       T2.TOTAL_SUM AS totalSum,
       T1.CHANNEL_NAME,
       T1.COUNT_OF_EVENT

FROM (
    SELECT A.ID AS ACCT_ID,
           A.NAME AS ACCT_NAME,
           W.CHANNEL AS CHANNEL_NAME,
           COUNT(W.OCCURRED_AT) AS COUNT_OF_EVENT
    FROM WEB_EVENTS W
    JOIN ACCOUNTS A ON A.ID = W.ACCOUNT_ID
    GROUP BY ACCT_ID, ACCT_NAME, CHANNEL_NAME
) T1

JOIN (
    SELECT A.ID AS ACCT_ID,
           SUM(O.TOTAL_AMT_USD) AS TOTAL_SUM
    FROM ACCOUNTS A
    JOIN ORDERS O ON A.ID = O.ACCOUNT_ID
    GROUP BY ACCT_ID
    ORDER BY TOTAL_SUM DESC
    LIMIT 1
) T2 ON T1.ACCT_ID = T2.ACCT_ID

ORDER BY T2.TOTAL_SUM DESC, T1.COUNT_OF_EVENT DESC;
