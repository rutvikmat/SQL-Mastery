-- =====================================================
-- E-COMMERCE DATABASE SYSTEM
-- queries.sql
-- 100+ SQL QUERIES
-- =====================================================

-- =====================================================
-- SECTION 1 : BASIC QUERIES (1-10)
-- =====================================================

-- Q1
SELECT * FROM customers;

-- Q2
SELECT * FROM products;

-- Q3
SELECT product_name, price
FROM products;

-- Q4
SELECT full_name, email
FROM customers;

-- Q5
SELECT * FROM orders;

-- Q6
SELECT DISTINCT city
FROM customers;

-- Q7
SELECT * FROM categories;

-- Q8
SELECT * FROM brands;

-- Q9
SELECT * FROM suppliers;

-- Q10
SELECT * FROM reviews;

-- =====================================================
-- SECTION 2 : FILTERING QUERIES (11-20)
-- =====================================================

-- Q11
SELECT *
FROM products
WHERE price > 50000;

-- Q12
SELECT *
FROM products
WHERE stock_quantity < 50;

-- Q13
SELECT *
FROM customers
WHERE city = 'Bangalore';

-- Q14
SELECT *
FROM orders
WHERE order_status = 'Delivered';

-- Q15
SELECT *
FROM products
WHERE product_name LIKE 'A%';

-- Q16
SELECT *
FROM payments
WHERE payment_method = 'UPI';

-- Q17
SELECT *
FROM reviews
WHERE rating = 5;

-- Q18
SELECT *
FROM products
WHERE price BETWEEN 5000 AND 50000;

-- Q19
SELECT *
FROM customers
ORDER BY full_name;

-- Q20
SELECT *
FROM products
ORDER BY price DESC;

-- =====================================================
-- SECTION 3 : AGGREGATE QUERIES (21-35)
-- =====================================================

-- Q21
SELECT COUNT(*) total_customers
FROM customers;

-- Q22
SELECT COUNT(*) total_products
FROM products;

-- Q23
SELECT AVG(price)
FROM products;

-- Q24
SELECT MAX(price)
FROM products;

-- Q25
SELECT MIN(price)
FROM products;

-- Q26
SELECT SUM(amount)
FROM payments;

-- Q27
SELECT COUNT(*)
FROM orders;

-- Q28
SELECT category_id,
COUNT(*)
FROM products
GROUP BY category_id;

-- Q29
SELECT city,
COUNT(*)
FROM customers
GROUP BY city;

-- Q30
SELECT payment_method,
SUM(amount)
FROM payments
GROUP BY payment_method;

-- Q31
SELECT category_id,
AVG(price)
FROM products
GROUP BY category_id;

-- Q32
SELECT order_status,
COUNT(*)
FROM orders
GROUP BY order_status;

-- Q33
SELECT rating,
COUNT(*)
FROM reviews
GROUP BY rating;

-- Q34
SELECT category_id,
COUNT(*)
FROM products
GROUP BY category_id
HAVING COUNT(*) > 1;

-- Q35
SELECT city,
COUNT(*)
FROM customers
GROUP BY city
HAVING COUNT(*) >= 1;

-- =====================================================
-- SECTION 4 : JOIN QUERIES (36-55)
-- =====================================================

-- Q36
SELECT
p.product_name,
c.category_name
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

-- Q37
SELECT
p.product_name,
b.brand_name
FROM products p
JOIN brands b
ON p.brand_id = b.brand_id;

-- Q38
SELECT
o.order_id,
cu.full_name
FROM orders o
JOIN customers cu
ON o.customer_id = cu.customer_id;

-- Q39
SELECT
oi.order_id,
p.product_name,
oi.quantity
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- Q40
SELECT
pa.payment_id,
o.order_id,
pa.amount
FROM payments pa
JOIN orders o
ON pa.order_id = o.order_id;

-- Q41
SELECT
r.rating,
p.product_name
FROM reviews r
JOIN products p
ON r.product_id = p.product_id;

-- Q42
SELECT
s.shipping_partner,
o.order_id
FROM shipping s
JOIN orders o
ON s.order_id = o.order_id;

