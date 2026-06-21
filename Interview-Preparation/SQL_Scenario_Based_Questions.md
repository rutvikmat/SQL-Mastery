# SQL Scenario Based Questions

## SQL-Mastery-Portfolio

---

# Introduction

This guide contains real-world SQL scenario-based interview questions commonly asked in:

* Software Engineer Interviews
* Backend Developer Interviews
* Data Analyst Interviews
* Data Engineer Interviews
* BI Developer Interviews
* FAANG SQL Interviews

These questions test:

* Problem Solving
* SQL Query Design
* Data Analysis Skills
* Business Understanding
* Query Optimization

---

# Table of Contents

1. Employee Management Scenarios
2. Sales & Revenue Scenarios
3. E-Commerce Scenarios
4. Banking Scenarios
5. Hospital Management Scenarios
6. HR Analytics Scenarios
7. Window Function Scenarios
8. Query Optimization Scenarios
9. Dashboard Scenarios
10. FAANG SQL Scenarios

---

# EMPLOYEE MANAGEMENT SCENARIOS

---

## Scenario 1

### Question

Find the second highest salary in the company.

### Solution

```sql
SELECT MAX(salary)
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);
```

### Concepts

* Subqueries
* Aggregate Functions

---

## Scenario 2

### Question

Find employees earning more than their manager.

### Solution

```sql
SELECT
e.full_name,
e.salary,
m.full_name AS manager_name,
m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;
```

### Concepts

* Self Join
* Comparison Logic

---

## Scenario 3

### Question

Find the top 3 highest paid employees from each department.

### Solution

```sql
WITH ranked_employees AS
(
    SELECT *,
    ROW_NUMBER() OVER
    (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS rn
    FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn <= 3;
```

### Concepts

* Window Functions
* ROW_NUMBER()

---

## Scenario 4

### Question

Find departments with no employees.

### Solution

```sql
SELECT *
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;
```

### Concepts

* LEFT JOIN
* NULL Filtering

---

## Scenario 5

### Question

Find duplicate employee email addresses.

### Solution

```sql
SELECT
email,
COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

---

# SALES & REVENUE SCENARIOS

---

## Scenario 6

### Question

Calculate monthly revenue.

### Solution

```sql
SELECT
DATE_TRUNC('month', sale_date) AS month,
SUM(revenue) AS total_revenue
FROM sales
GROUP BY month
ORDER BY month;
```

---

## Scenario 7

### Question

Calculate month-over-month revenue growth.

### Solution

```sql
WITH monthly_revenue AS
(
    SELECT
    DATE_TRUNC('month', sale_date) AS month,
    SUM(revenue) AS revenue
    FROM sales
    GROUP BY month
)

SELECT
month,
revenue,

LAG(revenue)
OVER(ORDER BY month) AS previous_revenue,

ROUND(
(
revenue -
LAG(revenue)
OVER(ORDER BY month)
) * 100.0
/
LAG(revenue)
OVER(ORDER BY month),
2
) AS growth_percentage

FROM monthly_revenue;
```

### Concepts

* LAG()
* Revenue Analytics

---

## Scenario 8

### Question

Find the best sales employee.

### Solution

```sql
SELECT
employee_id,
SUM(revenue) AS total_sales
FROM sales
GROUP BY employee_id
ORDER BY total_sales DESC
LIMIT 1;
```

---

## Scenario 9

### Question

Find top 5 months by revenue.

### Solution

```sql
SELECT
DATE_TRUNC('month', sale_date) AS month,
SUM(revenue) AS revenue
FROM sales
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;
```

---

## Scenario 10

### Question

Calculate revenue contribution by employee.

### Solution

```sql
SELECT
employee_id,
SUM(revenue),

ROUND(
100.0 *
SUM(revenue)
/
SUM(SUM(revenue)) OVER(),
2
)
AS contribution_percentage

FROM sales

GROUP BY employee_id;
```

---

# E-COMMERCE SCENARIOS

---

## Scenario 11

### Question

Find the top-selling product.

### Solution

```sql
SELECT
product_id,
SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 1;
```

---

## Scenario 12

### Question

Find customers who never placed an order.

### Solution

```sql
SELECT *
FROM customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

---

## Scenario 13

### Question

Find products never ordered.

### Solution

```sql
SELECT *
FROM products p
WHERE NOT EXISTS
(
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
```

---

## Scenario 14

### Question

Calculate customer lifetime value.

### Solution

```sql
SELECT
customer_id,
SUM(total_amount) AS customer_lifetime_value
FROM orders
GROUP BY customer_id
ORDER BY customer_lifetime_value DESC;
```

---

## Scenario 15

### Question

Find top 10 customers by spending.

### Solution

```sql
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;
```

---

# BANKING SCENARIOS

---

## Scenario 16

### Question

Transfer money between accounts using transaction.

### Solution

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;
```

---

## Scenario 17

### Question

Find accounts with negative balance.

### Solution

```sql
SELECT *
FROM accounts
WHERE balance < 0;
```

---

## Scenario 18

### Question

Find top account holders.

### Solution

```sql
SELECT
account_holder,
balance
FROM accounts
ORDER BY balance DESC;
```

---

# HOSPITAL MANAGEMENT SCENARIOS

---

## Scenario 19

### Question

Find doctors with highest patient count.

### Solution

```sql
SELECT
doctor_id,
COUNT(*) AS patient_count
FROM appointments
GROUP BY doctor_id
ORDER BY patient_count DESC;
```

---

## Scenario 20

### Question

Find patients with multiple visits.

### Solution

```sql
SELECT
patient_id,
COUNT(*) AS visits
FROM appointments
GROUP BY patient_id
HAVING COUNT(*) > 1;
```

---

# HR ANALYTICS SCENARIOS

---

## Scenario 21

### Question

Calculate employee retention.

### Solution

```sql
SELECT

