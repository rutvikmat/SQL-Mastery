-- =====================================================
-- CUSTOMERS
-- =====================================================

INSERT INTO customers
(full_name,email,phone,city,state,country)
VALUES
('Rutvik Mathapati','[rutvik@gmail.com](mailto:rutvik@gmail.com)','9876543210','Bangalore','Karnataka','India'),
('Kavya Bhavikatti','[kavya@gmail.com](mailto:kavya@gmail.com)','9876543211','Hubli','Karnataka','India'),
('Arjun Kumar','[arjun@gmail.com](mailto:arjun@gmail.com)','9876543212','Mysore','Karnataka','India'),
('Sneha Rao','[sneha@gmail.com](mailto:sneha@gmail.com)','9876543213','Bangalore','Karnataka','India'),
('Rahul Patil','[rahul@gmail.com](mailto:rahul@gmail.com)','9876543214','Belgaum','Karnataka','India'),
('Ananya Sharma','[ananya@gmail.com](mailto:ananya@gmail.com)','9876543215','Delhi','Delhi','India'),
('Vikram Joshi','[vikram@gmail.com](mailto:vikram@gmail.com)','9876543216','Pune','Maharashtra','India'),
('Neha Singh','[neha@gmail.com](mailto:neha@gmail.com)','9876543217','Mumbai','Maharashtra','India'),
('Kiran Verma','[kiran@gmail.com](mailto:kiran@gmail.com)','9876543218','Hyderabad','Telangana','India'),
('Pooja Reddy','[pooja@gmail.com](mailto:pooja@gmail.com)','9876543219','Chennai','Tamil Nadu','India');

-- =====================================================
-- CUSTOMER ADDRESSES
-- =====================================================

INSERT INTO customer_addresses
(customer_id,address_line,city,state,postal_code,country)
VALUES
(1,'HSR Layout','Bangalore','Karnataka','560102','India'),
(2,'Vidyanagar','Hubli','Karnataka','580021','India'),
(3,'Vijayanagar','Mysore','Karnataka','570001','India'),
(4,'Whitefield','Bangalore','Karnataka','560066','India'),
(5,'Tilakwadi','Belgaum','Karnataka','590006','India');

-- =====================================================
-- CATEGORIES
-- =====================================================

INSERT INTO categories
(category_name,description)
VALUES
('Electronics','Electronic Devices'),
('Fashion','Clothing & Accessories'),
('Books','Books & Learning'),
('Home Appliances','Home Products'),
('Sports','Sports Equipment');

-- =====================================================
-- BRANDS
-- =====================================================

INSERT INTO brands
(brand_name)
VALUES
('Apple'),
('Samsung'),
('Dell'),
('Nike'),
('Adidas'),
('Sony'),
('HP');

-- =====================================================
-- SUPPLIERS
-- =====================================================

INSERT INTO suppliers
(supplier_name,contact_email,phone)
VALUES
('Tech Distributors','[tech@supplier.com](mailto:tech@supplier.com)','9000000001'),
('Fashion Hub','[fashion@supplier.com](mailto:fashion@supplier.com)','9000000002'),
('Book World','[books@supplier.com](mailto:books@supplier.com)','9000000003'),
('Sports Arena','[sports@supplier.com](mailto:sports@supplier.com)','9000000004');

-- =====================================================
-- PRODUCTS
-- =====================================================

INSERT INTO products
(
product_name,
category_id,
brand_id,
supplier_id,
description,
price,
stock_quantity
)
VALUES

('MacBook Air M3',1,1,1,'Apple Laptop',120000,25),
('iPhone 16',1,1,1,'Apple Smartphone',90000,50),
('Samsung Galaxy S25',1,2,1,'Samsung Smartphone',85000,40),
('Dell XPS 15',1,3,1,'Dell Laptop',140000,20),
('Sony WH1000XM5',1,6,1,'Wireless Headphones',25000,100),

('Nike Running Shoes',2,4,2,'Running Shoes',5000,150),
('Adidas Hoodie',2,5,2,'Premium Hoodie',3500,120),

('Python Programming Book',3,NULL,3,'Learn Python',899,200),
('SQL Mastery Book',3,NULL,3,'Advanced SQL',999,150),

