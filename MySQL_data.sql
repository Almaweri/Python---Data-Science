##// INNER JOIN
## ================ THINK about JOIN AS FROM ===================

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

//Quiz Questions

// 1- Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT acc.*, ord.*
FROM accounts as acc
JOIN orders as ord
ON acc.id =  ord.account_id


// 2- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT ord.standard_qty, ord.gloss_qty, ord.poster_qty,
       acc.website, acc.primary_poc
FROM orders as ord
JOIN accounts as acc
ON ord.account_id = acc.id


// ============= JOIN Revisited ===================

// Joining 3 tables

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

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
