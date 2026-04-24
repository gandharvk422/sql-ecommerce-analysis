-- Query 1: Basic Check
SELECT * FROM customers LIMIT 10;

-- Query 2: Join
SELECT
	c.customer_id,
	o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 10;

-- Query 3: Aggregation
-- Question: Which cities generate the highest number of orders?
-- Insight: São Paulo dominates with ~15.5K orders, significantly higher than other cities.
SELECT
	c.customer_city,
	COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Query 4: Revenue Analysis (Total Revenue per City)
-- Question: Which cities generate the highest total revenue?
-- Insight: São Paulo generates the highest revenue (~2.17M), nearly double that of Rio de Janeiro (~1.15M). 
--          Revenue is heavily concentrated in the top 2 cities, with a significant drop for others like Belo Horizonte and Brasília, 
--          indicating strong market dominance and potential expansion opportunities in mid-tier cities.
SELECT
	c.customer_city,
	SUM(oi.price + oi.freight_value) AS total_revenue
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
JOIN order_items oi
	ON o.order_id = oi.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 5: Customer Analysis (Top Customers by Revenue)
-- Question: Which customers contribute the most to total revenue?
-- Insight: The top customer contributes ~13.6K in revenue, nearly double the second-highest (~7.2K). 
--          However, revenue among the remaining top customers is relatively evenly distributed (4.6K–7K range), 
--          indicating no heavy dependency on a single customer and a stable customer revenue base.
SELECT
	c.customer_id,
	SUM(oi.price + oi.freight_value) AS total_revenue
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
JOIN order_items oi
	ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_revenue DESC
LIMIT 10;