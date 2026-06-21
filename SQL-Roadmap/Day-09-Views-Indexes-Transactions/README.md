# Day 09 - Views, Indexes & Transactions

## Learning Objectives

By the end of Day 09 you will be able to:

* Create Views
* Use Views for Reporting
* Create Indexes
* Improve Query Performance
* Understand Transactions
* Use COMMIT and ROLLBACK
* Understand ACID Properties
* Handle Database Failures Safely

---

# What is a View?

A View is a virtual table based on a SQL query.

Think of it as a saved query.

---

# Why Use Views?

Suppose every day you need:

```sql
SELECT emp_name,
       salary
FROM employees
WHERE department='IT';
```

Instead of writing it repeatedly:

```sql
CREATE VIEW it_employees AS
SELECT emp_name,
       salary
FROM employees
WHERE department='IT';
```

Now use:

```sql
SELECT *
FROM it_employees;
```

---

# View Example

```sql
CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 70000;
```

Use:

```sql
SELECT *
FROM high_salary_employees;
```

---

# Updating a View

```sql
CREATE OR REPLACE VIEW
high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 80000;
```

---

# Dropping a View

```sql
DROP VIEW high_salary_employees;
```

---

# Materialized Views

Normal View:

Runs query every time.

Materialized View:

Stores result physically.

```sql
CREATE MATERIALIZED VIEW employee_report AS
SELECT department,
       AVG(salary)
FROM employees
GROUP BY department;
```

Refresh:

```sql
REFRESH MATERIALIZED VIEW employee_report;
```

---

# What is an Index?

An Index improves query performance.

Without Index:

Database scans every row.

With Index:

Database quickly finds matching rows.

---

# Example

```sql
CREATE INDEX idx_employee_email
ON employees(email);
```

---

# Why Indexes Matter?

Table:

```text
10 Records → Fast
100 Records → Fast
10,000 Records → Slower
1,000,000 Records → Much Slower
```

Indexes become critical as data grows.

---

# Common Index Types

## B-Tree

Default PostgreSQL index.

```sql
CREATE INDEX idx_name
ON employees(emp_name);
```

---

## Unique Index

```sql
CREATE UNIQUE INDEX idx_email
ON employees(email);
```

---

# Query Optimization Basics

Bad:

```sql
SELECT *
FROM employees;
```

Good:

```sql
SELECT emp_name,
       salary
FROM employees;
```

Only retrieve required columns.

---

# Transactions

A transaction is a group of SQL operations executed together.

Example:

Bank Transfer

Step 1:

Withdraw ₹1000

Step 2:

Deposit ₹1000

Both must succeed.

---

# Transaction Example

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;
```

---

# COMMIT

Permanently saves changes.

```sql
COMMIT;
```

---

# ROLLBACK

Undo changes.

```sql
ROLLBACK;
```

---

# SAVEPOINT

Create checkpoints.

```sql
BEGIN;

SAVEPOINT step1;

UPDATE accounts
SET balance = balance - 500;

ROLLBACK TO step1;

COMMIT;
```

---

# ACID Properties

A → Atomicity

C → Consistency

I → Isolation

D → Durability

---

# Atomicity

All operations succeed or none.

---

# Consistency

Database remains valid.

---

# Isolation

Transactions don't interfere.

---

# Durability

Committed data survives crashes.

---

# Real World Example

Syncher AI

User updates:

* Symptoms
* Cycle Data
* Predictions

All updates should succeed together.

Transaction ensures this.

---

# Skills Acquired

✅ Views

✅ Materialized Views

✅ Indexes

✅ Transactions

✅ ACID

✅ Query Performance

---

# Next Topic

Day 10 - Advanced SQL
Window Functions | CTE | Recursive Queries
