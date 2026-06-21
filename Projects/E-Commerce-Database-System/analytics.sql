-- =====================================================
-- E-COMMERCE DATABASE SYSTEM
-- analytics.sql
-- Advanced Business Intelligence Queries
-- =====================================================

-- =====================================================
-- SECTION 1 : EXECUTIVE KPI DASHBOARD
-- =====================================================

-- KPI 1 : Total Customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- KPI 2 : Total Products

SELECT COUNT(*) AS total_products
FROM products;

-- KPI 3 : Total Orders

SELECT COUNT(*) AS total_orders
FROM orders;

-- KPI 4 : Total Revenue

SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status='Completed';

-- KPI 5 : Average Order Value

SELECT ROUND(
AVG(amount),
2
) AS average_order_value
FROM payments
WHERE payment_status='Completed';

-- =====================================================
-- SECTION 2 : CUSTOMER ANALYTICS
-- =====================================================

-- Top 10 Customers by Spending

SELECT
c.customer_id,
c.full_name,

SUM(p.amount)
AS total_spent

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY
c.customer_id,
c.full_name

ORDER BY total_spent DESC
LIMIT 10;

-- Customer Order Frequency

SELECT
c.full_name,
COUNT(o.order_id)
AS total_orders

FROM customers c

LEFT JOIN orders o
ON c.customer_id=o.customer_id

GROUP BY c.full_name

ORDER BY total_orders DESC;

-- Highest Value Customer

SELECT
c.full_name,

SUM(p.amount)
AS customer_value

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY c.full_name

ORDER BY customer_value DESC
LIMIT 1;

-- =====================================================
-- SECTION 3 : PRODUCT ANALYTICS
-- =====================================================

-- Top Selling Products

SELECT
p.product_name,

SUM(oi.quantity)
AS units_sold

FROM products p

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY p.product_name

ORDER BY units_sold DESC;

-- Highest Revenue Product

SELECT
p.product_name,

SUM(oi.subtotal)
AS revenue

FROM products p

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY p.product_name

ORDER BY revenue DESC
LIMIT 1;

-- Products Never Ordered

SELECT
p.product_name

FROM products p

LEFT JOIN order_items oi
ON p.product_id=oi.product_id

WHERE oi.product_id IS NULL;

-- =====================================================
-- SECTION 4 : CATEGORY ANALYTICS
-- =====================================================

-- Revenue By Category

SELECT
c.category_name,

SUM(oi.subtotal)
AS category_revenue

FROM categories c

JOIN products p
ON c.category_id=p.category_id

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY c.category_name

ORDER BY category_revenue DESC;

-- Best Performing Category

SELECT
c.category_name,

SUM(oi.subtotal)
AS category_revenue

FROM categories c

JOIN products p
ON c.category_id=p.category_id

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY c.category_name

ORDER BY category_revenue DESC
LIMIT 1;

-- =====================================================
-- SECTION 5 : INVENTORY ANALYTICS
-- =====================================================

-- Low Stock Products

SELECT
product_name,
stock_quantity

FROM products

WHERE stock_quantity < 30;

-- Reorder Required

SELECT
p.product_name,
i.stock_available,
i.reorder_level

FROM products p

JOIN inventory i
ON p.product_id=i.product_id

WHERE i.stock_available <= i.reorder_level;

-- Inventory Value

SELECT
SUM(
price * stock_quantity
)
AS inventory_value

FROM products;

-- =====================================================
-- SECTION 6 : PAYMENT ANALYTICS
-- =====================================================

-- Revenue By Payment Method

SELECT
payment_method,

SUM(amount)
AS revenue

FROM payments

GROUP BY payment_method

ORDER BY revenue DESC;

-- Failed Payments

SELECT *
FROM payments
WHERE payment_status='Failed';

-- =====================================================
-- SECTION 7 : SHIPPING ANALYTICS
-- =====================================================

-- Orders In Transit

SELECT
order_id,
tracking_number

FROM shipping

WHERE shipping_status='In Transit';

-- Delivered Orders

SELECT
COUNT(*)
AS delivered_orders

FROM shipping

WHERE shipping_status='Delivered';

-- =====================================================
-- SECTION 8 : REVIEW ANALYTICS
-- =====================================================

-- Highest Rated Products

SELECT
p.product_name,

ROUND(
AVG(r.rating),
2
) avg_rating

FROM products p

JOIN reviews r
ON p.product_id=r.product_id

GROUP BY p.product_name

ORDER BY avg_rating DESC;

-- Lowest Rated Products

SELECT
p.product_name,

ROUND(
AVG(r.rating),
2
) avg_rating

FROM products p

JOIN reviews r
ON p.product_id=r.product_id

GROUP BY p.product_name

ORDER BY avg_rating ASC;

-- =====================================================
-- SECTION 9 : CTE ANALYTICS
-- =====================================================

WITH customer_revenue AS
(
SELECT
c.customer_id,
c.full_name,

SUM(p.amount)
AS revenue

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY
c.customer_id,
c.full_name
)

SELECT *
FROM customer_revenue
ORDER BY revenue DESC;

-- =====================================================
-- SECTION 10 : WINDOW FUNCTION ANALYTICS
-- =====================================================

-- Product Revenue Ranking

SELECT

p.product_name,

SUM(oi.subtotal)
AS revenue,

RANK()
OVER(
ORDER BY SUM(oi.subtotal) DESC
)
AS revenue_rank

FROM products p

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY p.product_name;

-- Customer Spending Ranking

SELECT

c.full_name,

SUM(p.amount)
AS spending,

DENSE_RANK()
OVER(
ORDER BY SUM(p.amount) DESC
)
AS customer_rank

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY c.full_name;

-- =====================================================
-- SECTION 11 : ADVANCED EXECUTIVE REPORTS
-- =====================================================

-- Top 5 Customers

WITH ranked_customers AS
(
SELECT

c.full_name,

SUM(p.amount)
AS total_spent,

ROW_NUMBER()
OVER(
ORDER BY SUM(p.amount) DESC
)
AS rn

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY c.full_name
)

SELECT *
FROM ranked_customers
WHERE rn <= 5;

-- Top 5 Products

WITH ranked_products AS
(
SELECT

p.product_name,

SUM(oi.quantity)
AS units_sold,

ROW_NUMBER()
OVER(
ORDER BY SUM(oi.quantity) DESC
)
AS rn

FROM products p

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY p.product_name
)

SELECT *
FROM ranked_products
WHERE rn <= 5;

-- =====================================================
-- SECTION 12 : BUSINESS HEALTH DASHBOARD
-- =====================================================

SELECT

(SELECT COUNT(*) FROM customers)
AS total_customers,

(SELECT COUNT(*) FROM orders)
AS total_orders,

(SELECT SUM(amount)
FROM payments
WHERE payment_status='Completed')
AS total_revenue,

(SELECT COUNT(*)
FROM products)
AS total_products,

(SELECT COUNT(*)
FROM reviews)
AS total_reviews;
