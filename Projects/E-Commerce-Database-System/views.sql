-- =====================================================
-- E-COMMERCE DATABASE SYSTEM
-- views.sql
-- Business Reporting Views
-- =====================================================

-- =====================================================
-- VIEW 1 : CUSTOMER ORDERS VIEW
-- =====================================================

CREATE VIEW customer_orders_view AS
SELECT
c.customer_id,
c.full_name,
o.order_id,
o.order_date,
o.order_status,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- =====================================================
-- VIEW 2 : PRODUCT DETAILS VIEW
-- =====================================================

CREATE VIEW product_details_view AS
SELECT
p.product_id,
p.product_name,
c.category_name,
b.brand_name,
p.price,
p.stock_quantity
FROM products p
LEFT JOIN categories c
ON p.category_id = c.category_id
LEFT JOIN brands b
ON p.brand_id = b.brand_id;

-- =====================================================
-- VIEW 3 : PRODUCT SALES VIEW
-- =====================================================

CREATE VIEW product_sales_view AS
SELECT
p.product_id,
p.product_name,
SUM(oi.quantity) AS total_units_sold,
SUM(oi.subtotal) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
p.product_id,
p.product_name;

-- =====================================================
-- VIEW 4 : CUSTOMER SPENDING VIEW
-- =====================================================

CREATE VIEW customer_spending_view AS
SELECT
c.customer_id,
c.full_name,
COUNT(o.order_id) total_orders,
SUM(o.total_amount) total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.full_name;

-- =====================================================
-- VIEW 5 : PAYMENT DASHBOARD VIEW
-- =====================================================

CREATE VIEW payment_dashboard_view AS
SELECT
p.payment_id,
o.order_id,
c.full_name,
p.amount,
p.payment_method,
p.payment_status,
p.payment_date
FROM payments p
JOIN orders o
ON p.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- VIEW 6 : SHIPPING DASHBOARD VIEW
-- =====================================================

CREATE VIEW shipping_dashboard_view AS
SELECT
s.shipping_id,
o.order_id,
c.full_name,
s.tracking_number,
s.shipping_partner,
s.shipping_status
FROM shipping s
JOIN orders o
ON s.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- VIEW 7 : INVENTORY DASHBOARD VIEW
-- =====================================================

CREATE VIEW inventory_dashboard_view AS
SELECT
p.product_id,
p.product_name,
i.stock_available,
i.reorder_level,

```
CASE
    WHEN i.stock_available <= i.reorder_level
    THEN 'REORDER REQUIRED'
    ELSE 'STOCK AVAILABLE'
END AS inventory_status
```

FROM products p
JOIN inventory i
ON p.product_id = i.product_id;

-- =====================================================
-- VIEW 8 : PRODUCT RATINGS VIEW
-- =====================================================

CREATE VIEW product_ratings_view AS
SELECT
p.product_id,
p.product_name,
ROUND(
AVG(r.rating),
2
) AS average_rating,
COUNT(r.review_id) total_reviews

FROM products p
LEFT JOIN reviews r
ON p.product_id = r.product_id

GROUP BY
p.product_id,
p.product_name;

-- =====================================================
-- VIEW 9 : CATEGORY REVENUE VIEW
-- =====================================================

CREATE VIEW category_revenue_view AS
SELECT
c.category_name,

```
SUM(
    oi.subtotal
) AS total_revenue
```

FROM categories c

JOIN products p
ON c.category_id = p.category_id

JOIN order_items oi
ON p.product_id = oi.product_id

GROUP BY
c.category_name;

-- =====================================================
-- VIEW 10 : TOP CUSTOMERS VIEW
-- =====================================================

CREATE VIEW top_customers_view AS
SELECT
c.customer_id,
c.full_name,

```
SUM(
    p.amount
) total_spent
```

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN payments p
ON o.order_id = p.order_id

GROUP BY
c.customer_id,
c.full_name;

-- =====================================================
-- VIEW 11 : COUPON USAGE VIEW
-- =====================================================

CREATE VIEW coupon_usage_view AS
SELECT
cp.coupon_code,

```
COUNT(o.order_id)
AS total_orders_using_coupon
```

FROM coupons cp

LEFT JOIN orders o
ON cp.coupon_id = o.coupon_id

GROUP BY cp.coupon_code;

-- =====================================================
-- VIEW 12 : WISHLIST ANALYTICS VIEW
-- =====================================================

CREATE VIEW wishlist_analytics_view AS
SELECT
p.product_id,
p.product_name,

```
COUNT(w.wishlist_id)
AS wishlist_count
```

FROM products p

LEFT JOIN wishlist w
ON p.product_id = w.product_id

GROUP BY
p.product_id,
p.product_name;

-- =====================================================
-- VIEW 13 : ORDER SUMMARY VIEW
-- =====================================================

CREATE VIEW order_summary_view AS
SELECT
o.order_id,
c.full_name,
o.order_status,

```
COUNT(oi.order_item_id)
AS total_items,

o.total_amount
```

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

LEFT JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY
o.order_id,
c.full_name,
o.order_status,
o.total_amount;

-- =====================================================
-- VIEW 14 : REVENUE DASHBOARD VIEW
-- =====================================================

CREATE VIEW revenue_dashboard_view AS
SELECT

```
COUNT(DISTINCT order_id)
AS total_orders,

SUM(amount)
AS total_revenue,

ROUND(
    AVG(amount),
    2
) AS average_order_value
```

FROM payments
WHERE payment_status='Completed';

-- =====================================================
-- VIEW 15 : EXECUTIVE DASHBOARD VIEW
-- =====================================================

CREATE VIEW executive_dashboard_view AS
SELECT

```
(SELECT COUNT(*) FROM customers)
AS total_customers,

(SELECT COUNT(*) FROM products)
AS total_products,

(SELECT COUNT(*) FROM orders)
AS total_orders,

(SELECT SUM(amount)
 FROM payments
 WHERE payment_status='Completed')
AS total_revenue,

(SELECT COUNT(*)
 FROM reviews)
AS total_reviews;
```
