-- =====================================================
-- E-COMMERCE DATABASE SYSTEM
-- PRODUCTION LEVEL SCHEMA
-- PostgreSQL
-- =====================================================

-- =====================================================
-- CUSTOMERS
-- =====================================================

CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) UNIQUE,
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- CUSTOMER ADDRESSES
-- =====================================================

CREATE TABLE customer_addresses (
address_id SERIAL PRIMARY KEY,
customer_id INT NOT NULL,
address_line TEXT NOT NULL,
city VARCHAR(50),
state VARCHAR(50),
postal_code VARCHAR(20),
country VARCHAR(50),

```
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE
```

);

-- =====================================================
-- CATEGORIES
-- =====================================================

CREATE TABLE categories (
category_id SERIAL PRIMARY KEY,
category_name VARCHAR(100) UNIQUE NOT NULL,
description TEXT
);

-- =====================================================
-- BRANDS
-- =====================================================

CREATE TABLE brands (
brand_id SERIAL PRIMARY KEY,
brand_name VARCHAR(100) UNIQUE NOT NULL
);

-- =====================================================
-- SUPPLIERS
-- =====================================================

CREATE TABLE suppliers (
supplier_id SERIAL PRIMARY KEY,
supplier_name VARCHAR(100) NOT NULL,
contact_email VARCHAR(100),
phone VARCHAR(15)
);

-- =====================================================
-- PRODUCTS
-- =====================================================

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,

```
product_name VARCHAR(150) NOT NULL,

category_id INT NOT NULL,

brand_id INT,

supplier_id INT,

description TEXT,

price DECIMAL(12,2)
CHECK(price > 0),

stock_quantity INT DEFAULT 0
CHECK(stock_quantity >= 0),

is_active BOOLEAN DEFAULT TRUE,

created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(category_id)
REFERENCES categories(category_id),

FOREIGN KEY(brand_id)
REFERENCES brands(brand_id),

FOREIGN KEY(supplier_id)
REFERENCES suppliers(supplier_id)
```

);

-- =====================================================
-- INVENTORY
-- =====================================================

CREATE TABLE inventory (
inventory_id SERIAL PRIMARY KEY,

```
product_id INT UNIQUE,

stock_available INT NOT NULL,

reorder_level INT DEFAULT 10,

last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(product_id)
REFERENCES products(product_id)
ON DELETE CASCADE
```

);

-- =====================================================
-- COUPONS
-- =====================================================

CREATE TABLE coupons (
coupon_id SERIAL PRIMARY KEY,

```
coupon_code VARCHAR(30)
UNIQUE NOT NULL,

discount_percentage DECIMAL(5,2),

valid_from DATE,

valid_to DATE,

is_active BOOLEAN DEFAULT TRUE
```

);

-- =====================================================
-- ORDERS
-- =====================================================

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,

```
customer_id INT NOT NULL,

order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

order_status VARCHAR(30)
CHECK(
    order_status IN
    (
        'Pending',
        'Processing',
        'Shipped',
        'Delivered',
        'Cancelled'
    )
),

total_amount DECIMAL(12,2),

coupon_id INT,

FOREIGN KEY(customer_id)
REFERENCES customers(customer_id),

FOREIGN KEY(coupon_id)
REFERENCES coupons(coupon_id)
```

);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

CREATE TABLE order_items (
order_item_id SERIAL PRIMARY KEY,

```
order_id INT NOT NULL,

product_id INT NOT NULL,

quantity INT
CHECK(quantity > 0),

unit_price DECIMAL(12,2),

subtotal DECIMAL(12,2),

FOREIGN KEY(order_id)
REFERENCES orders(order_id)
ON DELETE CASCADE,

FOREIGN KEY(product_id)
REFERENCES products(product_id)
```

);

-- =====================================================
-- PAYMENTS
-- =====================================================

CREATE TABLE payments (
payment_id SERIAL PRIMARY KEY,

```
order_id INT UNIQUE,

amount DECIMAL(12,2),

payment_method VARCHAR(50),

payment_status VARCHAR(30)
CHECK(
    payment_status IN
    (
        'Pending',
        'Completed',
        'Failed',
        'Refunded'
    )
),

payment_date TIMESTAMP,

FOREIGN KEY(order_id)
REFERENCES orders(order_id)
```

);

-- =====================================================
-- SHIPPING
-- =====================================================

CREATE TABLE shipping (
shipping_id SERIAL PRIMARY KEY,

```
order_id INT UNIQUE,

tracking_number VARCHAR(100),

shipping_partner VARCHAR(100),

shipped_date DATE,

delivery_date DATE,

shipping_status VARCHAR(30),

FOREIGN KEY(order_id)
REFERENCES orders(order_id)
```

);

-- =====================================================
-- REVIEWS
-- =====================================================

CREATE TABLE reviews (
review_id SERIAL PRIMARY KEY,

```
customer_id INT,

product_id INT,

rating INT
CHECK(rating BETWEEN 1 AND 5),

review_text TEXT,

review_date TIMESTAMP
DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(customer_id)
REFERENCES customers(customer_id),

FOREIGN KEY(product_id)
REFERENCES products(product_id)
```

);

-- =====================================================
-- WISHLIST
-- =====================================================

CREATE TABLE wishlist (
wishlist_id SERIAL PRIMARY KEY,

```
customer_id INT,

product_id INT,

added_at TIMESTAMP
DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(customer_id)
REFERENCES customers(customer_id),

FOREIGN KEY(product_id)
REFERENCES products(product_id)
```

);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_customer_email
ON customers(email);

CREATE INDEX idx_product_name
ON products(product_name);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_payment_status
ON payments(payment_status);

CREATE INDEX idx_review_rating
ON reviews(rating);

-- =====================================================
-- USEFUL COMMENTS
-- =====================================================

## -- Total Tables: 13

-- customers
-- customer_addresses
-- categories
-- brands
-- suppliers
-- products
-- inventory
-- coupons
-- orders
-- order_items
-- payments
-- shipping
-- reviews
-- wishlist
-----------

-- Covers:
-- Customer Management
-- Product Catalog
-- Inventory Management
-- Order Processing
-- Payment Processing
-- Shipping Tracking
-- Reviews & Ratings
-- Coupons & Discounts
-- Wishlist Management
-- Business Analytics
