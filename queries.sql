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

-- Query 6: Revenue Analysis (Average Order Value)
-- Question: What is the average revenue per order?
-- Insight: The average order value is approximately 160.58, indicating that customers typically spend around this amount per transaction.
-- 			This suggests a moderate spending pattern and provides a baseline metric for evaluating pricing strategies, discounts, and customer purchasing behavior.
SELECT
	SUM(oi.price + oi.freight_value) * 1.0 / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_items oi
	ON o.order_id = oi.order_id;

-- Query 7: Time Analysis (Orders per Month)
-- Question: How does order volume change over time (monthly)?
-- Insight: Order volume shows strong growth throughout 2017, peaking in November (~7,544 orders), likely due to seasonal events.
--			High order volume continues into early 2018 before stabilizing. The sharp drop in late 2018 is likely due to incomplete data.
SELECT
	strftime('%Y-%m', order_purchase_timestamp) AS year_month,
	COUNT(order_id) AS total_orders
FROM orders
GROUP BY year_month
ORDER BY year_month;

-- Query 8: Time Analysis (Revenue per Month)
-- Question: How does revenue change over time (monthly)?
-- Insight: Revenue shows consistent growth throughout 2017, peaking in November (~1.18M), likely driven by seasonal sales events.
--			High revenue levels continue into early 2018 (~1.1M range), indicating sustained demand.
--			The sharp drop in September 2018 is due to incomplete data.
SELECT
	strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
	SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi
	ON o.order_id = oi.order_id
GROUP BY year_month
ORDER BY year_month;

-- Query 9: Product Analysis (Top Products by Revenue)
-- Question: Which products generate the highest total revenue?
-- Insight: The top product generates ~67.6K in revenue, followed by several products in the 40K-60K range.
--			Revenue is relatively evenly distributed among top products, indicating diversified product demand
--			and low dependency on a single product.
SELECT
	oi.product_id,
	SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY oi.product_id
ORDER BY total_revenue DESC
LIMIT 10;