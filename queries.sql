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

-- Query 10: Customer Analysis (One-time vs Repeat Customers)
-- Question: How many customers are one-time buyers vs repeat customers?
-- Insight: Approximately 97% of customers are one-time buyers, while only ~3% are repeat customers.
--			This indicates low customer retention and suggests that the business relies heavily on new customer acquisition.
--			Improving retention strategies could significantly enhance long-term revenue.
WITH customer_orders AS (
	SELECT
		c.customer_unique_id,
		COUNT(o.order_id) AS total_orders
	FROM orders o
	JOIN customers c
		ON o.customer_id = c.customer_id
	GROUP BY c.customer_unique_id
)

SELECT
	CASE
		WHEN total_orders = 1 THEN 'One-time'
		ELSE 'Repeat'
	END AS customer_type,
	COUNT(*) AS total_customers
FROM customer_orders
GROUP BY customer_type;

-- Query 11: Customer Analysis (Pareto - Top 20% Revenue Contribution)
-- Question: Do the top 20% of customers contribute the majority of total revenue?
-- Insight: The top 20% of customers contribute approximately 54% of total revenue (~8.5M), while the remaining 80% contribute ~7.34M.
--			This indicates a moderately concentrated revenue distribution, but not a strict Pareto (80/20) pattern.
WITH customer_revenue AS (
	SELECT
		c.customer_unique_id,
		SUM(oi.price + oi.freight_value) AS total_revenue
	FROM customers c
	JOIN orders o
		ON c.customer_id = o.customer_id
	JOIN order_items oi
		ON o.order_id = oi.order_id
	GROUP BY c.customer_unique_id
),

ranked_customers AS (
	SELECT
		customer_unique_id,
		total_revenue,
		NTILE(5) OVER (ORDER BY total_revenue DESC) AS tile
	FROM customer_revenue
)

SELECT
	CASE
		WHEN tile = 1 THEN 'Top 20%'
		ELSE 'Bottom 80%'
	END AS customer_group,
	SUM(total_revenue) AS total_revenue
FROM ranked_customers
GROUP BY customer_group;

-- Query 12: Time Analysis (Cumulative Revenue Over Time)
-- Question: How does revenue accumulate over time?
-- Insight: Cumulative revenue shows a consistent upward trend, crossing 10M by early 2018 and reaching ~15.84M overall.
--			A strong acceleration is observed in late 2017, particularly in November, indicating seasonal demand.
--			The drop in September 2018 is due to incomplete data.
WITH monthly_revenue AS (
	SELECT
		strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
		SUM(oi.price + oi.freight_value) AS monthly_revenue
	FROM orders o
	JOIN order_items oi
		ON o.order_id = oi.order_id
	GROUP BY year_month
)

SELECT
	year_month,
	monthly_revenue,
	SUM(monthly_revenue) OVER (ORDER BY year_month) AS cumulative_revenue
FROM monthly_revenue;

-- Query 13: City Analysis (Ranking by Revenue)
-- Question: Which cities generate the highest revenue, and how do they rank?
-- Insight: Sao Paulo (~2.17M) and Rio de Janeiro (~1.15M) dominate revenue, contributing significantly more than other cities.
--			There is a sharp drop after the top 2, with Belo Horizonte (~0.42M) ranking third.
--			This indicates strong geographic concentration of revenue in a few major cities,
--			while other cities form a long tail with relatively lower contribution.
SELECT
	c.customer_city,
	SUM(oi.price + oi.freight_value) AS total_revenue,
	RANK() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS city_rank
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
JOIN order_items oi
	ON o.order_id = oi.order_id
GROUP BY c.customer_city;

-- Query 14: Customer Segmentation (High/Medium/Low Value Customers)
-- Question: How can customers be segmented based on their total spending?
-- Insight: Approximately 95% of customers are low-value, ~3% are medium-value, and only ~1-2% are high-value.
--			This indicates a highly skewed customer distribution, where a small group of high-value customers
--			likely contributes a significant portion of revenue, presenting an opportunity for customer value optimization.
WITH customer_revenue AS (
	SELECT
		c.customer_unique_id,
		SUM(oi.price + oi.freight_value) AS total_revenue
	FROM customers c
	JOIN orders o
		ON c.customer_id = o.customer_id
	JOIN order_items oi
		ON o.order_id = oi.order_id
	GROUP BY c.customer_unique_id
)

SELECT
	CASE
		WHEN total_revenue > 1000 THEN 'High Value'
		WHEN total_revenue BETWEEN 500 AND 1000 THEN 'Medium Value'
		ELSE 'Low Value'
	END AS customer_segment,
	COUNT(*) AS total_customers
FROM customer_revenue
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- Query 15: Time Analysis (Revenue Drop Detection)
-- Question: Which months experienced a drop in revenue compared to the previous month?
-- Insight: Revenue drops are mostly seasonal, occurring after peak months such as November 2017.
--			The largest drop in September 2018 is due to incomplete data rather than actual business decline.
--			Overall, the business shows stable performance with temporary fluctuations rather than consistent downturns.
WITH monthly_revenue AS (
    SELECT 
        strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY year_month
),

revenue_with_lag AS (
	SELECT
		year_month,
		revenue,
		LAG(revenue) OVER (ORDER BY year_month) AS prev_revenue
	FROM monthly_revenue
)

SELECT
	year_month,
	revenue,
	prev_revenue,
	(revenue - prev_revenue) AS revenue_change
FROM revenue_with_lag
WHERE revenue < prev_revenue;

-- Query 16: Product Analysis (Top Categories by Revenue)
-- Question: Which product categories generate the most revenue?
-- Insight: Revenue is well distributed across product categories, with 'beleza_saude' (~1.44M),
--			'relogios_presentes' (~1.30M), and 'cama_mesa_banho' (~1.24M) leading.
--			The presence of multiple high-performing categories indicates a diversified product portfolio
--			with strong demand in lifestyle and essential goods.
SELECT
	p.product_category_name,
	SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;