department_id,

AVG(
EXTRACT(
YEAR FROM AGE(
CURRENT_DATE,
joining_date
)
)
)

AS average_tenure

FROM employees

GROUP BY department_id;
```

---

## Scenario 22

### Question

Find department with highest average salary.

### Solution

```sql
SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;
```

---

## Scenario 23

### Question

Find salary distribution bands.

### Solution

```sql
SELECT

CASE
WHEN salary < 50000 THEN 'Low'
WHEN salary < 100000 THEN 'Medium'
ELSE 'High'
END AS salary_band,

COUNT(*)

FROM employees

GROUP BY salary_band;
```

---

# WINDOW FUNCTION SCENARIOS

---

## Scenario 24

### Question

Rank employees by salary.

### Solution

```sql
SELECT
employee_id,
salary,

RANK()
OVER(
ORDER BY salary DESC
)
AS salary_rank

FROM employees;
```

---

## Scenario 25

### Question

Calculate running salary total.

### Solution

```sql
SELECT
employee_id,
salary,

SUM(salary)
OVER(
ORDER BY employee_id
)
AS running_total

FROM employees;
```

---

## Scenario 26

### Question

Calculate moving average salary.

### Solution

```sql
SELECT

employee_id,

AVG(salary)
OVER(
ORDER BY employee_id
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
)

AS moving_average

FROM employees;
```

---

# QUERY OPTIMIZATION SCENARIOS

---

## Scenario 27

### Question

How would you optimize a slow query?

### Answer

1. Analyze with EXPLAIN
2. Add indexes
3. Avoid SELECT *
4. Filter early
5. Rewrite subqueries

---

## Scenario 28

### Question

How do you identify missing indexes?

### Solution

```sql
EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE department_id = 1;
```

---

## Scenario 29

### Question

Create composite index.

### Solution

```sql
CREATE INDEX idx_dept_salary
ON employees
(
department_id,
salary
);
```

---

# DASHBOARD SCENARIOS

---

## Scenario 30

### Question

Build HR Dashboard.

### KPIs

* Total Employees
* Avg Salary
* Highest Salary
* Lowest Salary

### Solution

```sql
SELECT

COUNT(*) AS total_employees,

AVG(salary) AS avg_salary,

MAX(salary) AS highest_salary,

MIN(salary) AS lowest_salary

FROM employees;
```

---

## Scenario 31

### Question

Build Revenue Dashboard.

### Solution

```sql
SELECT

SUM(revenue) AS total_revenue,

AVG(revenue) AS avg_revenue,

COUNT(*) AS transactions

FROM sales;
```

---

## Scenario 32

### Question

Build Executive KPI Dashboard.

### Solution

```sql
SELECT

(SELECT COUNT(*) FROM employees)
AS total_employees,

(SELECT SUM(revenue) FROM sales)
AS total_revenue,

(SELECT COUNT(*) FROM projects)
AS active_projects;
```

---

# FAANG SQL SCENARIOS

---

## Amazon

1. Second Highest Salary
2. Running Totals
3. Top N Per Group
4. Duplicate Records

---

## Google

1. Recursive CTE
2. Query Optimization
3. Window Functions
4. Revenue Analytics

---

## Microsoft

1. Transactions
2. Indexing
3. Joins
4. Aggregations

---

## Meta

1. Ranking Problems
2. Employee Analytics
3. Growth Metrics

---

## Netflix

1. Retention Analysis
2. Time-Series Analytics
3. Dashboard Queries

---

# 20 Additional Practice Scenarios

1. Find inactive customers.
2. Find products with no sales.
3. Find best-selling category.
4. Find worst-selling category.
5. Calculate churn rate.
6. Calculate customer retention rate.
7. Calculate employee turnover.
8. Find top-performing departments.
9. Build project dashboard.
10. Build sales dashboard.
11. Find duplicate transactions.
12. Find fraudulent transactions.
13. Calculate average order value.
14. Calculate revenue per customer.
15. Calculate revenue per employee.
16. Generate workforce report.
17. Generate profitability report.
18. Generate quarterly dashboard.
19. Generate yearly dashboard.
20. Build enterprise KPI dashboard.

---

# Final Interview Checklist

## Fundamentals

* [ ] SELECT
* [ ] WHERE
* [ ] GROUP BY
* [ ] HAVING

## Intermediate

* [ ] JOINs
* [ ] Subqueries
* [ ] Views
* [ ] CTEs

## Advanced

* [ ] Window Functions
* [ ] Transactions
* [ ] Optimization

## Expert

* [ ] Analytics
* [ ] Dashboards
* [ ] Performance Tuning
* [ ] Enterprise Reporting

---

# Scenario-Based Interview Success Formula

```text
Business Problem
        +
SQL Logic
        +
Optimization
        +
Analytics
        +
Reporting
        =
SQL Interview Success
```

---

## Summary

* 32 Detailed Scenario Questions
* Real Business Use Cases
* HR Analytics
* E-Commerce Analytics
* Banking Scenarios
* Dashboard Queries
* FAANG-Level Problems
* Interview-Oriented Solutions

**Portfolio Status:** Scenario Interview Ready 🚀
