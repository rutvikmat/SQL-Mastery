-- ==========================================
-- DAY 01 SOLUTIONS
-- ==========================================

CREATE DATABASE company_db;

CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(100)
);

INSERT INTO employees VALUES
(1,'John',50000,'IT'),
(2,'Emma',60000,'HR'),
(3,'David',55000,'Finance'),
(4,'Sophia',70000,'IT'),
(5,'Michael',65000,'Marketing');

SELECT * FROM employees;

SELECT name FROM employees;

SELECT name,salary
FROM employees;

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(101,'Laptop',75000),
(102,'Mouse',500),
(103,'Keyboard',1500),
(104,'Monitor',12000),
(105,'Headphones',2500);

SELECT * FROM products;

SELECT product_name
FROM products;