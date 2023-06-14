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