('Air Fryer',4,NULL,1,'Kitchen Appliance',8000,80),

('Cricket Bat',5,NULL,4,'Professional Bat',4500,75);

-- =====================================================
-- INVENTORY
-- =====================================================

INSERT INTO inventory
(product_id,stock_available,reorder_level)
VALUES
(1,25,5),
(2,50,10),
(3,40,10),
(4,20,5),
(5,100,20),
(6,150,30),
(7,120,20),
(8,200,50),
(9,150,50),
(10,80,15),
(11,75,15);

-- =====================================================
-- COUPONS
-- =====================================================

INSERT INTO coupons
(
coupon_code,
discount_percentage,
valid_from,
valid_to
)
VALUES
('WELCOME10',10,'2025-01-01','2025-12-31'),
('FESTIVE20',20,'2025-06-01','2025-12-31'),
('NEWUSER15',15,'2025-01-01','2025-12-31');

-- =====================================================
-- ORDERS
-- =====================================================

INSERT INTO orders
(
customer_id,
order_status,
total_amount,
coupon_id
)
VALUES
(1,'Delivered',120000,1),
(2,'Delivered',90000,1),
(3,'Shipped',25000,NULL),
(4,'Processing',5000,NULL),
(5,'Delivered',899,NULL),
(6,'Delivered',8000,2),
(7,'Delivered',4500,NULL),
(8,'Shipped',3500,NULL),
(9,'Processing',140000,2),
(10,'Delivered',999,NULL);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

INSERT INTO order_items
(
order_id,
product_id,
quantity,
unit_price,
subtotal
)
VALUES
(1,1,1,120000,120000),
(2,2,1,90000,90000),
(3,5,1,25000,25000),
(4,6,1,5000,5000),
(5,8,1,899,899),
(6,10,1,8000,8000),
(7,11,1,4500,4500),
(8,7,1,3500,3500),
(9,4,1,140000,140000),
(10,9,1,999,999);

-- =====================================================
-- PAYMENTS
-- =====================================================

INSERT INTO payments
(
order_id,
amount,
payment_method,
payment_status,
payment_date
)
VALUES
(1,120000,'UPI','Completed','2025-01-10'),
(2,90000,'Credit Card','Completed','2025-01-11'),
(3,25000,'UPI','Completed','2025-01-12'),
(4,5000,'Debit Card','Completed','2025-01-13'),
(5,899,'UPI','Completed','2025-01-14'),
(6,8000,'Net Banking','Completed','2025-01-15'),
(7,4500,'UPI','Completed','2025-01-16'),
(8,3500,'Credit Card','Completed','2025-01-17'),
(9,140000,'UPI','Completed','2025-01-18'),
(10,999,'Debit Card','Completed','2025-01-19');

-- =====================================================
-- SHIPPING
-- =====================================================

INSERT INTO shipping
(
order_id,
tracking_number,
shipping_partner,
shipped_date,
delivery_date,
shipping_status
)
VALUES
(1,'TRK1001','Delhivery','2025-01-10','2025-01-12','Delivered'),
(2,'TRK1002','BlueDart','2025-01-11','2025-01-13','Delivered'),
(3,'TRK1003','Ekart','2025-01-12',NULL,'In Transit'),
(4,'TRK1004','Delhivery',NULL,NULL,'Processing');

-- =====================================================
-- REVIEWS
-- =====================================================

INSERT INTO reviews
(
customer_id,
product_id,
rating,
review_text
)
VALUES
(1,1,5,'Excellent laptop'),
(2,2,5,'Amazing phone'),
(3,5,4,'Great sound quality'),
(4,6,4,'Comfortable shoes'),
(5,8,5,'Very useful book'),
(6,10,4,'Good appliance'),
(7,11,5,'Excellent bat'),
(8,7,4,'Nice hoodie');

-- =====================================================
-- WISHLIST
-- =====================================================

INSERT INTO wishlist
(
customer_id,
product_id
)
VALUES
(1,4),
(1,5),
(2,1),
(3,2),
(4,10),
(5,11),
(6,1),
(7,4),
(8,6),
(9,3);