-- Q43
SELECT
cu.full_name,
o.order_id,
o.total_amount
FROM customers cu
JOIN orders o
ON cu.customer_id = o.customer_id;

-- Q44
SELECT
p.product_name,
i.stock_available
FROM products p
JOIN inventory i
ON p.product_id = i.product_id;

-- Q45
SELECT
w.customer_id,
p.product_name
FROM wishlist w
JOIN products p
ON w.product_id = p.product_id;

-- =====================================================
-- SECTION 5 : SUBQUERIES (56-70)
-- =====================================================

-- Q56 Highest priced product

SELECT *
FROM products
WHERE price =
(
SELECT MAX(price)
FROM products
);

-- Q57 Lowest priced product

SELECT *
FROM products
WHERE price =
(
SELECT MIN(price)
FROM products
);

-- Q58 Products above average price

SELECT *
FROM products
WHERE price >
(
SELECT AVG(price)
FROM products
);

-- Q59 Customers who placed orders

SELECT *
FROM customers
WHERE customer_id IN
(
SELECT customer_id
FROM orders
);

-- Q60 Products reviewed

SELECT *
FROM products
WHERE product_id IN
(
SELECT product_id
FROM reviews
);

-- =====================================================
-- SECTION 6 : SQL FUNCTIONS (71-80)
-- =====================================================

SELECT UPPER(product_name)
FROM products;

SELECT LOWER(product_name)
FROM products;

SELECT LENGTH(product_name)
FROM products;

SELECT CONCAT(product_name,' - ',price)
FROM products;

SELECT CURRENT_DATE;

SELECT CURRENT_TIMESTAMP;

SELECT ROUND(AVG(price),2)
FROM products;

SELECT EXTRACT(YEAR FROM CURRENT_DATE);

SELECT COALESCE(NULL,'No Value');

SELECT NULLIF(10,10);

-- =====================================================
-- SECTION 7 : CTE QUERIES (81-88)
-- =====================================================

WITH expensive_products AS
(
SELECT *
FROM products
WHERE price > 50000
)
SELECT *
FROM expensive_products;

WITH customer_orders AS
(
SELECT
customer_id,
COUNT(*) total_orders
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_orders;

-- =====================================================
-- SECTION 8 : WINDOW FUNCTIONS (89-100)
-- =====================================================

SELECT
product_name,
price,

ROW_NUMBER()
OVER(
ORDER BY price DESC
)
FROM products;

SELECT
product_name,
price,

RANK()
OVER(
ORDER BY price DESC
)
FROM products;

SELECT
product_name,
price,

DENSE_RANK()
OVER(
ORDER BY price DESC
)
FROM products;

SELECT
product_name,
price,

LAG(price)
OVER(
ORDER BY price
)
FROM products;

SELECT
product_name,
price,

LEAD(price)
OVER(
ORDER BY price
)
FROM products;

-- =====================================================
-- SECTION 9 : BUSINESS ANALYTICS QUERIES
-- =====================================================

-- Top Selling Products

SELECT
p.product_name,
SUM(oi.quantity) units_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;

-- Revenue by Category

SELECT
c.category_name,
SUM(oi.subtotal) revenue
FROM categories c
JOIN products p
ON c.category_id = p.category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- Top Customers

SELECT
cu.full_name,
SUM(pa.amount) total_spent
FROM customers cu
JOIN orders o
ON cu.customer_id = o.customer_id
JOIN payments pa
ON o.order_id = pa.order_id
GROUP BY cu.full_name
ORDER BY total_spent DESC;

-- Product Ratings

SELECT
p.product_name,
AVG(r.rating) avg_rating
FROM products p
JOIN reviews r
ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;

-- Low Stock Products

SELECT
product_name,
stock_quantity
FROM products
WHERE stock_quantity < 30;

-- Most Wishlisted Products

SELECT
p.product_name,
COUNT(w.wishlist_id) wishlist_count
FROM products p
JOIN wishlist w
ON p.product_id = w.product_id
GROUP BY p.product_name
ORDER BY wishlist_count DESC;
